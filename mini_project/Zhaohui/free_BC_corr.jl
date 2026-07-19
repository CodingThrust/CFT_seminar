using SparseArrays, LinearAlgebra, Arpack, Statistics
using Plots, LsqFit

⊗(A::AbstractArray, B::AbstractArray) = kron(A, B)

# Critical transverse-field Ising chain, OPEN boundaries (= free BC in BCFT)
function Ising_Hamiltonian(L)
    X = sparse([0 1; 1 0])
    Z = sparse([1 0; 0 -1])
    Id = sparse([1 0; 0 1])

    H = spzeros(Float64, 2^L, 2^L)
    for i in 1:L
        cup = fill(Id, L)
        cup[i] = X
        H -= foldr(⊗, cup)
    end

    for j in 1:L-1
        cup = fill(Id, L)
        cup[[j, j+1]] = [Z, Z]
        H -= foldr(⊗, cup)
    end
    return H   # free BC: no closing Z_1 Z_L term
end

function Xop(site_id, L)
    Id = sparse([1 0; 0 1])
    X = sparse([0 1; 1 0])

    cup = fill(Id, L)
    cup[site_id] = X
    return foldr(⊗, cup)
end

function ground_state(L)
    H = Ising_Hamiltonian(L)
    energy, states = eigs(H, nev=1, which=:SR)
    return states[:, 1]
end

# One-point function <sigma^x_i>: on the lattice sigma^x = identity + energy
# operator epsilon (scaling dimension Delta_epsilon = 1), so its profile shows
# the BCFT one-point function of epsilon on top of a constant.
function X_profile(L)
    GS = ground_state(L)
    return [real(GS' * (Xop(i, L) * GS)) for i in 1:L]
end

# BCFT: one-point function on a strip of width L with free BC on both sides:
#   <phi(x)> = A * [ (L/pi) sin(pi x / L) ]^{-Delta}
# With the lattice operator mixing:
#   <X(x)> = c + A * [ (L/pi) sin(pi x / L) ]^{-Delta}
# Fix c to the known bulk energy density <sigma^x> = 2/pi at criticality;
# a free 3-parameter fit on few points is degenerate.
c_bulk = 2 / π

function fit_Delta(L)
    Xlis = X_profile(L)
    x = collect(1:L)
    strip(x) = (L / π) * sin.(π .* x ./ L)
    model(x, p) = c_bulk .+ p[1] .* strip(x) .^ (-p[2])
    fit_range = 3:L-2   # drop 2 outermost sites (lattice boundary artifacts)
    fit = curve_fit(model, x[fit_range], Xlis[fit_range], [0.1, 1.0])
    return fit.param[2], Xlis, model, fit.param
end

Ls = [10, 12, 14, 16]
Δs = zeros(length(Ls))
results = Dict{Int,Tuple{Vector{Float64},Function,Vector{Float64}}}()
for (k, L) in enumerate(Ls)
    Δ, Xlis, model, param = fit_Delta(L)
    Δs[k] = Δ
    results[L] = (Xlis, x -> model(x, param), param)
    println("L = $L :  Δ = $(round(Δ, digits=4))")
end

# Finite-size extrapolation of the fitted exponent, linear in 1/L
invL = 1.0 ./ Ls
slope = (invL .- mean(invL)) ⋅ (Δs .- mean(Δs)) / sum((invL .- mean(invL)) .^ 2)
Δ_extrap = mean(Δs) - slope * mean(invL)
println("extrapolated Δ(L->inf) = ", round(Δ_extrap, digits=3),
    "  (BCFT prediction for epsilon: 1)")

# Plot 1: profile and BCFT fit for the largest system
L = Ls[end]
Xlis, model_full, _ = results[L]
x = collect(1:L)
xf = range(3, L - 2, length=200)   # stay inside the fitted range (fit diverges at edges)
p1 = plot(x, Xlis, seriestype=:scatter, label="exact diag data",
    xlabel="site x", ylabel="<sigma^x>", title="One-point function, free BC, L=$L")
plot!(p1, xf, model_full(xf),
    label="BCFT fit: 2/π + A[(L/π)sin(πx/L)]^{-Δ}, Δ=$(round(Δs[end], digits=3))")
savefig(p1, joinpath(@__DIR__, "free_BC_onepoint_fit.png"))

# Plot 2: fitted exponent vs 1/L with linear extrapolation
p2 = plot(invL, Δs, seriestype=:scatter, label="fitted Δ(L)",
    xlabel="1/L", ylabel="Δ", title="Finite-size extrapolation",
    xlims=(0, maximum(invL) * 1.1), ylims=(0.5, 1.15))
plot!(p2, [0, maximum(invL) * 1.1], [Δ_extrap, Δ_extrap + slope * maximum(invL) * 1.1],
    label="linear fit in 1/L")
hline!(p2, [1.0], linestyle=:dash, label="BCFT: Δ_ε = 1")
plot!(p2, [0], [Δ_extrap], seriestype=:scatter, markershape=:star,
    label="extrapolated Δ = $(round(Δ_extrap, digits=3))")
savefig(p2, joinpath(@__DIR__, "free_BC_extrapolation.png"))
display(plot(p1, p2, layout=(1, 2), size=(1000, 400)))
