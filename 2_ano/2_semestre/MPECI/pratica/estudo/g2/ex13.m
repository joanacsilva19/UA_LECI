media_peso = 20;
variancia_2 = 9;

% alinea a
% E[Sn] = 20n
% Var[Sn] = 9n

% alinea b - probability that a single cookie weights at least 30 g
% Desigualdade Markov = P(X >= a) <= E[x]/a
% P(X >= 30) <= 20*1 / 30 =~ 0.67

% alinea c
% Desigualdade Chebyshev = P(|X - miu| >= k) = variancia^2 / k^2
% P(|X - 20| <= 10) = 9/10^2 = 9/100 = 0.09

% alinea d
% E[100] = m = 20*100 = 2000
% Var[100] = 100*9 = 900; sigma^2 = Var <=> sigma = sqrt(Var)
% Sigma[100] = sqrt(Var[100]) = 30
% x1 = 1970
% x2 = 2030
% Z1 = (x1 - m)/sigma = -1
% Z2 = (x2 - m)/sigma = 1


