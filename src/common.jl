function step_cost(env, agent, t)
    return sum([env.h[t, s] for s ∈ agent.σ[t, :]]) + sum([env.A[m, t, agent.σ[m, t], agent.σ[m, t+1]] for m ∈ 1:env.M]) +
        sum([env.J[m, n, t, agent.σ[t, m], agent.σ[t, n]] for m ∈ 1:env.M, n ∈ 1:env.M])
end

