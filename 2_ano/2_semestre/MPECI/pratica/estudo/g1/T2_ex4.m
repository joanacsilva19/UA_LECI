% Task 2 - ex 4

N = 1e5;
d = 365;
n = 1;
p = 0.5;
prob_a = 0;

while prob_a <= p
    n = n + 1;
    counter = 0;
    for i = 1:N
        birthdays = randi([1,d],n,1);
        if length(unique(birthdays)) < n
            counter = counter + 1;
        end
    end
        prob_a = counter/N;
end
n

% alinea b
p = 0.9;
prob_b = 0;
n_b = 1;
while prob_b <= p
    n_b = n_b + 1;
    counter_b = 0;
    for i = 1:N
        birthdays_b = randi([1,d],n_b,1);
        if length(unique(birthdays_b)) < n_b
            counter_b = counter_b + 1;
        end
    end
        prob_b = counter_b/N;
end
n_b


