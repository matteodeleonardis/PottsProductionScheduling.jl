struct Agent
    T::Int #time horizon
    M::Int #number of machines
    N::Int #number of goods
    σ::Matrix{Int} #actions σ[t, m]  ∈ {1,...,N}
end

function Agent(s, n)
    t, m = size(s)
    return Agent(t, m, n, s)
end