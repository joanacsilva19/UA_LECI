%% ex 2 - tosses
% alinea a

N = 1e6;
p = 0.5; % prob of heads
k = 6; %number of heads
n = 15; %number of tosses

tosses_a = rand(n,N) < p;
success_a = sum(tosses_a) == k;
prob_a = sum(success_a)/N

% alinea b

success_b = sum(tosses_a) >= k;
prob_b = sum(success_b)/N


