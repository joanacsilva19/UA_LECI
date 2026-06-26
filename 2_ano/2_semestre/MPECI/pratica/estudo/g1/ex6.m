p = 0.1;
n = 5;
k = 3;

prob_a = prob_binomial(n,k,p)

% alinea b - no maximo 2 serem defective

resultado = 0;
for k = 0:2
    prob_c = prob_binomial(n,k,p);
    resultado = resultado + prob_c;
end

resultado

% alinea c - histograma

casos = (0:5);
resultado = zeros(1,6);
for i = casos
    resultado(i+1) = prob_binomial(n,i,p);
end
stem(resultado)
figure
histogram(resultado)
