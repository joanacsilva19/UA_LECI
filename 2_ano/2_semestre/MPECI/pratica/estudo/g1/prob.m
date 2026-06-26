function probabilidade = prob(n,N,p,k)
    tosses = rand(n,N) < p;
    success = sum(tosses) == k;
    probabilidade = sum(success)/N;
end