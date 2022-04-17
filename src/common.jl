function step_cost(env, σt1, σt2, t)
    return sum([env.h[t, s] for s ∈ σt1]) + 
    sum([env.A[m, t, σt1[m], σt2[m]] for m ∈ 1:env.M]) +
        sum([sum([env.J[m, n, t, σt1[m], σt1[n]] for n ∈ m+1:env.M]) for m ∈ 1:env.M-1])
end

