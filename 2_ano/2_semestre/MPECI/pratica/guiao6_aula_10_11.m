%% guiao 6

% ex 1
% 1. Consider a link for IP communications from one router to another router with a capacity of
% 100 Mbps (1 Mbps = 106 bps). The link supports one flow of IP packets whose throughput
% is 80 Mbps and the IP packet sizes are exponentially distributed with an average of 800
% Bytes. The link has an associated queue of size Q (in number of packets).
% (a) Compute the average packet delay (in milliseconds) and the packet loss rate (in %)
% suffered by the flow when the queue size is Q = 8 packets.

C = 100e6;            % link capacity in bps
throughput = 80e6;    % flow throughput in bps
mean_pkt_bytes = 800; % average packet size in Bytes
mean_pkt_bits = mean_pkt_bytes * 8; % in bits
Q = 8; % number of packets

% Arrival rate (packets per second)
lambda = throughput / mean_pkt_bits; % packets/s

% Service rate (packets per second)
mu = C / mean_pkt_bits; % packets/s

% Traffic intensity (utilization)
rho = lambda / mu;

K = Q + 1; % system capacity in packets

if abs(rho - 1) < 1e-12
    % rho ~= 1 special case: use limits
    p0 = 1 / (K + 0); % when rho->1, p0 = 1/(K+1) but using K already includes serve
    pK = p0;         % all states equally likely
else
    p0 = (1 - rho) / (1 - rho^(K+1));
    pK = p0 * rho^K;
end

% Effective arrival rate (accounting for blocked packets)
lambda_eff = lambda * (1 - pK);

% Average number in system L for M/M/1/K
if abs(rho - 1) < 1e-12
    L = K / 2;
else
    L = rho * (1 - (K+1)*rho^K + K*rho^(K+1)) / ((1 - rho) * (1 - rho^(K+1)));
end

% Average delay (time in system) W = L / lambda_eff
W = L / lambda_eff; % seconds

% Packet loss rate in percent = probability an arrival finds system full
loss_pct = pK * 100;

% Convert delay to milliseconds
avg_delay_ms = W * 1e3;

fprintf('Alinea a)\nAverage packet delay: %.3f ms\n', avg_delay_ms);
fprintf('Packet loss rate: %.3f %%\n\n', loss_pct);

% alinea b - Compute the minimum queue size Q such that the packet loss rate suffered by the flow
% is not higher than 0.1%.

target = 0.1; % percent

% search Q from current Q up to a reasonable limit
Qmin = 0;
Qmax = 10000; % safety cap
found = false;

for Qtest = Qmin:Qmax
    Ktest = Qtest + 1;
    if abs(rho - 1) < 1e-12
        % when rho -> 1, pK = 1/(Ktest+0) * 1 = 1/(Ktest) ??? 
        % Use limit: for rho=1, p_n = 1/(Ktest+1) for M/M/1/K with states 0..Ktest
        p0_test = 1 / (Ktest + 1);
        pK_test = p0_test; % all states equal
    else
        p0_test = (1 - rho) / (1 - rho^(Ktest+1));
        pK_test = p0_test * rho^Ktest;
    end
    loss_pct_test = pK_test * 100;
    if loss_pct_test <= target
        Q = Qtest;
        K = Ktest;
        pK = pK_test;
        loss_pct = loss_pct_test;
        % recompute lambda_eff, L, W, avg_delay_ms for this Q
        lambda_eff = lambda * (1 - pK);
        if abs(rho - 1) < 1e-12
            L = K / 2;
        else
            L = rho * (1 - (K+1)*rho^K + K*rho^(K+1)) / ((1 - rho) * (1 - rho^(K+1)));
        end
        W = L / lambda_eff;
        avg_delay_ms = W * 1e3;
        found = true;
        break
    end
end
    fprintf('Alinea b)\nMinimum queue size Q: %d packets\n', Q);
    fprintf('Resulting packet loss rate: %.5f %%\n\n', loss_pct);

%% ex 2

% 2. Consider a data service server such that, when the server is attending 250 simultaneous
% requests, it serves each request with an exponentially distributed time of 200 μsecs on
% average (1 μsecs = 10-6 seconds). The server receives service requests at an average rate 𝜆
% (in requests/sec) and has an acceptance limit of B simultaneous requests.
% (a) Compute the service blocking probability and the average service time per request
% when 𝜆 = 1.23 × 10^6 and B = 250.

lambda = 1.23e6;
mu = 250 / (200e-6);
rho = lambda / mu;

B_a = 250;
P_block_a = ((1 - rho) * rho^B_a) / (1 - rho^(B_a + 1));
L_a = rho / (1 - rho) - ((B_a + 1) * rho^(B_a + 1)) / (1 - rho^(B_a + 1));
lambda_eff_a = lambda * (1 - P_block_a);
W_a = L_a / lambda_eff_a;

fprintf('Alinea a)\nService blocking probability = %.4f%%\n', P_block_a * 100);
fprintf('Avg. service time per request = %.3f microseconds\n\n', W_a * 1e6);

