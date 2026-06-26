    % R G B
T = [0,    0,  1/3; % R
    3/10, 4/10, 1/3; % G
    7/10, 6/10, 1/3  % B
    ]';

% aliena c
prob_b = T(3,1)*T(2,3)^5*T(2,2) * 100

%alinea d

T_limite = T^1e3; 
prob_limite = T_limite(1, :)


