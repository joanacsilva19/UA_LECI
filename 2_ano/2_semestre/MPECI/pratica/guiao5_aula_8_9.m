%% guião 5
% Task 2
% ex 6 - LinkSimulator

lambda = 1000; %packet arrival rate 1000 pps 
B = 600; %avg packet size 600 bytes
C = 10; %link capacity of 10 Mbps
F = 1000; %queue capacity of 1000 packets
N = 10e4; % stoping criterion
Nsim = 100; % number of simulations
PB= zeros(1,Nsim); % vector to save results

for it= 1:Nsim
    PB(it)= LinkSimulator(lambda, B, C, F, N);
end

alfa = 0.1; % 90% confidence interval
media = mean(PB);
[~, ~, ci] = ttest(PB, media,'alpha',alfa);
fprintf('PB = %.4f [%.4f - %.4f] \n',media,ci(1),ci(2))
