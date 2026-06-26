% prob receber menos de 10 em 2 seg

lambda = 5*2; % avg é 5 msg/seg
N = 1e4;
y_a = poissrnd(lambda,1,N) < 10; %menos de 10 msgs

prob_a = sum(y_a)/N

%prob de receber mais de 30 em 5 seg

lambda = 5*5; % avg é 5 msg/seg
y_b = poissrnd(lambda,1,N) > 30; %mais de 30 msgs

prob_b = sum(y_b)/N
