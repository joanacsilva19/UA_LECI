c = 100;
lambda = 500;
miu = 60 / 10;
a = lambda / miu;

B = 1;
for k = 1:c
    B = (a * B) / (k + a * B);
end

C = (c * B) / (c - a * (1 - B));
P_imediato = (1 - C) * 100;

fprintf('Pedidos atendidos imediatamente: %.2f%%\n', P_imediato)

Wq = C / (c * miu - lambda) * 3600;
fprintf('Tempo medio na fila: %.2f segundos\n', Wq)

c_values = [90, 95, 100, 105, 110];
Wq = zeros(1, length(c_values));

for i = 1:length(c_values)
    c = c_values(i);
    
    B = 1;
    for k = 1:c
        B = (a * B) / (k + a * B);
    end
    
    C = (c * B) / (c - a * (1 - B));

    Wq(i) = C / (c * miu - lambda) * 3600;
end

bar(c_values, Wq);
grid on;
xlabel('Numero de operadores (c)');
ylabel('Tempo medio de espera (segundos)');
title('Exercicio 2 c)');