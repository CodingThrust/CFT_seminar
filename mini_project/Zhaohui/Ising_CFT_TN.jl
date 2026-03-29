using ITensors
using ITensorMPS
using LinearAlgebra
using Plots, LsqFit, LaTeXStrings
using JLD2
ITensors.disable_warn_order()
# ============================================================
# 2D Classical Ising model partition function with ITensor
#
# Hamiltonian (classical):
#   E[s] = -J * sum_{<ij>} s_i s_j,   s_i = ±1
#
# Partition function:
#   Z = sum_{ {s} } exp(beta * J * sum_{<ij>} s_i s_j)
#
# This code contracts the corresponding 2D tensor network with a
# boundary MPS / row-MPO algorithm (open boundary in x and y).
# ============================================================

"""
    ising_bond_center(betaJ)

Return a matrix `W` such that
`exp(betaJ * s * s') / exp(betaJ) = sum_a W[s,a] * W[s',a]`
for `s,s' in {+1,-1}`.

That is, we factor out one `exp(betaJ)` from each Ising bond.
"""
function ising_bond_center(betaJ::Real)
    # Centered bond matrix: M_center = M / exp(betaJ)
    # = [1  exp(-2betaJ);
    #    exp(-2betaJ) 1]
    x = exp(-2 * betaJ)
    M = [1.0 x;
         x 1.0]
	ev = eigen(Symmetric(M))
	# W * W' = M
	W = ev.vectors * Diagonal(sqrt.(ev.values))
	return W
end

"""
Build the local tensor at one lattice site:

T(l,r,d,u) = sum_s Wl[s,l] Wr[s,r] Wd[s,d] Wu[s,u]

Any boundary leg can have dim=1 (then corresponding W is all ones).
"""
function local_site_tensor(l::Index, r::Index, d::Index, u::Index, W::AbstractMatrix{<:Real})
	T = ITensor(l, r, d, u)

	# Direction-dependent factors (dim-2 => Ising bond factor, dim-1 => no bond)
	Wl = dim(l) == 2 ? W : ones(2, 1)
	Wr = dim(r) == 2 ? W : ones(2, 1)
	Wd = dim(d) == 2 ? W : ones(2, 1)
	Wu = dim(u) == 2 ? W : ones(2, 1)

	for il in 1:dim(l), ir in 1:dim(r), id in 1:dim(d), iu in 1:dim(u)
		val = 0.0
		for s in 1:2
			val += Wl[s, il] * Wr[s, ir] * Wd[s, id] * Wu[s, iu]
		end
		T[l => il, r => ir, d => id, u => iu] = val
	end
	return T
end

"""
Apply MPO to MPS with incremental normalization to avoid overflow.
Returns (result_MPS, log_norm) where result is normalized and log_norm
tracks the accumulated log of normalization factors.
"""
function apply_mpo_normalized(Wrow::MPO, psi::MPS; cutoff::Real=1e-12, maxdim::Int=200)
    N = length(psi)
    log_norm = 0.0
    
    # Contract MPO with MPS to get a new MPS
    # We'll do this by first contracting all MPO-MPS pairs, then re-orthogonalizing
    contracted = Vector{ITensor}(undef, N)
    for j in 1:N
        contracted[j] = psi[j] * Wrow[j]
        # Normalize each contracted tensor immediately
        tnrm = norm(contracted[j])
        if tnrm > 1e-15
            contracted[j] ./= tnrm
            log_norm += log(tnrm)
        end
    end
    
    # Now we need to compress this back to an MPS with bounded bond dimension
    # Build the MPS and use truncation
    result = MPS(contracted)
    
    # Truncate using SVD sweeps - do right-to-left then left-to-right
    for j in N:-1:2
        # Get the tensor and indices
        T = result[j]
        # Find the link index connecting to site j-1
        linds = commoninds(T, result[j-1])
        if length(linds) == 0
            continue
        end
        
        # Do SVD to separate and truncate
        rinds = uniqueinds(T, result[j-1])
        U, S, V = svd(T, rinds; cutoff=cutoff, maxdim=maxdim)
        
        # Normalize S to prevent overflow
        snrm = norm(S)
        if snrm > 1e-15
            S ./= snrm
            log_norm += log(snrm)
        end
        
        result[j] = U
        result[j-1] = result[j-1] * S * V
        
        # Normalize the updated tensor
        tnrm = norm(result[j-1])
        if tnrm > 1e-15
            result[j-1] ./= tnrm
            log_norm += log(tnrm)
        end
    end
    
    # Final left-to-right sweep for proper form
    for j in 1:N-1
        T = result[j]
        rinds = uniqueinds(T, result[j+1])
        if length(rinds) == 0
            linds = inds(T)
            rinds = [linds[1]]
        end
        
        U, S, V = svd(T, rinds; cutoff=cutoff, maxdim=maxdim)
        
        snrm = norm(S)
        if snrm > 1e-15
            S ./= snrm
            log_norm += log(snrm)
        end
        
        result[j] = U
        result[j+1] = S * V * result[j+1]
        
        tnrm = norm(result[j+1])
        if tnrm > 1e-15
            result[j+1] ./= tnrm
            log_norm += log(tnrm)
        end
    end
    
    return result, log_norm
