using LinearAlgebra, SparseArrays, Arpack
using Plots, LsqFit, LaTeXStrings
using JLD2

# <--- template code --->
# This is a template for the Ising CFT project.


L_list= collect(6:12)
⊗(A::AbstractArray, B::AbstractArray) = kron(A, B)

function transfer_matrix(L)
    K = log(1+√2)/2
    X = sparse([0 1; 1 0])
    Z = sparse([1 0; 0 -1]) 
    Id = sparse([1 0; 0 1])

    temp1= spzeros(Float64, 2^L, 2^L)
    for i in 1:L
        cup = fill(Id, L)
        cup[i] = X
        temp1 += K*foldr(⊗, cup)
    end

    temp2 = spzeros(Float64, 2^L, 2^L)
    for j in 1:L-1
        cup = fill(Id, L)
        cup[[j,j+1]] = [Z, Z] 
        temp2 += K*foldr(⊗, cup)
    end
    cup = fill(Id, L)
    cup[L] = Z
    cup[1] = Z
    temp2 += K*foldr(⊗, cup)
    T_raw = exp(Matrix(temp1)) * exp(Matrix(temp2))
    norm_factor = exp(2K * L)
    return T_raw / norm_factor
end

function FE_scaling_data(L_list)
    free_energy = zeros(length(L_list))
    
    for (idx, i) in enumerate(L_list)
        @show i
        T = transfer_matrix(i)
        vals, _ = eigs(T, nev=1, which=:LM)
        λmax = real(vals[1])
        free_energy[idx] = -log(λmax)
    end
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "free_energy_data.jld2")
    save(file_path, "L_list", L_list, "free_energy", free_energy)
end

function FE_scaling_figs()
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "free_energy_data.jld2")
    L_list, free_energy = load(file_path, "L_list", "free_energy")    
    fit_model(L, p) = p[1] .- π/6*p[2] ./L.^2
    
    
    
    fit = curve_fit(fit_model, L_list, free_energy ./ L_list, [0.0, 0.0])
    @show fit.param, stderror(fit)

    fig = plot(
        1 ./L_list.^2,
        fit_model(L_list, fit.param),
        label = "Fit: " * latexstring("F/L = f_\\infty - \\frac{\\pi c}{6L^2},\\ c = $(round(fit.param[2], digits=4))"),
        linestyle = :dash,
    )
    scatter!(fig, 1 ./L_list.^2, free_energy./L_list, label="Free energy density", xlabel=L"1/L^2", ylabel=L"F/L",
    legend_background_color=nothing, legend_foreground_color=nothing,
    xticks = (
                vcat(0, 1 ./L_list.^2),
                 vcat([L"0"], [latexstring("\\frac{1}{$(i)^2}") for i in L_list])
            ),
    )
    return fig
end

FE_scaling_data(L_list)
fig = FE_scaling_figs()
output_dir = joinpath(@__DIR__, "figs")
mkpath(output_dir)
savefig(fig, joinpath(output_dir, "free_energy_scaling.svg"))

function Ising_Hamiltonian(L)
    X = sparse([0 1; 1 0])
    Z = sparse([1 0; 0 -1]) 
    Id = sparse([1 0; 0 1])

    H= spzeros(Float64, 2^L, 2^L)
    for i in 1:L
        cup = fill(Id, L)
        cup[i] = X
        H -= foldr(⊗, cup)
    end

    for j in 1:L-1
        cup = fill(Id, L)
        cup[[j,j+1]] = [Z, Z] 
        H -= foldr(⊗, cup)
    end
    cup = fill(Id, L)
    cup[L] = Z
    cup[1] = Z
    H -= foldr(⊗, cup)
    return H
end

function GSE_scaling_data(L_list)
    energies = zeros(length(L_list))
    for (idx, i) in enumerate(L_list)
        H = Ising_Hamiltonian(i)
        vals, _ = eigs(H, nev=1, which=:SR)
        energies[idx] = vals[1]
    end
    
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "gse_data.jld2")
    save(file_path, "L_list", L_list, "energies", energies)
    return energies
