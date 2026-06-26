%% ex 1 - weather
%a
% transposta da matriz da tabela
Weather =[0.7,0.2,0.3;          %Sunny
          0.2,0.3,0.3;          %Cloudy
          0.1,0.5,0.4];         %Rainy
%b
sunny_3x = Weather(1,1)*Weather(1,1)
%c
Weather_3x = Weather^3
sunny_weekend_rainy = Weather_3x(1,3)* Weather(1,1)
%d
Jan = 31;
v = [1;0;0];
total = v;
for n = 2:31
    v = Weather * v;
    total = total + v;
end
total
%e
w = [0;0;1];
total_v1 = w;
for n = 2:31
    w = Weather * w;
    total_v1 = total_v1 + w;
end
total_v1
%f 
percentagem = [0.1;0.3;0.5];

total_chuva = sum(percentagem .* total)
total_v1_chuva = sum(percentagem .* total_v1)

%% ex 2 - grupos de estudantes

%   A B C
% A  
% B
% C
%a
groups = [ 1/3, 1/4, 0;
           1/3, 11/20, 1/2;
           1/3, 1/5, 1/2];
%b
students_day0 = [60;15;15];

% a = 60 
% b = 15
% c = 15

%c
students_day30 = students_day0 .*(groups^30)

%d

students_v1_day0 = [30;30;30];

students_v1_day30 = students_v1_day0 .*(groups^30)

%% ex 3 - imagem cadeia markov

%   A B C D 
% A
% B
% C
% D
% 
p = 0.4;
q = 0.6;
B = [p^2,(1-p)^2,p*(1-p),p*(1-p);
     0,0,0,1;
     0,0,0,1;
     q^2,q*(1-q),q*(1-q),(1-q)^2]

T = transpose(B)

T5 = T^5
T10 = T^10
T100 = T^100
T200 = T^200

%% ex 5 - hyperlinks on web pages

%    A   B   C   D   E   F

T = [0   1   0   0   0   0 %A
     0   0  1/2  0  1/2  0 %B
     0   0   0   1   0   0 %C
     0   0   1   0   0   0 %D
     1/3 1/3 0   0   0  1/3 %E
     0    0  0   0   0   0]'; %F

v = ones(6,1)/6;
pagerank = T^40*v
