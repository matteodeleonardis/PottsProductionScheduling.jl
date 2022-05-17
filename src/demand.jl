abstract type Demand end

struct GeometricDemand <: Demand
    α::Vector{Float64}
end