end

"""
	ising_partition_function(Lx, Ly; beta=1.0, J=1.0, cutoff=1e-12, maxdim=200)

Compute the 2D Ising partition function on an `Lx x Ly` square lattice
with open boundary conditions using boundary-MPS contraction.
"""
function ising_partition_function_logZ(Lx::Int, Ly::Int; beta::Real=1.0, J::Real=1.0, cutoff::Real=1e-12, maxdim::Int=200, pbc::Bool=false)
	@assert Lx >= 1 && Ly >= 1
	betaJ = beta * J
    W = ising_bond_center(betaJ)
    
    # Accumulate log of normalization factors to avoid overflow
    log_norm_total = 0.0

    mps_tensors = Vector{ITensor}(undef, Lx)
    if pbc
        # Add periodic boundary links
        h = [Index(2, "h,$x,$y") for x in 1:Lx, y in 1:Ly]
        v = [Index(2, "v,$x,$y") for x in 1:Lx, y in 1:Ly-1]
        for x in 1:Lx
            l = h[x == 1 ? Lx : x - 1, 1]
            r = h[x, 1]
            d = Index(1, "db,$x,1")
            u = Ly == 1 ? Index(1, "ub,$x,1") : v[x, 1]
            A1 = local_site_tensor(l, r, d, u, W)
            fixd = ITensor(d)
            fixd[d => 1] = 1.0
            mps_tensors[x] = A1 * fixd
        end
        boundary = MPS(mps_tensors)
        
        # Normalize initial MPS
        nrm = norm(boundary)
        if nrm > 0
            boundary ./= nrm
            log_norm_total += log(nrm)
        end
    
        for y in 2:Ly
            mpo_tensors = Vector{ITensor}(undef, Lx)
            for x in 1:Lx
                l = h[x == 1 ? Lx : x - 1, y]
                r = h[x, y]
                d = v[x, y - 1]
                u = y == Ly ? Index(1, "ub,$x,$y") : v[x, y]
                mpo_tensors[x] = local_site_tensor(l, r, d, u, W)
            end
            
            # Normalize each MPO tensor to prevent overflow during apply
            for x in 1:Lx
                tnrm = norm(mpo_tensors[x])
                if tnrm > 0
                    mpo_tensors[x] ./= tnrm
                    log_norm_total += log(tnrm)
                end
            end
            
            Wrow = MPO(mpo_tensors)
            boundary = apply(Wrow, boundary; cutoff=cutoff, maxdim=maxdim)
            
            # Normalize MPS after each row
            nrm = norm(boundary)
            if nrm > 0
                boundary ./= nrm
                log_norm_total += log(nrm)
            end
        end

        # Contract final boundary MPS to scalar
        Zt = boundary[1]
        for x in 2:Lx
            Zt *= boundary[x]
        end
        for i in inds(Zt)
            if dim(i) == 1
                v1 = ITensor(i)
                v1[i => 1] = 1.0
                Zt *= v1
            end
        end
    else
        # Horizontal internal links h[x,y], x=1..Lx-1, y=1..Ly
        h = [Index(2, "h,$x,$y") for x in 1:max(Lx - 1, 1), y in 1:Ly]
        # Vertical internal links v[x,y], x=1..Lx, y=1..Ly-1
        v = [Index(2, "v,$x,$y") for x in 1:Lx, y in 1:max(Ly - 1, 1)]
        
        # First row -> boundary MPS
        for x in 1:Lx
            l = x == 1  ? Index(1, "lb,$x,1") : h[x - 1, 1]
            r = x == Lx ? Index(1, "rb,$x,1") : h[x, 1]
            d = Index(1, "db,$x,1")
            u = Ly == 1 ? Index(1, "ub,$x,1") : v[x, 1]
    
            A1 = local_site_tensor(l, r, d, u, W)
            fixd = ITensor(d)
            fixd[d => 1] = 1.0
            mps_tensors[x] = A1 * fixd
        end
        boundary = MPS(mps_tensors)
        
        # Normalize initial MPS
        nrm = norm(boundary)
        if nrm > 0
            boundary ./= nrm
            log_norm_total += log(nrm)
        end
    
        # Rows y=2..Ly are MPOs acting on boundary MPS
        for y in 2:Ly
            mpo_tensors = Vector{ITensor}(undef, Lx)
            for x in 1:Lx
                l = x == 1  ? Index(1, "lb,$x,$y") : h[x - 1, y]
                r = x == Lx ? Index(1, "rb,$x,$y") : h[x, y]
                d = v[x, y - 1]
                u = y == Ly ? Index(1, "ub,$x,$y") : v[x, y]
                mpo_tensors[x] = local_site_tensor(l, r, d, u, W)
            end
            
            # Normalize each MPO tensor to prevent overflow during apply
            for x in 1:Lx
                tnrm = norm(mpo_tensors[x])
                if tnrm > 0
                    mpo_tensors[x] ./= tnrm
                    log_norm_total += log(tnrm)
                end
            end
            
            Wrow = MPO(mpo_tensors)
            boundary = apply(Wrow, boundary; cutoff=cutoff, maxdim=maxdim)
            
            # Normalize MPS after each row
            nrm = norm(boundary)
            if nrm > 0
                boundary ./= nrm
                log_norm_total += log(nrm)
            end
        end
    
        # Convert final boundary MPS to scalar
        Zt = boundary[1]
        for x in 2:Lx
            Zt *= boundary[x]
        end
    
        # Contract remaining dim-1 indices
        for i in inds(Zt)
            if dim(i) == 1
                v1 = ITensor(i)
                v1[i => 1] = 1.0
                Zt *= v1
            end
        end
    end

    # Return log(Z_centered) = log(final_scalar) + accumulated log norms
	return log(abs(scalar(Zt))) + log_norm_total
