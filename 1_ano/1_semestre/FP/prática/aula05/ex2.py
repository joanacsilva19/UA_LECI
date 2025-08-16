#a)
def inputFloatList(user_input, lista):
    lista.append(user_input)
    return lista

#b)
def countLower(lista,v):
    counter = 0
    for i in lista:
        if float(i) < v:
            counter += 1
    return counter      

#c)
def minmax(lista):
    lista1 = sorted(lista)
    maximo = max(lista1)
    minimo = min(lista1)
    return minimo,maximo

# d) e main
def main():
    lista = []
    while True:
        user_input = input()
        if user_input == "": break
        else:
            lista_float = inputFloatList(user_input, lista)
    print(lista_float)
    v = float(input("digite um valor: "))
    contador = countLower(lista,v)
    print(contador, "valores são inferiores a", v)
    minimo = minmax(lista)[0]
    maximo = minmax(lista)[1]
    print("O mínimo é:",minimo,"\nO máximo é:",maximo)
    
    #d)
    media = (int(minimo) + int(maximo))/2
    inf_a_media = countLower(lista,media)
    print("A média entre o mínimo e o máximo é: {} \n {} números são inferiores a {}".format(media,inf_a_media,media))
    
main()
    