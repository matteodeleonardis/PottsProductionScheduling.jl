function optimize(env)
    action_space =  env.N ^ env.M
    R = zeros(env.T-1, action_space)
    traceback_actions = zeros(Int, env.T-1, action_space) 
    #recursion initialization
    for i in 1:action_space
        R[1, i], traceback_actions[1, i] = findmin([step_cost(env, int2vec(x, env.N, env.M), int2vec(i, env.N, env.M), 1) for x in 1:action_space])
    end
    #recursion steps
    for t in 2:env.T-1
        for i in 1:action_space
            R[t, i], traceback_actions[t, i] = findmin([step_cost(env, int2vec(x, env.N, env.M), int2vec(i, env.N, env.M), t) + R[t-1, x]
                for x in 1:action_space])
        end
    end

    #traceback
    optimal_actions = zeros(Int, env.T)
    optimal_cost, optimal_actions[end] = findmin(R[end, :])
    for t in env.T:-1:2
        optimal_actions[t-1] = traceback_actions[t-1, optimal_actions[t]]
    end
    return optimal_cost, map(x->int2vec(x, env.N, env.M), optimal_actions), R
end

    