end

"""
    ising_bond_count(Lx, Ly; pbc=false)

Number of nearest-neighbor bonds used in the tensor network.
`pbc=true` means periodic boundary only in x-direction (cylinder).
"""
function ising_bond_count(Lx::Int, Ly::Int; pbc::Bool=false)
    if pbc
        # horizontal bonds: Lx * Ly (periodic in x)
        # vertical bonds:   Lx * (Ly - 1) (open in y)
        return Lx * Ly + Lx * (Ly - 1)
    else
        # open in x and y
        return (Lx - 1) * Ly + Lx * (Ly - 1)
    end
end

"""
    ising_logZ(Lx, Ly; beta=1.0, J=1.0, cutoff=1e-12, maxdim=200, pbc=false, centered=true)

Compute log(Z). If `centered=true`, returns
log(Z_centered) = log(Z) - N_bonds * beta * J,
which is numerically more stable.
"""
function ising_logZ(Lx::Int, Ly::Int; beta::Real=1.0, J::Real=1.0,
                     cutoff::Real=1e-12, maxdim::Int=200, pbc::Bool=false,
                     centered::Bool=true)
    # Use the overflow-safe version that returns log(Z) directly
    logZc = ising_partition_function_logZ(Lx, Ly; beta=beta, J=J, cutoff=cutoff, maxdim=maxdim, pbc=pbc)
    if centered
        return logZc
    else
        Nb = ising_bond_count(Lx, Ly; pbc=pbc)
        return logZc + Nb * beta * J
    end
end

# ---------------- Example ----------------
function FE_scaling(Llist)
    flis = zeros(length(Llist))
    time_ratio = 100
    for (idx, L) in enumerate(Llist)
        K = log(1+√2)/2
        # centered logZ (i.e. logZ - N_bonds*K), avoids overflow growth
        logZc = ising_logZ(L, time_ratio *L; beta=K, J=1.0, cutoff=1e-10, maxdim=100, pbc=true, centered=true)

        # If you want the physical logZ, add back N_bonds*K:
        # logZc = ising_logZ(L, time_ratio * L; beta=K, J=1.0, cutoff=1e-10, maxdim=100, pbc=true, centered=false)

        # Keep the centered free-energy-like quantity for scaling analysis
        f = -logZc / (L * time_ratio * L)  # Free energy density (centered)
        flis[idx] = f
        println("L = $L, logZ_centered = $logZc, centered f = $f")
    end

    return flis
end

Llist = collect(6:10)
flis = FE_scaling(Llist)
function fig_FE_scaling(flis, Llist)
    time_ratio = 100
    fig = scatter(1 ./(Llist.^2), flis, label="Free energy density", xlabel=L"1/L^2", ylabel=L"F/(L \cdot L_\tau)")
    fit_model(x, p) = p[1] .- π/6*p[2] .*x
    p0 = [1.0, 1.0]
    fit = curve_fit(fit_model, 1 ./(Llist.^2), flis, p0)
    println("Fitting parameters: ", fit.param)
    x_fit = range(0, stop=1 ./ minimum(Llist).^2, length=100)
    plot!(x_fit, fit_model(x_fit, fit.param), label="Fit: " * latexstring("F/(L \\cdot L_\\tau) = f_\\infty - \\frac{\\pi c}{6 L^2},\\ c = $(round(fit.param[2], digits=4))"), linestyle=:dash)

    return fig
end

fig_FE=fig_FE_scaling(flis, Llist)