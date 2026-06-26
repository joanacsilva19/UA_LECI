function probSimulation = prob(p,k,n,N)

%Gera a matriz [n,N] com valores entre 0.0 e 1.0;
%Compara as colunas com p e fica 1 se for verdade e 0 se não for;
tosses = rand(n,N) < p;

%Retorna matriz linha com a soma dos 1s das colunas;
%Compara com k e se for vdd = 1, se não = 0;
%quantidade de casos favoráveis em N experiências;
successes = sum(tosses) == k;

%Calcula a probabilidade;
probSimulation = sum(successes)/N;
end