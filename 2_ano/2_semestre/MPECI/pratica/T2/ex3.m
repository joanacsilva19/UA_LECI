lambda = 3500;
C = 10; 
N = 10000;

resultado = zeros(1,200);
for i=1:200
    resultado(i) = SimulatorB(lambda, C, N);
end

n = length(resultado);
valor_esperado = mean(resultado);

alfa = 0.10;
desvio_padrao = std(resultado);

t_crit = tinv(1 - alfa/2, n - 1); 

margem_erro = t_crit * (desvio_padrao / sqrt(n));

lim_inf = valor_esperado - margem_erro;
lim_sup = valor_esperado + margem_erro;

fprintf('Valor Estimado (Média): %.2f\n', valor_esperado)
fprintf('Intervalo de Confiança (90%%): [%.2f, %.2f]\n', lim_inf, lim_sup)
