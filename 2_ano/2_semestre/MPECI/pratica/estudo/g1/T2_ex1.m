%% task 2
% ex 1

% M - male; F - female
%    M  F
% M MM MF
% F FM FF

% alinea a
% 1 - prob_ter_so_F
p = 0.5;
n = 2; %number of children
N = 1e6;

% se der 2 quer dizer que tiveram 2 F, logo esses casos têm que ser
% excluidos aka numero de F
experiments_a = rand(n,N) < p;
fav = sum(experiments_a) < 2;
prob_a = sum(fav)/N

% alinea b é comparar resultados.

% alinea c - 2 filhos, 1 M, prob do outro ser M.
%na matriz, se der 2, quer dizer que tiveram 2 M.
experiment_c = rand(n,N) < p;
success = sum(experiment_c) == n;
possiveis = sum(experiment_c) >= 1;
prob_c = sum(success)/sum(possiveis)

% alinea d - 1o dos dois filhos é M, prob do 2o ser M.
experiment_d = rand(1,N) < p;
success = experiment_d == 1;
prob_d = sum(success)/N

% alinea e - 5 putos
n = 5;

experiment_e = rand(n,N) < p;
success_e = sum(experiment_e) == 2;
possiveis_e = sum(experiment_e) >= 1;
prob_e = sum(success_e)/sum(possiveis_e)

% alinea f
% 1 - ter 0 ou 1 M
experiment_f = rand(n,N) < p;
success_f = sum(experiment_f) >= 2;
possiveis_f = sum(experiment_f) >= 1;
prob_f = sum(success_f)/sum(possiveis_f)
