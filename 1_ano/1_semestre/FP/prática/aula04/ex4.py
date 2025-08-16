def factorial(n):
    resultado = 1
    while n > 0:
        resultado = resultado * n
        n -= 1
    return resultado

def main():
    n = int(input("n: "))
    resultado = factorial(n)
    print(resultado)
    
main()