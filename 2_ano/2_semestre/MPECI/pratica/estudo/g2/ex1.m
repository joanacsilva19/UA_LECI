y_a = ones(1,6)/6;
x_a = (1:6);

stem(x_a,y_a);
xlabel('x');
ylabel('prob massa de x');
ylim([0,0.2]);
grid on

x_b = (0:7);
y_b = [0,cumsum(y_a),1];

stairs(x_b,y_b)
xlabel('x');
ylabel('cumulative distribution of x');
ylim([0,1.1]);
xlim([0,7]);
grid on

