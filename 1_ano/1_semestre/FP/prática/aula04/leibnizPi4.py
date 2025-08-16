def leibnizPi4(n):
    resultado = 0
    for i in range(n):
        resultado = resultado + ((-1)**i)/(2*i+1)
    return resultado

def main():
    n = int(input("n: "))
    resultado = leibnizPi4(n)
    print(resultado)
    
main()
    