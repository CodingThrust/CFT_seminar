using LinearAlgebra, SparseArrays, Arpack
using Plots, LsqFit, LaTeXStrings
using JLD2

# <--- template code --->
# This is a template for the Ising CFT project.


L_list= collect(6:2:12)
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
    α = (2*sinh(2K))^(-1/2)
    return exp(Matrix(temp1))*exp(Matrix(temp2))*(α^(-L))
end

function FE_scaling_data(L_list)
    free_energy = zeros(length(L_list))
    
    for (idx, i) in enumerate(L_list)
        @show i
        T = transfer_matrix(i)
        vals, _ = eigs(T, nev=1, which=:LR)
        λmax = real(vals[1])
        free_energy[idx] = -log(abs(λmax))
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
    legend_background_color=nothing, legend_foreground_color=nothing)
    return fig
end

FE_scaling_data(L_list)
fig = FE_scaling_figs()
output_dir = joinpath(@__DIR__, "figs")
mkpath(output_dir)
savefig(fig, joinpath(output_dir, "free_energy_scaling.svg"))