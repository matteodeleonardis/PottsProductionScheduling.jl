struct Agent
    T::Int #time horizon
    M::Int #number of machines
    N::Int #number of goods
    σ::Matrix{Int} #actions σ[m, t]  ∈ {1,...,N}
    δ::Array{Int, 3} #actions in on hot (good, machine, time) ∈ {0,1}
end

function Agent(s, n)
    m,t = size(s)
    δ = Flux.onehotbatch(s, 1:n)
    return Agent(t, m, n, s, δ)
end


function set_action!(agent, good, machine, time)
    if agent.σ[machine, time] != good
        agent.σ[machine, time] = good
        agent.δ[:, machine, time] .= 0
        agent.δ[good, machine, time] = 1
    end
    return nothing
end