function mc_step!(env, agent, demand, machine, time)
    r = rand(collect(1:env.N))
    set_action!(agent, r, machine, time)
    return nothing
end


function mc_sweep!(env, agent, demand)
    for m ∈ 1:env.M
        for t ∈ 1:env.T
            mc_step!(env, agent, demand, m, t)
        end
    end
    return expected_total_cost(env, agent, demand)
end


function annealing!(env, agent, demand, β)
    agent_old = deepcopy(agent)
    cost = expected_total_cost(env, agent, demand)
    Δcost = mc_sweep!(env, agent, demand) - cost
    r = rand()
    if exp(β*Δcost) <= r
        return agent
    end
    return agent_old
end


function annealing_schedule!(env, agent, demand, βschedule)
    ag = deepcopy(agent)
    costs = zeros(length(βschedule))
    for (i,β) ∈ pairs(βschedule)
        ag = annealing!(env, ag, demand, β)
        costs[i] = expected_total_cost(env, ag, demand)
    end
    return ag, costs
end