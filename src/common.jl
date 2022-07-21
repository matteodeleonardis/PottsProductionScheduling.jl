function production_cost(env, agent)
    @tullio v[m, t] := env.h[a, t] * agent.δ[a, m, t]
    return sum(v, dims=1) |> x-> dropdims(x, dims=1) 
end


function switching_cost(env, agent)
    @tullio v[m,t] := env.A[a, b, t] * agent.δ[:,:,1:end-1][a, m, t] * agent.δ[:,:,2:end][b, m,t]
    return sum(v, dims=1) |> x-> dropdims(x, dims=1) 
end


function coupling_cost(env, agent)
    v = zeros(env.M*(env.M-1)÷2, env.T)
    cnt = 1
    for i ∈ 2:env.M
        for j ∈ 1:i-1
            @tullio v[cnt, t] = env.J[a, b, t] * agent.δ[a, i, t] * agent.δ[b, j, t]
        end
    end
    return sum(v, dims=1) |> x->dropdims(x, dims=1)
end


function compute_inventory(env, agent, demand)
    inventory = zeros(env.N, env.T)
    for a ∈ 1:env.N
        for t ∈ 2:env.T
            inventory[a, t] = theta(inventory[a, t-1] + sum(agent.δ[a, :, t]) - demand.d[a,t])
        end
    end
    return inventory
end


function inventory_cost(env, agent, demand)
    inventory = compute_inventory(env,  agent, demand)
    return dropdims(sum(env.I .* inventory, dims=1), dims=1)
end


function compute_expected_inventory(env, agent, demand)
    exp_inventory = zeros(env.N, env.T)
    for a ∈ 1:env.N
        for t ∈ 2:env.T
            exp_inventory[a, t] = expected_theta_poisson(exp_inventory[a, t-1] + sum(agent.δ[a, :, t]), demand.λ[a,t])
        end
    end
    return exp_inventory
end


function expected_inventory_cost(env, agent, demand)
    exp_inventory = compute_inventory(env,  agent, demand)
    return dropdims(sum(env.I .* exp_inventory, dims=1), dims=1)
end


function total_cost(env, agent, demand)
    return sum(production_cost(env,agent)) + sum(switching_cost(env, agent)) + sum(coupling_cost(env, agent)) +
         sum(inventory_cost(env, agent, demand))
end


function expected_total_cost(env, agent, demand)
    return sum(production_cost(env,agent)) + sum(switching_cost(env, agent)) + sum(coupling_cost(env, agent)) +
         sum(expected_inventory_cost(env, agent, demand))
end