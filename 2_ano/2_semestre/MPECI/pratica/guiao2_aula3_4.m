%% guiao 2
%ex 1

% 1. Define the data for a fair 6-sided die
x = 1:6;                        % Faces of the die
pmf = ones(1, 6) / 6;           % Probability Mass Function (1/6 for each)
cdf = cumsum(pmf);              % Cumulative Distribution Function

% Create a new figure
figure;

% (a) Probability Mass Function (PMF)
subplot(1, 2, 1);               % Create the first subplot
stem(x, pmf, 'LineWidth', 1);   % Use stem for PMF
title('1(a)');
xlabel('x');
ylabel('Prob. mass function of x');
axis([0 7 0 0.2]);              % Match the axis limits from the image
grid on;

% (b) Cumulative Distribution Function (CDF)
subplot(1, 2, 2);               % Create the second subplot
% For stairs, we include 0 and 7 to show the flat lines at the edges
x_stairs = [0 x 7]; 
cdf_stairs = [0 cdf 1];

stairs(x_stairs, cdf_stairs, 'LineWidth', 1); 
title('1(b)');
xlabel('x');
ylabel('Cumulative distribution function of x');
axis([0 7 0 1.1]);              % Match the axis limits from the image
grid on;

%% código do stor

x = 1:6;
y = ones(1,6)/6; %prob mass function

figure(1)
subplot(1,2,1) 

stem(x,y)
xlim([0 7])
ylim([0 0.2])

grid on %grelha do grafico

xlabel("x")
ylabel("prob mass function of x")

z = cumsum(y);
subplot(1,2,2)
stairs([0 x 7], [0 z 1])

xlabel("x")
ylabel("Cumulative distribution function of x")

xlim([0 7])
ylim([0 1.1])

grid on

%% ex 2

%a) S = {note1, note2, ..., note100}
%   {S} = 100
%   p("each elementary event") = 1/100

%b) p(5) = 0.900
%   p(10) = 0.090
%   p(100) = 0.010

%c)

s = [5 10 100];

p = [0.9 0.09 0.01];

z = cumsum(p);

stairs([0 s 100], [0 z 1])

grid on

%% exemplo do calculo da media, variancia e desvio

x= [1 3 4 7 15];
p = [0.1 0.1 0.3 0.25 0.25];

media = sum(x .* p)

variancia = sum(x.^2 .* p) - media.^2

desvio = sqrt(variancia) % ou variancia ^ (1/2)


%% ex 3
% (a) - Simulation of 4 Coin Tosses
N = 1e6; % Number of simulations

% 1. Simulate 4 tosses (0=Tails, 1=Heads) for N trials
tosses = randi([0, 1], N, 4);

% 2. Count the number of heads (X) in each trial
X_simulated = sum(tosses, 2); % Sum across the rows

% 3. Calculate the PMF (Frequencies)
% Outcomes can be 0, 1, 2, 3, or 4
outcomes = 0:4;
counts = histcounts(X_simulated, [outcomes, 5]);
estimated_pmf = counts / N;

%b)
x = outcomes;
pmf = estimated_pmf;

media = sum(x .* pmf);

variancia = sum(x.^2 .* pmf) - media.^2;

desvio = sqrt(variancia); % ou variancia ^ (1/2)

%c) Binomial distribution with p = 0.5 and n = 4

%d) 
p = 0.5;
n = 4;
prob = nchoosek(n,k)*p^k*(1-p)^(n-k);


%e)



%f)
pmf_t = [0.0625 0.25 0.375 0.25 0.0625];
pmf_i = sum(pmf_t(3:end))
pmf_ii = sum(pmf_t(1:2))
pmf_iii = sum(pmf_t(2:4))

%% ex 4 - faucets
% Alínea A i
Sx = 0:5;
N = 1e5;
m= 5; % n º de peças
experiencia = rand(m,N); % usa-se o rand para ver se sai com defeito ou não
Pdefeito= 0.3;
defeito = experiencia< Pdefeito;
sucesso= sum(defeito);

px= [sum(sucesso==0)/N,sum(sucesso==1)/N,sum(sucesso==2)/N,sum(sucesso==3)/N,sum(sucesso==4)/N,sum(sucesso==5)/N]

% Funcão de Massa Probabilidade
stem(Sx,px);
xlabel("Número de peças defeituosas");
ylabel("Probabilidade  P[X =x_i]");
title("Funcao massa de probabilidade (aka FMP) de SX");

%% Alínea A ii
pacusum1 = cumsum(px);
stairs(Sx,pacusum1)

%% Alínea A iii
p2defeito = px(1,1) + px(1,2)+ px(1,3)

%% Alínea B i
clear;clc;
p =0.5; % probabilidade de vir defeituosa.
n = 5; % numero de peças
% É a distribuição Binomial com p = 0.5 e n= 5
for k=0:n
    pt(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k);% nchoosek(n,k)= n!/(n-k)!/k!
end
pt

