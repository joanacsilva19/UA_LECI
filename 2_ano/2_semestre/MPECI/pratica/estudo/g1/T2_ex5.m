% Task 2 - ex 5
% alinea a - evento A
% soma dos dois valores dá 9

N = 1e4;
faces = 6;
exp = 2; % é lancado 2 vezes
counter = 0;

rolls = randi([1, faces],exp,N);
aux = sum(rolls);
for j = 1:length(aux)
    if aux(j) == 9
       counter = counter + 1;
    end
end
prob_A = counter/N

% evento B - o segundo valor é par
counter_B = 0;
for i = 1:length(rolls)
    if mod(rolls(2,i),2) == 0
        counter_B = counter_B + 1;
    end
end
prob_B = counter_B/N

% evento C - pelo menos um valor é igual a 5
counter_C = 0;
for i = 1:length(rolls)
    if rolls(2,i) == 5 || rolls(1,i) == 5
        counter_C = counter_C + 1;
    end
end
prob_C = counter_C/N

% evento D - nenhum dos valores ser igual a 1
counter_D = 0;
for i = 1:length(rolls)
    if rolls(2,i) ~= 1 && rolls(1,i) ~= 1
        counter_D = counter_D + 1;
    end
end
prob_D = counter_D/N

