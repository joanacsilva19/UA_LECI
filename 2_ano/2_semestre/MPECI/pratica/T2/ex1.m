lambda = [6/120 5/120 4/120 3/120 2/120 1/120];
miu = [2 4 6 6 6 6] / 24;

co= [1 , lambda./miu];
co= cumprod(co);
u= co/sum(co);

fprintf('Alinea b)\nProb. do estado 1: %.6f\n',u(2)*100)
fprintf('Prob. do estado 2: %.6f\n',u(3)*100)


N = length(u) - 1;
t = 3;             
avg_n_tech = sum(min(0:N, t) .* u);
fprintf('alinea c)\nAvg number of tech : %.6f\n',avg_n_tech)
fprintf('Prob. de 0 técnicos ocupados: %.6f\n', u(1)*100)