% Gráfico da Distribuição Acumulada
Sx= 0:5;
pacusum1 = cumsum(pt);
stairs(Sx,pacusum1)
title("Funcao Distribuição Acumulada de SX");
%% Alínea B ii
% probabilidade de, no máximo, 2 das peças de uma amostra serem defeituosas
P = pt(1,1)+ pt(1,2) + pt(1,2)


%% ex 5 - motores avioes
% X = numero de motores que falham

% Vamos calcular a probabilidade de cair um aviao com 2 motores
%Aviao de 2 motores -> despenha-se quando ambos os motores falharem 
% (>50% dos motores falharem):
n = 2; % nº de motores
k = 2; % nº de motores a falhar
p = logspace(-3, log10(1/2),100);

p2Motores = nchoosek(n,k).*p.^k.*(1-p).^(n-k); % Atenção ao uso do . 
% para operacão elemento a elemento!!

%% Aviao de 4 motores -> despenha-se quando 3 ou 4 motores falharem
p4Motores = 0;
n = 4; % nº de motores

for k=3:4 % podem falhar 3 ou 4 motores
    p4Motores= p4Motores+ nchoosek(n,k).*p.^k.*(1-p).^(n-k);
end

%% Gráfico
figure(1);
hold on;

x = logspace(-3, log10(1/2),100);

plot(x,p4Motores);
plot(x,p2Motores);

legend("4 motores","2 motores");
xlabel('p');
ylabel('pX');
title("Variacao de pX em funcao de p");
hold off;
% Ate os dois graficos se intercetarem (analisando o grafico, a mais ou 
% menos p =  0.33) e mais seguro viajar no aviao com 4 motores. A partir 
% dai porém, e prerefirvel viajar no aviao com 2 motores.


%% ex 6 - data packet
% alinea a - sem erros

n = 800; % size_data_packet_bits = 100 * 8
p = 0.00001; %erro = 10^-5
k = 0; %para 0 erros

prob_binomial = nchoosek(n,k)*p^k*(1-p)^(n-k)

lambda = n * p; % lambda para poisson

poisson = (exp(-lambda) * power(lambda, k)) / factorial(k)

%% alinea b - pelo menos 2 erros

n = 8000; %1000 bytes * 8
p = 0.00001; %erro = 10^-5
k = 1; %minimo de erros - ou tem 0 ou 1 erros

lambda = n * p; % lambda para poisson

% binomial
aux = binopdf(0:k, n, p);
resultado_binomial = 1 - sum(aux)

%poisson
aux = poisspdf(0:k, lambda);
resultado_poisson = 1 - sum(aux)

%% ex 7 - mensagens por segundo
%alinea a

taxa_original = 5; %5 mensagens/segundo
tempo = 2; %2 segundos
lambda = taxa_original * tempo; %taxa nova = 10 msg em 2 segundods
N = 1e5;

simulacao = poissrnd(lambda, 1, N);

prob_simulacao = mean(simulacao < lambda)

%% alinea b - mais de 30 msg em 5 segundos

lambda = taxa_original * 5; %taxa nova = 10 msgs em 5 segundos
N = 1e5;

simulacao = poissrnd(lambda, 1, N);

prob_simulacao = mean(simulacao > 30)

%% ex 8 - var aleatoria X

%O parâmetro média (μ), que é o inverso da taxa (λ).
%Como λ=1, a média também será μ = 1/lambda ​= 1


% Parâmetros
lambda = 1;
mu = 1/lambda; % Média para a função exppdf
x = 0:0.1:10;  % Valores de 0 a 10 com passo de 0.1

% Cálculo da PDF (Probability Density Function)
y = exppdf(x, mu);

% Criação do Gráfico
plot(x, y, 'LineWidth', 2);
grid on;
title('Função Densidade de Probabilidade (Exponencial, \lambda=1)');
xlabel('x');
ylabel('f(x)');
legend(['\lambda = ' num2str(lambda)]);

%% ex 9 - var aleatoria
% alinea a
lambda = 0.2;
N = 1e5;
soma = sum(exprnd(1/lambda,1,N));
media = soma/N 

% alinea b
lambda = 0.2;
N = 1e5;
X = exprnd(1/lambda, 1, N);

s = 2;
t = 3;

P_conditional = sum((X > s + t) & (X > t)) / sum(X > t)
P_s = sum(X > s) / N
P_conditional_teo = exp(-lambda * s)
P_s_teo = exp(-lambda * s)

%% ex 11 - erros em livro 

% Exercício 8 da parte 2.2
clear;clc;
lambda= 0.02 *100;

% Probabilidadede que exista no máximo 1 erro num livro de 100 páginas
%Vamos ter de somar a probabilidade de ocorrer 0 erros + a probabilidade de
%ocorrer 1 erro

prob= 0;
%Distribuição de Poisson
for k=0:1
    prob = prob + ((lambda^k)/factorial(k))*exp(-lambda);
end

fprintf("Probabilidade de existir no máximo um erro num livro de 100 páginas = %0.4f \n", prob)

