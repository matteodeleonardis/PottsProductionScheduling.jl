function mc_step!(env, agent, demand, machine, time, β)
    agent_tmp = deepcopy(agent)
    r = rand(collect(1:env.N))
    set_action!(agent_tmp, r, machine, time)
    Δcost = expected_total_cost(env, agent_tmp, demand) - expected_total_cost(env, agent, demand)
    η = rand()
    if η <= exp(-β*Δcost)
        set_action!(agent, r, machine, time)
    end
    return nothing
end


function mc_sweep!(env, agent, demand, β)
    for m ∈ 1:env.M
        for t ∈ 1:env.T
            mc_step!(env, agent, demand, m, t, β)
        end
    end
    return expected_total_cost(env, agent, demand)
end


function annealing!(env, agent, demand, βschedule)
    costs = zeros(length(βschedule))
    for (i,β) ∈ pairs(βschedule)
        costs[i] = mc_sweep!(env, agent, demand, β)
    end
    return costs
end