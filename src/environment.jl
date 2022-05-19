struct Environment
    T::Int #time horizon
    M::Int #number of machines
    N::Int #number of goods
    h::Matrix{Float64} #cost of products (production cost - reward)  h[t,s]
    A::Array{Float64, 4} #switching cost A[m, t, s_m_t, s_m_t+1]
    J::Array{Float64, 5} #machines couplings J[m, n, t, s_m, s_n]
    I::Matrix{Float64} #I[t, s] cost for storing and item of good s
end


function Environment(t::Int, m::Int, n::Int, a::Int, j::Int, h::Matrix{Float64}, I::Matrix{Float64}) 
    return Environment(t, m, n, h, a .* ones(m, t, n, n), j .* ones(m, m, t, n, n), I)
end

