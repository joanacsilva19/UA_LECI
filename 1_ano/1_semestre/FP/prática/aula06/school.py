# Complete o programa!

# a)
def loadFile(fname, lst):
    file = open(fname, 'r')
    file.readline()
    for line in file:
        separado = line.split("\t")
        tuplo = (int(separado[0]),separado[1],float(separado[5]),float(separado[6]),float(separado[7]))
        lst.append(tuplo)
    file.close()
    return lst
    
# b) Crie a função notaFinal aqui...
def notaFinal(reg):
    for i in range(len(reg)):
        notafinal = (reg[-1] + reg[-2] + reg[-3])/3
    return notafinal

# c) Crie a função printPauta aqui...
def printPauta(lst, filename):
    file = open(filename + ".txt", 'w')
    inicio = "{:<s}\t{:^50s}\t{:>s}".format("Numero","Nome","Nota")
    print(inicio)
    file.write(inicio)
    for reg in lst:
        nota = notaFinal(reg)
        numero = reg[0]
        nome = reg[1]
        linhas = "{:<d}\t{:^50s}\t{:>2.1f}".format(numero,nome,nota)
        print(linhas)
        file.write(linhas)
    file.close()
    
    
    

# d)
def main():
    lst = []
    # ler os ficheiros
    loadFile("school1.csv", lst)
    loadFile("school2.csv", lst)
    loadFile("school3.csv", lst)
    
    # ordenar a lista
    lst.sort()
    
    # mostrar a pauta
    filename = input("nome do ficheiro: ")
    printPauta(lst, filename)
    
    # escrever para um ficheiro
    

# Call main function
if __name__ == "__main__":
    main()


