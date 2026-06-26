%% alinea a - Determine the probability of the link being on each state.

e = [10e-6, 10e-5, 10e-4, 10e-3, 10e-2];
lambda = [8 5 2 1];
miu = [600 100 20 5];

co= [1 , lambda./miu];
co= cumprod(co);
u= co/sum(co);

fprintf('Alinea a)\nProb. do estado 10e-6: %.2e\n',u(1))
fprintf('Prob. do estado 10e-5: %.2e\n',u(2))
fprintf('Prob. do estado 10e-4: %.2e\n',u(3))
fprintf('Prob. do estado 10e-3: %.2e\n',u(4))
fprintf('Prob. do estado 10e-2: %.2e\n\n',u(5))

% alinea b - Determine the average time percentage the link is on each state
% igual à alinea a) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1

% alinea c - Determine the average holding time (in minutes) of the link on each state
% em minutos - t = (1/...)*60 = 60/...;

time = 1:length(lambda)+1;
for i = 1:length(lambda)+1
    if (i == 2) || (i == 3) || (i == 4)
        time(i) = 60/(miu(i-1)+lambda(i));
    elseif i == 1
        time(i) = 60/lambda(i);
    else
        time(i) = 60/miu(i-1);
    end
end

fprintf('Alinea c)\nAvg time on state 10e-6: %.2e min\n', time(1))
fprintf('Avg time on state 10e-5: %.2e min\n', time(2))
fprintf('Avg time on state 10e-4: %.2e min\n', time(3))
fprintf('Avg time on state 10e-3: %.2e min\n', time(4))
fprintf('Avg time on state 10e-2: %.2e min\n\n', time(5))

% alinea d - Determine the probability (in %) of
% a data frame of 100 Bytes to be received with
% errors (i.e., with at least one bit in error).

% prob(ter pelo menos 1 erro) = 1 - prob(nao ter erros)
% prob(nao ter erros) = prob(e(1) e nao ter erro) + prob(e(2) e nao ter
% erro) + ...

size = 800; % 1 byte = 8 bits

prob_n_ter_erros = 1:length(e);
prob_final = 1:length(e);

for i = 1:length(e)
    prob_n_ter_erros(i) = (1 - e(i))^size;
end

for i = 1:length(e)
    prob_final(i) = u(i)*(1-prob_n_ter_erros(i));
end

fprintf('Alinea d)\nProb ter erros: %.2f%%\n\n', sum(prob_final))

% alinea e - Determine the probability (in %) of a data frame of 1500 
% Bytes to be received without errors.

size_e = 1500*8;

prob_n_ter_erros_e = 1:length(e);

for i = 1:length(e)
    prob_n_ter_erros_e(i) = (1 - e(i))^size_e;
end

fprintf('Alinea e)\nProb nao ter erros: %.2f%%\n\n', sum(prob_n_ter_erros_e))

% alinea f - When a data frame of 1500 Bytes is received with errors, what 
% is the probability of the link being in state 10e-6? And in state 10e-2?

prob_e_sab_estado_10_6 = (1 - prob_n_ter_erros_e(1)) * u(1) / (1 - prob_n_ter_erros_e(1));
prob_e_sab_estado_10_2 = (1 - prob_n_ter_erros_e(5)) * u(5) / (1 - prob_n_ter_erros_e(5));

fprintf('Alinea f)\nProb state 10e-6: %.2e\n', prob_e_sab_estado_10_6)
fprintf('Prob state 10e-2: %.2e\n\n', prob_e_sab_estado_10_2)

%% ex 2 - software e hardware repairs lol
% aline b - Define, in Matlab, the corresponding state transition matrix.

T = [0 0 6;
    1/500 0 0;
    1/90 1 0];

% alinea c - Compute the limiting probabilities (in %) of each state.
n = length(T);
Q = T;
for i = 1:n
    Q(i,i) = -sum(T(:,i)); % Subtração dos valores da coluna i de T
end
M = [Q; ones(1,n)];
x = [zeros(n,1);1];
u = M\x;
fprintf('Alinea c)\nProb. do estado 0: %.2f%%\n',u(1)*100);
fprintf('Prob. do estado H: %.2f%%\n',u(2)*100);
fprintf('Prob. do estado S: %.2f%%\n\n',u(3)*100);

% alinea d - What is the probability (in %) of the server being available?
% prob de estar no estado 0
fprintf('Alinea d) %.2f%%\n\n', u(1)*100);

% alinea e - What is the average time (in hours) that the server is down
% in one month of 30 days?

p_down_30d_horas = (u(2) + u(3))*30*24;
fprintf('Alinea e)\nProb. de estar em baixo em 30 dias (em horas): %2.2f', p_down_30d_horas)

