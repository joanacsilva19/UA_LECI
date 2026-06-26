std_dev = 10;
media_alunos = 100;
n = (5:7);
N = 1e5;

X = media_alunos + std_dev * randn(N,1);

cap_total = 0;
for i = n
    cap_alunos = i*20;
    prob = sum(X <= cap_alunos)/N
end


% b)

for i = n
    prob_b = normcdf(i*20,media_alunos,std_dev)
end

