using SparseArrays, LinearAlgebra, Arpack, Statistics
using Plots, LsqFit

⊗(A::AbstractArray, B::AbstractArray) = kron(A, B)

# Critical transverse-field Ising chain, PERIODIC boundaries
function Ising_Hamiltonian_PBC(L)
    X = sparse([0 1; 1 0])
    Z = sparse([1 0; 0 -1])
    Id = sparse([1 0; 0 1])

    H = spzeros(Float64, 2^L, 2^L)
    for i in 1:L
        cup = fill(Id, L)
        cup[i] = X
        H -= foldr(⊗, cup)
    end
    for j in 1:L
        cup = fill(Id, L)
        cup[j] = Z
        cup[mod1(j + 1, L)] = Z
        H -= foldr(⊗, cup)
    end
    return H
end

function single_op(op, site_id, L)
    Id = sparse([1 0; 0 1])
    cup = fill(Id, L)
    cup[site_id] = op
    return foldr(⊗, cup)
end

function ground_state(L)
    H = Ising_Hamiltonian_PBC(L)
    energy, states = eigs(H, nev=1, which=:SR)
    return states[:, 1]
end

# Connected two-point functions, translation-averaged:
#   C_AA(r) = <A_i A_{i+r}> - <A_i><A_{i+r}>
function corr_profile(L, op)
    GS = ground_state(L)
    ops = [single_op(op, i, L) for i in 1:L]
    av = [real(GS' * (ops[i] * GS)) for i in 1:L]
    C = zeros(L ÷ 2)
    for r in 1:L÷2
        s = 0.0
        for i in 1:L
            j = mod1(i + r, L)
            s += real(GS' * (ops[i] * (ops[j] * GS))) - av[i] * av[j]
        end
        C[r] = s / L
    end
    return C
end

# CFT: two-point function of a primary on a ring of circumference L:
#   <ϕ(r) ϕ(0)> = A * [ (L/π) sin(πr / L) ]^{-2 Δ}
function fit_Delta(L, op)
    C = corr_profile(L, op)
    r = collect(1:L÷2)
    chord(r) = (L / π) * sin.(π .* r ./ L)
    model(r, p) = p[1] .* chord(r) .^ (-2 * p[2])
    fit_range = 2:L÷2   # drop r = 1 (short-distance lattice artifact)
    fit = curve_fit(model, r[fit_range], abs.(C[fit_range]), [1.0, 0.5])
    return fit.param[2], C, model, fit.param
end

X = sparse([0 1; 1 0])
Z = sparse([1 0; 0 -1])
Ls = [10, 12, 14, 16]

plots = []
for (op, name, Δ_exact) in [(Z, "ZZ", 0.125), (X, "XX", 1.0)]
    Δs = zeros(length(Ls))
    results = Dict{Int,Tuple{Vector{Float64},Function}}()
    for (k, L) in enumerate(Ls)
        Δ, C, model, param = fit_Delta(L, op)
        Δs[k] = Δ
        results[L] = (C, r -> model(r, param))
        println("$name, L = $L :  Δ = $(round(Δ, digits=4))")
    end

    invL = 1.0 ./ Ls
    slope = (invL .- mean(invL)) ⋅ (Δs .- mean(Δs)) / sum((invL .- mean(invL)) .^ 2)
    Δ_extrap = mean(Δs) - slope * mean(invL)
    println("$name extrapolated Δ(L->inf) = ", round(Δ_extrap, digits=3),
        "  (CFT prediction: $Δ_exact)")

    # correlation data + fit, largest L
    L = Ls[end]
    C, model_full = results[L]
    r = collect(1:L÷2)
    rf = range(2, L ÷ 2, length=200)
    p1 = plot(r, abs.(C), seriestype=:scatter, yscale=:log10,
        label="exact diag |C(r)|", xlabel="distance r", ylabel="|C_$name(r)|",
        title="$name correlation, PBC, L=$L")
    plot!(p1, rf, model_full(rf),
        label="CFT fit: A[(L/π)sin(πr/L)]^{-2Δ}, Δ=$(round(Δs[end], digits=3))")

    # finite-size extrapolation
    p2 = plot(invL, Δs, seriestype=:scatter, label="fitted Δ(L)",
        xlabel="1/L", ylabel="Δ", title="$name extrapolation",
        xlims=(0, maximum(invL) * 1.1))
    plot!(p2, [0, maximum(invL) * 1.1], [Δ_extrap, Δ_extrap + slope * maximum(invL) * 1.1],
        label="linear fit in 1/L")
    hline!(p2, [Δ_exact], linestyle=:dash, label="CFT: Δ = $Δ_exact")
    plot!(p2, [0], [Δ_extrap], seriestype=:scatter, markershape=:star,
        label="extrapolated Δ = $(round(Δ_extrap, digits=3))")

    p = plot(p1, p2, layout=(1, 2), size=(1000, 400))
    savefig(p, joinpath(@__DIR__, "PBC_$(name)_fit.png"))
    push!(plots, p)
end
display(plot(plots..., layout=(2, 1), size=(1000, 800)))
