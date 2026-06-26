%% Code 1

% Generate a matrix with 3 rows and 10,000 columns of random numbers
% between 0.0 and 1.0 (i.e., each column represents an experiment):
experiments = rand(3,10000);

% Generate a matrix with 3 rows and 10,000 columns with the value 1 if
% the value of the previous matrix is less than 0.5 (i.e., if it came
% up heads) or with the value 0 otherwise (i.e., if it came up tails):
tosses = experiments < 0.5; % 0.5 corresponds to the prob. of heads

% Generate a row vector with 10,000 elements with the sum of the values
% of each column of the previous matrix [heads = 1, tails = 0] (i.e., the 
% number of heads in each experiment):
results = sum(tosses);

% Generate a row vector with 10,000 elements with the value 1 when the
% value of the previous vector is 2 (i.e., if the experiment gave 2 heads)
% or 0 when it is different from 2:
successes = results == 2;

% Determine the result by dividing the number of experiments with 2 heads
% by the total number of experiments:
probSimulation_a = sum(successes)/10000

%%
% Code 1 - second version

N = 1e4; % number of experiments
p = 0.5; % probability of heads
k = 2; % number of heads - caso favorável
n = 3; % number of tosses


%Gera matriz [tosses, experiments] c valores random entre 0.0 e 1.0;
%Compara, coluna a coluna, se esses valores em cada entrada/linha são
%menores do que p e se forem dá 1, se não dá 0;
tosses = rand(n,N) < p;

%Retorna uma matriz linha com a soma dos valores anteriores (soma os 1s 
%[quantas vezes calhou heads em cada toss]);
%Compara esses valores com o valor do caso favorável k (calhar k vezes 
%heads, k = 2);
successes = sum(tosses) == k;

%Calcula a probabilidade do evento
probSimulation_b = sum(successes)/N

%%
% ex 2 - alinea a
N = 1e4; % number of experiments
p = 0.5; % probability of heads
k = 6; % number of heads
n = 15; % number of tosses

tosses = rand(n,N) < p;
successes = sum(tosses) == k; %only 6 heads out of 15 tosses
probSimulation_ex2_a = sum(successes)/N

%%
% ex 2 - alinea b
N = 1e4; % number of experiments
p = 0.5; % probability of heads
k = 6; % number of heads
n = 15; % number of tosses

tosses = rand(n,N) < p;
successes = sum(tosses) >= k; %at least 6 heads out of 15 tosses
probSimulation = sum(successes)/N

%%
% ex 3

N = 1e4; % number of experiments
p = 0.5; % probability of heads
k = 2; % number of heads
n = 3; % number of tosses

resultado = prob(p,k,n,N);

%% 20 moedas
%ex 3 - b

N = 1e4; % number of experiments
p = 0.5; % probability of heads
n = 20; % number of tosses

resultado_20 = zeros(1,n+1);
for k = 0:n
   resultado_20(k+1) = prob(p,k,n,N);
end    

figure(1)
stem(0:n, resultado_20)
xlabel("nº de caras/heads")
ylabel("probabilidade")
title("20 moedas")
grid on

%% 40 moedas

N = 1e4; % number of experiments
p = 0.5; % probability of heads
n = 40; % number of tosses

resultado_40 = zeros(1, n+1);
for k = 0:n
    resultado_40(k+1) = prob(p,k,n,N);
end

%hold on %mantem o primeiro stem e adiciona o segundo // eliminar o figure
figure(2)
stem(0:n, resultado_40)
xlabel("nº caras")
%xlim([1 10]) //limites no eixo do x
ylabel("probabilidade")
title("40 moedas")
grid on


%% 100 moedas

N = 1e4; % number of experiments
p = 0.5; % probability of heads
n = 100; % number of tosses

resultado_100 = zeros(1,n+1);

for k = 0:n
    resultado_100(k+1) = prob(p,k,n,N);
end

figure(3)
stem(0:n, resultado_100)
xlabel("nº caras")
ylabel("probabilidade")
title("100 moedas")
grid on

%% Code 2 - Analytical calculation of probability in series of
% Bernoulli experiments
% Data related to problem 1
p = 0.5;
k = 2;
n = 3;
prob = nchoosek(n,k)*p^k*(1-p)^(n-k); % nchoosek(n,k)= n!/(n-k)!/k!


%% ex 6 - 3 out of 5

f = 5; %number of faucets
p = 0.1; %probability of being defective
k = 3; %number of defective faucets
e = 1e6;

casos = rand(f,e) < p;
fav = sum(casos) == k;
prob_faucets_a = sum(fav) / e

%% at least 2 outta 5

f = 5; %number of faucets
p = 0.1; %probability of defectiveness
k = 2; % number defective faucets
e = 1e6; %experiments

faucets = rand(f,e) < p;
success = sum(faucets) >= k;
prob_faucets_b = sum(success) / e

%% alinea c - VER O QUE É PEDIDO



%% Task 2 - familia

N = 1e4; % number of experiments
p = 0.5; % probability of boy
k = 1; % number of boys
n = 2; % number of children

experiments = rand(n,N) < p;

%1 a)
successes = sum(experiments) >= k;
probA = sum(successes) / N

%1 c)
%P(A|B) = P(AB)/P(B)
%P(A|B) = nº casos de AB / nº de casos de B     (simulação)
sucesses = sum(experiments) == n; %nº de casos AB
possibles = sum(experiments) >= 1; %nº de casos B

probC = sum(sucesses) / sum(possibles)

