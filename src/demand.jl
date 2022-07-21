abstract type Demand end


struct PoissonDemand <: Demand
    λ::Matrix{Int} #λ[a, t] average demand for good a at time t
    d::Matrix{Int} #d[a, t] demand for good a at time t
end


function PoissonDemand(λ)
    demand = [rand(Poisson(λ[a,t])) for a ∈ 1:size(λ, 1), t ∈ 1:size(λ, 2)]
    return PoissonDemand(λ, demand)
end