% alinea b
% Plot the service blocking probability (in %) in one bar chart and the average service
% time per request (in μsecs) in another bar chart considering B = 200, 250, 300, 350 and
% 400, when 𝜆 = 1.23 × 106.

B_array = [200, 250, 300, 350, 400];
P_block_array = zeros(1, length(B_array));
W_array = zeros(1, length(B_array));

for i = 1:length(B_array)
    b = B_array(i);
    
    p_b = ((1 - rho) * rho^b) / (1 - rho^(b + 1));
    P_block_array(i) = p_b * 100; 
    
    l = rho / (1 - rho) - ((b + 1) * rho^(b + 1)) / (1 - rho^(b + 1));
    l_eff = lambda * (1 - p_b);
    W_array(i) = (l / l_eff) * 1e6;
end

figure;

subplot(1, 2, 1);
bar(B_array, P_block_array);
grid on;
xlabel('Acceptance limit B (no. of requests)');
ylabel('Blocking probability (%)');

subplot(1, 2, 2);
bar(categorical(B_array), W_array);
grid on;
xlabel('Acceptance limit B (no. of requests)');
ylabel('Avg. service time per requests (microsecs.)');

%% ex 3
% Consider a Call Center service with m operators such that each operator attends each client
% with an exponentially distributed time of 3 minutes. The service receives requests at an
% average rate 𝜆 (in requests/hour).
% (a) Compute the probability of all operators being occupied and the average queuing time
% per request when 𝜆 = 370 and m = 20.

lambda = 370/60; % 370 requests per hour; 370/60 requests per minute
miu = 1/3; % pedidos por minuto; 1 / miu = 3 minutes.
m = 20; % numero de operators

p = lambda/(m*miu);
aux = 0;

for k = 0:m-1
    aux = aux + ((m*p)^k) / factorial(k);
end

pi_0 = 1 / (aux + ((m*p)^m)/((factorial(m)*(1 - p))));

p_Q = ((m*p)^m) / ((factorial(m)*(1 - p))) * pi_0;

prob_Q = p_Q * 100;

% avg queuing time per request

W_Q = p/(lambda*(1-p))*p_Q; % tempo em minutos

fprintf('\nAlinea a)\nprob of all operators are ocupied: %.3f%%\n', prob_Q)
fprintf('avg queuing time per request: %.3f segundos\n\n', W_Q*60) % tempo em segundos

% alinea b
% When 𝜆 = 370, compute the minimum number m of operators required so that the
% average queuing time per request is not higher than 10 seconds. For the value of m
% found, compute the probability of all operators being occupied and the average
% queuing time per request.

% lambda = 370;
% W_Q < 10 sec

p_a = W_Q*60;


while p_a >= 10
    m = m + 1;
    p = lambda/(m*miu);
    aux = 0;
    for k = 0:m-1
        aux = aux + ((m*p)^k) / factorial(k);
    end

    pi_0 = 1 / (aux + ((m*p)^m)/((factorial(m)*(1 - p))));
    p_Q = ((m*p)^m) / ((factorial(m)*(1 - p))) * pi_0;
    prob_Q = p_Q * 100;

    W_Q = p/(lambda*(1-p))*p_Q;
    p_a = W_Q*60;
end

fprintf('Alinea b)\no numero minimo de operators é: %d.\n', m)
fprintf('prob of all operators are ocupied with new m: %.3f%%\n', prob_Q)
fprintf('avg queuing time per request: %.3f segundos\n', W_Q*60)

% grafico

m = 20;
miu = 1/3;
lambda_array = [320, 330, 340, 350, 360, 370, 380];
y_array = zeros(1, length(lambda_array));

for i = 1:length(lambda_array)
    lambda_i_per_min = lambda_array(i) / 60;
    p = lambda_i_per_min / (m * miu);
    aux = 0;
    
    for k = 0:(m-1)
        aux = aux + ((m * p)^k) / factorial(k);
    end
    
    pi_0 = 1 / (aux + ((m * p)^m) / (factorial(m) * (1 - p)));
    p_Q = ((m * p)^m) / (factorial(m) * (1 - p)) * pi_0;
    W_Q = p / (lambda_i_per_min * (1 - p)) * p_Q;

    y_array(i) = W_Q;
end

figure;

bar(lambda_array, y_array);
grid on;
xlabel('Arrival request rate per hour');
ylabel('Average queueing time (minutes)');

%% ex 4 - 

T = [0 0 4.0000 24.0000;
0.0014 0 0 0;
0.0056 0.5000 0 0;
0.0111 0 0 0];

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

server_avaliability = u(1) * 100

% server_avaliability = MTBF / (MTBF + MTTR)

MTBF_HARDWARE = 2 * 365 * 24; % 2 years
MTBF_HYPER = 180 * 24; % 180 days
MTBF_VM = 90 * 24; % 90 days

MTTR = 



