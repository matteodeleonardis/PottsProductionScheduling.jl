struct Environment
    T::Int #time horizon
    M::Int #number of machines
    N::Int #number of goods
    h::Matrix{Float64} #cost of products h[a, t]
    A::Array{Float64, 3} #switching cost A[a, b, t]
    J::Array{Float64, 3} #machines couplings J[a, b, t]
    I::Matrix{Float64} #I[a, t] cost for storing and item of good a
end

function randomEnvironment(time_horizon::Int, machines::Int, goods::Int, switching_cost::Float64, coupling::Float64)
    return Environment(time_horizon, machines, goods, 
        rand(Exponential(0.5), goods, time_horizon), 
        fill(switching_cost, goods, goods, time_horizon-1) .-cat([switching_cost*Matrix(I, goods, goods) for t ∈ 1:time_horizon-1]..., dims=3), 
        cat([coupling*Matrix(I, goods, goods) for t ∈ 1:time_horizon]..., dims=3), 
        rand(Exponential(0.7), goods, time_horizon)) 
end