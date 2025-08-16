teorica = 13.9
APF = float(input("nota: "))
pratica = ((20/100)*14.5 + (50/100)*APF)/(70/100)

if pratica < 6.5:
    print("RNM pratica\nnota pratica:", pratica)
else:
    nota = 0.3*teorica + 0.7*pratica

    if nota < 9.5: 
        print("RNM. nota: ", nota)
    else:
        print("nota: ", nota)