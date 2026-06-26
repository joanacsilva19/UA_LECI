%% ex 3 - testar funcao desenvolvida
% alinea a
p = 0.5;
n = 15;
N = 1e5;
k = 6;

prob_a = prob(n,N,p,k)

% alinea b

casos = [20 40 100];

for i = casos
    resultado = zeros(1,i);
    for j = 1:i+1
        resultado(j) = prob(i,N,p,j);
    end
    figure
    stem(resultado);
end




