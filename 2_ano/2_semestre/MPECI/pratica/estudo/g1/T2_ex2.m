% ex 2 - targets and darts

n = 20; %darts
m = 100; %targets
N = 1e5;

counter = 0;
for i = 1:N
    throws = randi([1,m],1,n);
    if length(unique(throws)) < 20
        counter = counter + 1;
    end
end

prob_a = 1 - counter/N

prob_b = counter/N

% grafico
n_values = (10:10:100);
m_values = [1000, 100000];

for i = 1:2
    m = m_values(i); % numero fixo de alvos
    y_values = zeros(size(n_values));
    for j = 1:length(n_values)
        n = n_values(j); % Número de dardos atual
        counter = 0;
        for k = 1:N
            throws = randi([1, m], 1, n);
            if length(unique(throws)) < n
                counter = counter + 1;
            end
        end
        y_values(j) = counter/N;
    end

    subplot(1,2,i)
    plot(n_values, y_values, '-o')
    xlabel("darts")
    xticks(0:10:100)
    ylabel("throws")
    ylim([0.0 1.0])

    grid on
end


