p = 0.3;
n = 5;
N = 1e4;

prob = zeros(1,6);
M = rand(n,N) < p;
faucets = sum(M);

for i = (0:5)
    counter = 0;
    for j = (1:length(faucets))
        if faucets(j) == i
            counter = counter + 1;
        end
    end
    prob(i + 1) = counter/N;
end

% i)

figure

x = (0:5);
stem(x,prob, '-o')
ylim([-0.1,0.5])
grid on;

% ii)

y = [0,cumsum(prob),1];
stairs([-1,x,6],y)
xlim([-0.5,5.5])
ylim([-0.5,1.5])
grid on;

% iii)

x_iii = prob(1) + prob(2) + prob(3)
