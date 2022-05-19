function step_cost(env, demand, σt1, σt2, t)
    
    return sum([env.h[t, s] for s ∈ σt1]) + 
    sum([env.A[m, t, σt1[m], σt2[m]] for m ∈ 1:env.M]) +
        sum([sum([env.J[m, n, t, σt1[m], σt1[n]] for n ∈ m+1:env.M]) for m ∈ 1:env.M-1]) +
        sum(env.I[t,:] .* expected_storage(demand, σt1))
end


function cost(env, demand, agent)
    sum([step_cost(env, demand, agent.σ[t,:], agent.σ[t+1,:], t) for t ∈ 1:agent.T-1])
end

