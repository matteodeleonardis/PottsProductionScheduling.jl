abstract type Demand end


struct GeometricDemand <: Demand
    α::Vector{Float64}
end


function expected_storage(demand::D, σ) where {D<:Demand}
    return expected_sotrage(demand, σ)
end


function expected_storage(demand::GeometricDemand, σ) where {D<:Demand}
    m = [sum(σ .== a) for a ∈ 1:length(demand.α)] 
    return @. (demand.α^(m+1)-m*demand.α^m+demand.α)/(demand.α-1)^2
end