%1 d)
sucesses = sum(experiments) == n;
possibles = experiments(1,:);

probD = sum(sucesses) / sum(possibles)

%1 e)

p = 0.4; % probability of boy
k = 2; % number of boys
n = 5; % number of children

experiments = rand(n,N) < p;

%quantas experiencias tem 2 rapazes há entre os 5 filhos.
sucesses = sum(experiments) == k;

%haver pelo menos 1 filho rapaz
possibles = sum(experiments) >= 1; 

probE = sum(sucesses) / sum(possibles)


% 1 e)

experiments = rand(n,N) < p;

%quantas experiencias pelo menos 2 rapazes há entre os 5 filhos.
sucesses = sum(experiments) >= k;

%haver pelo menos 1 filho rapaz
possibles = sum(experiments) >= 1; 

probF = sum(sucesses) / sum(possibles)


%% Task 2 - ex 2

d = 20; %number of darts
t = 100; %number of targets
N = 1e5; %number of experiences


experiments = randi(t,d,N);
counter = 0;

for i=1:N
    if length(unique(experiments(:,i))) == d;
        counter = counter +1;
    end
end

probA = counter/N

%alinea b

probB = 1 - probA


%% ex 4

p = 0;
d = 365; %number of birthdays
N = 10; %number of experiences
n = 1; %number of people

success = 0;

while p <= 0.5
    n = n + 1;
    experiments = randi(d,n,N);
    success = 0;
    for i=1:N
        if length(unique(experiments(:,i))) < n
            success = success + 1;
        end
    end
    p = success / N;
end
n


%alinea b

while p <= 0.9
    n = n + 1;
    experiments = randi(d,n,N);
    success = 0;
    for i=1:N
        if length(unique(experiments(:,i))) < n
            success = success + 1;
        end
    end
    p = success / N;
end

n

%% ex5 - die instead of dice lol
% alinea A

%event A - soma dos dois valores tem que dar 9

r = 2; %number of rolls
e = 1e6; %experiments

experiments = randi([1,6],r,e);
success = sum(experiments) == 9; %a soma dos dois valores tem que dar 9

fav = 0;
for i=1:e
    if success(1,i) == 1
        fav = fav + 1;
    end
end

prob_A = fav / e;

% event B - o segundo valor é par

fav = 0;
for i=1:e
    if mod(experiments(2,i),2) == 0
        fav = fav + 1;
    end
end

prob_B = fav / e;

% event c - pelo menos 1 valor é 5

fav = 0;
for i=1:e
    if experiments(2,i) == 5 || all(experiments(:,i) == 5) %os indexs começam por 1 e não por 0
        fav = fav + 1;
    end
end

prob_C = fav / e;

% event d - nenhum dos valores é igual a 1

% prob_D = 1 - prob de os dois valores serem 1

counter = 0;
for i=1:e
    if all(experiments(:,i) ~= 1) % '~' = NOT
        counter = counter + 1;
    end
end
 
prob_D = counter / e

%% ex 6 - (link com interferencia ou normal) com erros

prob_e_sab_n = 0.001; %prob ter erro sabendo que link é normal
prob_e_sab_i = 0.1; %prob ter erro sabendo que link tem interferencia
prob_i = 0.02; %prob de ter interferencia
prob_n = 1 - prob_i; %prob de ser normal

% p(e|n) = p(en) / p(n)
% p(e) = p(en) + p(ei) ----> prob de dar erro é a prob de dar erro nas duas
% situações, que são disjuntas (ou acontece uma ou a outra, não se intercetam)

%calcular duas experiencias disjuntas.

N = 1e6; % 1 million packets
is_interfered = rand(1, N) < prob_i; % 2% chance of interference

% Pre-allocate errors vector
errors = zeros(1, N);

% For normal packets (where is_interfered is 0)
errors(~is_interfered) = rand(1, sum(~is_interfered)) < prob_e_sab_n;

% For interfered packets (where is_interfered is 1)
errors(is_interfered) = rand(1, sum(is_interfered)) < prob_e_sab_i;

prob_A = sum(errors) / N;

% alinea b - p(n|e) e p(i|e)

prob_erro = prob_A;

prob_n_sab_e = (prob_e_sab_n .* prob_n)/prob_erro

prob_i_sab_e = (prob_e_sab_i .* prob_i)/prob_erro

%% ex 7 - programadores e erros("bugs" lol)

prog = 100; %number of programs
prob_carlos = 50/prog;
prob_andre = 20/prog;
prob_bruno = 30/prog;

%prob_c_sab_e = (prob_e_sab_c * prob_c)/prob_e;     Bayes: sabes o
%resultado (tem erro) e queres a causa (quem programou)

%prob_e = prob_e_c + prob_e_a + prob_e_b

%prob_e_sab_c = prob_e_c / prob_c
%prob_e_c = prob_e_sab_c * prob_c

prob_e_programador = [0.001 * prob_carlos, 0.01 * prob_andre, 0.05 * prob_bruno];

prob_e = sum(prob_e_programador);

prob_c_sab_e = (0.001 .* prob_carlos) ./ prob_e

% alinea b - mais prob de ser escolhido = menor taxa de erro

nomes = ["carlos", "andre", "bruno"];
menor = 1.0;
nome = " ";
for i = 1:3
    if prob_e_programador(i) < menor
        menor = prob_e_programador(i);
        nome = nomes(i);
    end
end

fprintf("o programador escolhido é: %s.\n", nome)
