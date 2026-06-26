%% alinea a - Probability of the link being on each state 
% metodo geral

T= [0 600 0  0  0
    8  0 100 0  0
    0  5  0  20 0
    0  0  2  0  5
    0  0  0  1  0];

n= length(T);
Q= T;
for i= 1:n
Q(i,i)= -sum(T(:,i)); % Subtração dos valores da coluna i de T
end
M= [Q; ones(1,n)];
x= [zeros(n,1);1];
u= M\x;
fprintf('Prob. do estado 0: %.2e\n',u(1));
fprintf('Prob. do estado 1: %.2e\n',u(2));
fprintf('Prob. do estado 2: %.2e\n',u(3));
fprintf('Prob. do estado 3: %.2e\n',u(4));
fprintf('Prob. do estado 4: %.2e\n',u(5));

%% como a cadeia de markov é um processo de nascimento e morte, pode se usar outro método.
% alinea b é igual à a

lambda= [8 5 2 1];
miu= [600 100 20 5];
co= [1 , lambda./miu];
co= cumprod(co);
u= co/sum(co);
fprintf('Prob. do estado 0: %.2e\n',u(1));
fprintf('Prob. do estado 1: %.2e\n',u(2));
fprintf('Prob. do estado 2: %.2e\n',u(3));
fprintf('Prob. do estado 3: %.2e\n',u(4));
fprintf('Prob. do estado 4: %.2e\n',u(5));

%% alinea c - Average time percentage the link is on each state

T= [0 600 0  0  0
    8  0 100 0  0
    0  5  0  20 0
    0  0  2  0  5
    0  0  0  1  0];

tempo = sum(T);

resultado = zeros(1,length(tempo));
for i=1:length(tempo)
    resultado(i) = (60/tempo(i));
end

for i=1:length(tempo)
    fprintf('Avg holding time estado %d: %.2f min\n',i-1,resultado(i));
end


%% alinea d - probability (in %) of a data frame of 100 Bytes to be received with
% errors (i.e., with at least one bit in error)

% resultado = 1 - prob(0 erros);

lambda_d = [8 5 2 1];
miu_d = [600 100 20 5];
co_d = [1 , lambda_d ./ miu_d];
co_d = cumprod(co_d);
prob_d = co_d / sum(co_d); % prob de estar em cada estado

nbits = 800; % 100 * 8 bits (1 byte = 8 bits)

ber = [1e-6 1e-5 1e-4 1e-3 1e-2];
pE = 1 - (1 - ber) .* nbits;

resp = sum(prob_d .* pE)



%% ex 3
a = (100:-1:0);
lambda_a = a ./ 200;
miu_a = a .* (24/36);

co_a = [1 , lambda_a./miu_a];
co_a = cumprod(co_a);
u_a = co_a/sum(co_a);
 

%a)
N = 100; 
lambda = 1/200; 
mu = 2/3;
t = 1;
pi = zeros(1, N+1); 
pi(1) = 1;

for n = 0:N-1
    lambda_n = (N - n) * lambda;
    mu_next = min(n + 1, t) * mu;
    pi(n+2) = pi(n+1) * (lambda_n / mu_next);
end
pi = pi / sum(pi);

a_i = sum((0:N) .* pi);
a_ii = sum(min((0:N), t) .* pi);
a_iii = sum(pi(1:10)) * 100;
fprintf("a)\n a_i) %.4f;\n a_ii) %.4f;\n a_iii) %.4f;\n\n",a_i,a_ii,a_iii)

%b)
t=2;
for n = 0:N-1
    lambda_n = (N - n) * lambda;
    mu_next = min(n + 1, t) * mu;
    pi(n+2) = pi(n+1) * (lambda_n / mu_next);
end
pi = pi / sum(pi);

b_i = sum((0:N) .* pi);
b_ii = sum(min((0:N), t) .* pi);
b_iii = sum(pi(1:10)) * 100;
fprintf("b)\n b_i) %.4f;\n b_ii) %.4f;\n b_iii) %.4f;\n\n",b_i,b_ii,b_iii)

%c)
t=3;
for n = 0:N-1
    lambda_n = (N - n) * lambda;
    mu_next = min(n + 1, t) * mu;
    pi(n+2) = pi(n+1) * (lambda_n / mu_next);
end
pi = pi / sum(pi);

c_i = sum((0:N) .* pi);
c_ii = sum(min((0:N), t) .* pi);
c_iii = sum(pi(1:10)) * 100;
fprintf("c)\n c_i) %.4f;\n c_ii) %.4f;\n c_iii) %.4f;\n",c_i,c_ii,c_iii)

%% ex 4
% a)
lambda_4a = 8;
miu_4a = 1/0.1;

L = lambda_4a / (miu_4a - lambda_4a);

% teorema de little --> L = lambda * W
W = L / lambda_4a;
fprintf('a) tempo medio permanencia sistema --> %.2f minutos;\n', W)

% b) ???????

% c)

W_q = W - 1/miu_4a;
L_q = (lambda_4a ^ 2) / (miu_4a * (miu_4a - lambda_4a));

fprintf('c) numero medio clientes fila espera --> %.2f clientes;\n',L_q)

% d)

