lambda = 0.02;
pages = 100;
N = 1e4;

counter = 0;
for i = 1:N
    a = poissrnd(lambda,1,pages);
    if sum(a) <= 1
        counter = counter + 1;
    end
end
prob = counter/N
