lambda = 1;
miu = 1/lambda;
x = (0:10);
M = exppdf(x,miu);

% a)
stem(x,M, '-o')
grid on

figure

% b)
N = 1e5;
x_b = exprnd(miu,1,N);

histogram(x_b, 100)
