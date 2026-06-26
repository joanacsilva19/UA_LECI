% Task 2 - ex 3
% alinea a - at least one colision with 10 keys in array of size 1000
T = 1000; %size of array
k = 10; %number of keys
N = 1e5;

counter = 0;
for i = 1:N
    positions = randi([1,T],k,1);
    if length(unique(positions)) < k
        counter = counter + 1;
    end
end

prob_a = counter/N


% alinea b - at least one colision
% ficheiro "hash.m"

% alinea c - no colisions in  50 keys
k = 50;
T = (100:100:1000);
y_values = zeros(1,length(i));
for i = 1:length(T)
    M = T(i);
    counter = 0;
    for j = 1:N
        positions = randi([1,M],k,1);
        if length(unique(positions)) == k
            counter = counter + 1;
        end
    end
    y_values(i) = counter/N;
end

plot(T,y_values, '-o')
grid on
xlabel("size of array T")
ylabel("prob of at least one colision")



