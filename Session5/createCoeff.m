function b_i = createCoeff(K,a,D)
    
    b_i = [1];
    for i = 1:K
       b_i(i+1+(D-1)*i) = a^i;  
    end
end