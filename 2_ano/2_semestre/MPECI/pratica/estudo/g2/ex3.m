N = 1e4;
p = 0.5;

tosses = rand(4,N) < p;
aux = sum(tosses);

prob = zeros(1,5);

for j = 0:4
    counter = 0;
    for i = 1:length(aux)
        if aux(i) == j
            counter = counter + 1;
        end
    end
    prob(j+1) = counter/N;
end
x = (0:4);
stem(x,prob)
xlabel("number of heads on 4 tosses")
ylabel("prob of getting head")
grid on;

% alinea b - E[x], variancia e desvio padrao

media = sum(x .* prob);
variancia = sum(prob .* (x - media) .^ 2);
desvio = sqrt(variancia);
