# RESOLVERRRRRRR

def media(soma,n):
    resultado = soma/n
    return resultado

def main():
    n = 0
    soma = 0
    while True:
        user_input = input()
        if user_input == "": break
        else:
            soma = soma + int(user_input)
            n = n + 1
    
    print("soma: ",soma)
    media_n = media(soma,n)
    print("média: ",media_n)
    
main()