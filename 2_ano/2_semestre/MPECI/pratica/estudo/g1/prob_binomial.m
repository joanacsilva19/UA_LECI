function binomial = prob_binomial(n,k,p)
    binomial = nchoosek(n,k)*p^k*(1-p)^(n-k);
end