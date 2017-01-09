# This file is a part of RRRMC.jl. License is MIT: http://github.com/carlobaldassi/RRRMC.jl/LICENCE.md

module REAliases

using ..RE
using ..Empty
using ..SK
using ..EA
using ..PercLinear
using ..PercStep

export Graph0RE, GraphSKRE, GraphEARE, GraphPercLinearRE, GraphPercStepRE

typealias Graph0RE{M,γ,β} GraphRobustEnsemble{M,γ,β,GraphEmpty}

# """
#     Graph0RE(...)
#
# TODO
# """
Graph0RE(Nk::Integer, M::Integer, γ::Float64, β::Float64) = GraphRobustEnsemble(Nk, M, γ, β, GraphEmpty, Nk)



typealias GraphSKRE{M,γ,β} GraphRobustEnsemble{M,γ,β,GraphSK}

# """
#     GraphSKRE(N::Integer, M::Integer, γ::Float64, β::Float64) <: DoubleGraph
#
# TODO
# """
GraphSKRE(Nk::Integer, M::Integer, γ::Float64, β::Float64) = GraphRobustEnsemble(Nk, M, γ, β, GraphSK, SK.gen_J(Nk))




typealias GraphEARE{M,γ,β,twoD} GraphRobustEnsemble{M,γ,β,GraphEANormal{twoD}}

# """
#     GraphEARE(L::Integer, D::Integer, M::Integer, γ::Float64, β::Float64) <: DoubleGraph
#
# TODO
# """
function GraphEARE(L::Integer, D::Integer, M::Integer, γ::Float64, β::Float64)
    D ≥ 1 || throw(ArgumentError("D must be ≥ 0, given: $D"))
    A = EA.gen_EA(L, D)
    N = length(A)
    J = EA.gen_J(Float64, N, A) do
        4*rand() - 2
    end

    GraphRobustEnsemble(N, M, γ, β, GraphEANormal{2D}, L, A, J)
end

function GraphEARE(fname::AbstractString, M::Integer, γ::Float64, β::Float64)
    L, D, A, J = EA.gen_AJ(fname)
    N = length(A)
    @assert N == L^D
    GraphRobustEnsemble(N, M, γ, β, GraphEANormal{2D}, L, A, J)
end

function GraphEARE{twoD}(X::GraphEANormal{twoD}, M::Integer, γ::Float64, β::Float64)
    @assert iseven(twoD)
    D = twoD ÷ 2
    N = X.N
    L = round(Int, N^(1/D))
    @assert L^D == N
    GraphRobustEnsemble(N, M, γ, β, GraphEANormal{twoD}, L, X.A, X.J)
end

typealias GraphPercLinearRE{M,γ,β} GraphRobustEnsemble{M,γ,β,GraphPercLinear}

# """
#     GraphPercLinearRE(N::Integer, P::Integer, M::Integer, γ::Float64, β::Float64) <: DoubleGraph
#
# TODO
# """
function GraphPercLinearRE(N::Integer, P::Integer, M::Integer, γ::Float64, β::Float64)
    ξ, ξv = PercLinear.gen_ξ(N, P)
    GraphRobustEnsemble(N, M, γ, β, GraphPercLinear, ξ, ξv)
end

function GraphPercLinearRE(X::GraphPercLinear, M::Integer, γ::Float64, β::Float64)
    GraphRobustEnsemble(X.N, M, γ, β, GraphPercLinear, X.ξ, X.ξv)
end

typealias GraphPercStepRE{M,γ,β} GraphRobustEnsemble{M,γ,β,GraphPercStep}

# """
#     GraphPercStepRE(N::Integer, P::Integer, M::Integer, γ::Float64, β::Float64) <: DoubleGraph
#
# TODO
# """
function GraphPercStepRE(N::Integer, P::Integer, M::Integer, γ::Float64, β::Float64)
    ξ, ξv = PercStep.gen_ξ(N, P)
    GraphRobustEnsemble(N, M, γ, β, GraphPercStep, ξ, ξv)
end

function GraphPercStepRE(X::GraphPercStep, M::Integer, γ::Float64, β::Float64)
    GraphRobustEnsemble(X.N, M, γ, β, GraphPercStep, X.ξ, X.ξv)
end

end # module