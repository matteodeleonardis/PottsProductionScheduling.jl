struct Environment
    T::Int #time horizon
    M::Int #number of machines
    N::Int #number of goods
    h::Matrix{Float64} #cost of products (production cost - reward)  h[t,s]
    A::Array{Float64, 4} #switching cost A[m, t, s_m_t, s_m_t+1]
    J::Array{Float64, 5} #machines couplings J[m, n, t, s_m, s_n]
end


function Environment(t, m, n, a, j, h = rand(t, n))
    return Environment(t, m, n, h, a .* ones(t, n, n), j .* ones(t, n, n))
end

