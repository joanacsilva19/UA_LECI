function array_hash = hash(k,T)
    N = 1e5;
    counter = 0;
    for i = 1:N
        positions = randi([1,T],k,1);
        if length(unique(positions)) < k
            counter = counter + 1;
        end
    end
    array_hash = counter/N;
end