end

function GSE_scaling_figs()
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "gse_data.jld2")
    L_list, energies = load(file_path, "L_list", "energies")
    fit_model(L, p) = p[1] .- π/6*p[2] ./L .^2
    fit = curve_fit(fit_model, L_list, energies ./ L_list, [0.0, 0.0])
    @show fit.param, stderror(fit)  

    fig = plot(
        1 ./L_list .^2,
        fit_model(L_list, fit.param),
        label = "Fit: " * latexstring("E/L = e_\\infty - \\frac{\\pi c}{6L},\\ c = $(round(fit.param[2], digits=4))"),
        linestyle = :dash,
    )
    scatter!(fig, 1 ./L_list .^2, energies./L_list, label="Ground state energy density", xlabel=L"1/L^2", ylabel=L"E/L",
    legend_background_color=nothing, legend_foreground_color=nothing,
    xticks = (
                vcat(0, 1 ./L_list .^2),
                 vcat([L"0"], [latexstring("\\frac{1}{$(i)^2}") for i in L_list])
            ),
    )
    return fig
end

GSE_scaling_data(collect(8:2:18))
fig_GSE = GSE_scaling_figs()
savefig(fig_GSE, joinpath(output_dir, "gse_scaling.svg"))

function two_point_correlation_xx(L)
    H = Ising_Hamiltonian(L)
    vals, vecs = eigs(H, nev=1, which=:SR)
    ground_state = vecs[:, 1]
    X = sparse([0 1; 1 0])
    Id = sparse([1 0; 0 1])
    correlation = zeros(L)
    for r in 2:div(L, 2)+1
        cup = fill(Id, L)
        cup[1] = X
        cup[r] = X
        correlation[r] = abs(ground_state' * foldr(⊗, cup) * ground_state)
    end
    return correlation    
end

function two_point_correlation_zzzz(L)
    H = Ising_Hamiltonian(L)
    vals, vecs = eigs(H, nev=1, which=:SR)
    ground_state = vecs[:, 1]
    Z = sparse([1 0; 0 -1])
    Id = sparse([1 0; 0 1])
    correlation = zeros(L)
    for r in 2:div(L, 2)+1
        cup = fill(Id, L)
        cup[1] = Z
        cup[2] = Z
        cup[r] = Z
        cup[r+1] = Z
        correlation[r] = abs(ground_state' * foldr(⊗, cup) * ground_state)
    end
    return correlation    
end

function correlation_scaling_data_xx(L_list)
    correlations = [two_point_correlation_xx(L) for L in L_list]
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "correlation_data_xx.jld2")
    save(file_path, "L_list", L_list, "correlations", correlations)
end

function correlation_scaling_data_zzzz(L_list)
    correlations = [two_point_correlation_zzzz(L) for L in L_list]
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "correlation_data_zzzz.jld2")
    save(file_path, "L_list", L_list, "correlations", correlations)
end

function correlation_scaling_figs_zzzz()
    current_dir = @__DIR__
    file_path = joinpath(current_dir, "correlation_data_zzzz.jld2")
    L_list, correlations = load(file_path, "L_list", "correlations")
    fig = plot(xlabel=L"\log r", ylabel=L"\log(\langle Z_1 Z_r \rangle)", label=false)
    colors = cgrad(:blues, length(L_list), categorical=true)
    for (idx, L) in enumerate(L_list)
        scatter!(fig, log.(2:div(L, 2)+1),log.(correlations[idx]), label="L=$(L)", markershape=:circle, c=colors[idx], ylims=(-1, -0.75))
    end

    return fig    

end

correlation_scaling_data_zzzz(collect(10:2:18))
fig_corr = correlation_scaling_figs_zzzz()