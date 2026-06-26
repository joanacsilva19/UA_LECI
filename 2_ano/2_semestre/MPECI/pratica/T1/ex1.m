bits = 1e4;
p_1 = 0.4;
p_0 = 0.6;
input = rand(1,bits) > p_0;

%alinea a
prob_0 = sum(input == 0)/bits
prob_1 = sum(input == 1)/bits 

%alinea b
p_det1_sab_int1 = 0.80; 
p_det0_sab_int0 = 0.85; 
p_det1_sab_int0 = 1 - p_det0_sab_int0;

input_int = rand(1, bits) < p_1; 
output_det = zeros(1, bits);

for i = 1:bits
    if input_int(i) == 1
        output_det(i) = rand < p_det1_sab_int1;
    else
        output_det(i) = rand < p_det1_sab_int0;
    end
end

prob_b_1 = sum(output_det)/bits
prob_b_0 = 1 - prob_b_1

%alinea c
total_det1 = 0; 
erros_int0 = 0;

for i = 1:bits
    if output_det(i) == 1
        total_det1 = total_det1 + 1;
        
        if input_int(i) == 0
            erros_int0 = erros_int0 + 1;
        end
    end
end

p_int0_sab_det1 = erros_int0 / total_det1

