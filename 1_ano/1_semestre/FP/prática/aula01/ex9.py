andares = int(input("Número de andares: "))
moradores = int(input("Número de moradores: "))

altura = 3 #metros
viagensDiaMorador = 4
distancia = 0

for i in range(1,andares+1):
    distancia += 4*moradores*altura*i #metros
    
# tempo = distancia (velocidade = 1m/s)

print("A distancia num ano para {} moradores e {} andares é: {} km. \nO elevador está em funcionamento durante {} horas num ano.".format(moradores,andares,distancia*365*0.001,distancia*3600))
    
