s = int(input("duração da chamada: "))

if s < 60:
    custo = 0.12
else:
    custo = 0.12 + (0.06/30)*(s-60)

print("O custo de uma chamada de {} segundos é: {} euros.".format(s,custo))