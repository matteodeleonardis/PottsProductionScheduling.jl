module PottsProductionScheduling

    using Flux, LinearAlgebra, Tullio, Distributions, SpecialFunctions

    include("demand.jl")
    include("environment.jl")
    include("agent.jl")
    include("common.jl")
    include("optimize.jl")
    include("utils.jl")
    

    export Environment, randomEnvironment, Agent
    export production_cost, switching_cost, coupling_cost, inventory_cost, total_cost, compute_inventory, compute_expected_inventory
    export PoissonDemand

    #exporting only for debugging
    export base10_conv, baseN_conv, vec2int, int2vec
end
