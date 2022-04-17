function base10_conv(v, N)
    v_temp = v .- 1
    s=0
    for x in v
        s = s*N +x
    end
    return s
end


function baseN_conv(i, N)
    map(x->parse(Int, x), collect(string(i, base=N)))
end


function vec2int(v, N)
    v_temp = v .- 1
    i = base10_conv(v_temp, N)
    return i + 1
end


function int2vec(i, N, M)
    i_temp = i - 1
    v = baseN_conv(i_temp, N)
    return vcat(ones(Int, M-length(v)), v .+ 1)
end   