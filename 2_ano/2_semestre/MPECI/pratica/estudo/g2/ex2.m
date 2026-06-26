% ex 2 - notas
% alinea a 
% sampling space - {5*90,10*9,100} = {5,5,5,5,...,10,10,10,..,100}

notas = [5,10,100];
total_notas = 100;
p_5_euros = 90/total_notas;
p_10_euros = 9/total_notas;
p_100_euros = 1/total_notas;

% alinea b - valor da nota que se tira do saco
% sampling space = {5,10,100}
 y_values_b = [p_5_euros,p_10_euros,p_100_euros];

 stem(notas, y_values_b);
 grid on
 xlabel('notas')
 ylabel('prob mass function of notas')
 ylim([0,1])
 xlim([0,110])

 % alinea c - cumsum

 y_values_c = [0,cumsum(y_values_b),1]

 stairs([0,notas,101],y_values_c, '-o')
 xlabel('notas')
 ylabel('cumsum das notas')
 ylim([0,1.1])
 xlim([0,110])
 grid on

 