%% ex 3 - 100 servers
N = 100;
lambda_val = 1/200;
mu_val = 2/3;

t = 1;
lambda = (N:-1:1) * lambda_val;
miu = min(1:N, t) * mu_val;
co = [1, lambda ./ miu];
co = cumprod(co);
u = co / sum(co);
a_i = sum((0:N) .* u);
a_ii = sum(min((0:N), t) .* u);
a_iii = sum(u(1:10)) * 100;
fprintf("\na) %.4f %.4f %.4f\n", a_i, a_ii, a_iii);

t = 2;
lambda = (N:-1:1) * lambda_val;
miu = min(1:N, t) * mu_val;
co = [1, lambda ./ miu];
co = cumprod(co);
u = co / sum(co);
b_i = sum((0:N) .* u);
b_ii = sum(min((0:N), t) .* u);
b_iii = sum(u(1:10)) * 100;
fprintf("b) %.4f %.4f %.4f\n", b_i, b_ii, b_iii);

t = 3;
lambda = (N:-1:1) * lambda_val;
miu = min(1:N, t) * mu_val;
co = [1, lambda ./ miu];
co = cumprod(co);
u = co / sum(co);
c_i = sum((0:N) .* u);
c_ii = sum(min((0:N), t) .* u);
c_iii = sum(u(1:10)) * 100;
fprintf("c) %.4f %.4f %.4f\n", c_i, c_ii, c_iii);

%% ex 4
%Consider a M/M/1 queuing system such that the arriving rate of clients is 𝜆 = 8 clients per
%minute and the average serving time of each client is 1/𝜇 = 0.1 minutes.
%(a) What is the average time each client stays in the system?
%(b) What is the average server occupation (in %)?
%(c) What is the average queue occupation, i.e., the average number of clients in the queue?
%(d) What is the probability (in %) of the queue occupation becoming larger than 6 clients?
%And larger than 20 clients? And larger than 40 clients?
%(e) Using Matlab plot function, plot a graph of the average time each client stays in the
%system as a function of the client arriving rate 𝜆 (from 𝜆 = 1 to 𝜆 = 9).

lambda = 8;
mu = 1 / 0.1;
rho = lambda / mu;

Average_time = 1 / (mu - lambda);
fprintf("average time: %.1f min\n",Average_time)

server_ocupation = rho * 100;
fprintf("server ocupation: %.2f%%\n",server_ocupation)

Average_queue = (rho^2) / (1 - rho);
fprintf("average queue: %.2f\n",Average_queue)

clients_6 = (rho^(6 + 2)) * 100;
clients_20 = (rho^(20 + 2)) * 100;
clients_40 = (rho^(40 + 2)) * 100;
fprintf("6 clients: %.4f\n20 clients: %.4f\n40 clients: %.4f\n",clients_6,clients_20,clients_40);

lambda_plot = 1:9;
W_plot = 1 ./ (mu - lambda_plot);

figure;
plot(lambda_plot, W_plot, '-o');
grid on;

%% ex 5
%Consider a M/M/1/m queuing system such that the arriving rate of clients is 𝜆 = 80 clients
%per second, the average serving time of each client is 1/𝜇 = 0.01 seconds and the system
%capacity is m = 10 clients. Clients are discarded when they arrive and the system is full.
%(a) What is the probability of each client being discarded?
%(b) What is the average time (in milliseconds) each client stays in the system when it is
%not discarded?
%(c) What is the average queue occupation?
%(d) Using Matlab bar function, plot a bar chart of the client discard probability as a
%function of the system capacity m (for m = 5, 10, 15, …, 40). What do you conclude
%from this chart?

lambda = 80;
mu = 100;
m = 10;
traffic = lambda / mu;

Discart_probability = ((1 - traffic) / (1 - traffic^(m + 1))) * traffic^m;
fprintf('a) Discart probablity: %.4f \n', Discart_probability);

average_ocupation = (traffic / (1 - traffic)) - ((m + 1) * traffic^(m + 1) / (1 - traffic^(m + 1)));
arrival_rate = lambda * (1 - Discart_probability);
Average_time = average_ocupation / arrival_rate * 1000;

fprintf('b) Average time: %.4f\n', Average_time);

Average_queue = average_ocupation - (arrival_rate / mu);
fprintf('c) Average queue time: %.4f\n', Average_queue);

m_values = 5:5:40;
n_values = zeros(size(m_values));

for i = 1:length(m_values)
    mi = m_values(i);
    n_values(i) = ((1 - traffic) / (1 - traffic^(mi + 1))) * traffic^mi * 100;
end

figure;
bar(m_values, n_values);
grid on;
