function step_cost(env, σt1, σt2, t)
    m = [sum(σt1 .== a) for a ∈ 1:env.N]
    return sum([env.h[t, s] for s ∈ σt1]) + 
    sum([env.A[m, t, σt1[m], σt2[m]] for m ∈ 1:env.M]) +
        sum([sum([env.J[m, n, t, σt1[m], σt1[n]] for n ∈ m+1:env.M]) for m ∈ 1:env.M-1]) +
        sum([env.I[t,a]*(env.demand.α[a]^(m[a]+1)-m[a]*env.demand.α[a]^m[a]+env.demand.α[a])/(env.demand.α[a]-1)^2 for a ∈ 1:env.N])
end


function cost(env, agent)
    sum([step_cost(env, agent.σ[t,:], agent.σ[t+1,:], t) for t ∈ 1:agent.T-1])
end

