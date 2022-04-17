struct Agent
    T::Int
    M::Int
    N::Int
    σ::Matrix{Int} #actions σ[m, t]  ∈ {1,...,N}
end

function Agent(s, n)
    t, m = size(s)
    return Agent(t, m, n, s)
end