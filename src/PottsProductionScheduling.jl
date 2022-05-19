module PottsProductionScheduling

    include("demand.jl")
    include("environment.jl")
    include("agent.jl")
    include("common.jl")
    include("optimize.jl")
    include("utils.jl")
    

    export Environment, Agent, step_cost, optimize, cost
    export GeometricDemand

    #exporting only for debugging
    export base10_conv, baseN_conv, vec2int, int2vec
end
