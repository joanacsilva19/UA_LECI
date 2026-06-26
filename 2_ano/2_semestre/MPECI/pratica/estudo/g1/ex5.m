%% ex 5 - data packets
% alinea a
p = 1e-5;
n = 800;
k = 0;
prob_sem_erro = prob_binomial(n,k,p)

% alinea b
 n = 8000;
 soma = 0;
 for k = 0:1
    soma = soma + prob_binomial(n,k,p);
 end

 prob_b = 1 - soma

