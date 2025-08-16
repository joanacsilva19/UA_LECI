def menu():
    print("Opções:\n 1) Registar chamada\n 2) Ler ficheiro\n 3) Listar clientes\n 4) Fatura\n 5) Terminar")
    op = int(input("Opção? "))
    return op

def validarNumero(num:str):
    if '+' in num:
        if len(num) >= 4 and num[0] == '+' and num[1:].isalnum():
            return True
        else: return False
    elif len(num) >= 3 and num.isdigit():
        return True
    else: return False
        
def main():
    
    listaNumerosOp1 = []
    listaNumerosOp2 = []
    listaClientesOp3 = []
    
    while True:
        op = menu()
        while op not in [1,2,3,4,5]:
            op = menu()
        
        if op == 1:
            #Registar chamada
            telOrigem = input("Telefone origem? ")
            while validarNumero(telOrigem) == False:
                telOrigem = input("Telefone origem? ")
            telDestino = input("Telefone destino? ")
            while validarNumero(telDestino) == False:
                telDestino = input("Telefone destino? ")
            duracao = int(input("Duração (s)? "))
            
            numero = (telOrigem,telDestino,duracao)
            listaNumerosOp1.append(numero)
            
        elif op == 2:
            #ler ficheiro
            nome = input("Ficheiro? ")
            file = open(nome,"r")
            for line in file:
                parts = line.split()
                telOrigem = parts[0]
                telDestino = parts[1]
                duracao = parts[2]
                listaNumerosOp2.append((telOrigem,telDestino,duracao))
            
        elif op == 3:
            #Listar clientes (da opção 1 registar chamadas)
            for i in range(len(listaNumerosOp1)):
                if listaNumerosOp1[i][0] not in listaClientesOp3:
                    listaClientesOp3.append(listaNumerosOp1[i][0])
            listaFinalOp3 = sorted(listaClientesOp3)
            print("Clientes:", end=' ')
            for num in listaFinalOp3:
                print(num, end='  ')
            print()
        elif op == 4:
            #Fatura (da opção 1 registar chamadas)
            
            listaDuracaoOp4 = []
            listaDestinoOp4 = []
            listaCustoOp4 = []
            custoTotal = 0.0
            
            cliente = input("Cliente? ")
            
            for i in range(len(listaNumerosOp1)):
                if cliente == listaNumerosOp1[i][0]:
                    listaDestinoOp4.append(listaNumerosOp1[i][1])
                    listaDuracaoOp4.append(listaNumerosOp1[i][2])
                    
                    if listaNumerosOp1[i][1][0] == '2':
                        custo = (0.02/60)*listaNumerosOp1[i][2]
                        listaCustoOp4.append(custo)
                    elif listaNumerosOp1[i][1][0] == '+':
                        custo = (0.80/60)*listaNumerosOp1[i][2]
                        listaCustoOp4.append(custo)
                    elif listaNumerosOp1[i][1][0] == listaNumerosOp1[i][1][1]:
                        custo = (0.04/60)*listaNumerosOp1[i][2]
                        listaCustoOp4.append(custo)
                    else:
                        custo = (0.10/60)*listaNumerosOp1[i][2]
                        listaCustoOp4.append(custo) 
                        
            for n in listaCustoOp4:
                custoTotal += n                           
            
            print("Fatura do cliente", cliente)
            print(str.format("{:<12s}{:>12s}{:>12s}", "Destino", "Duração", "Custo"))
            for i in range(len(listaDestinoOp4)):
                print(str.format("{:<12s}{:>12d}{:>12.2f}",listaDestinoOp4[i],listaDuracaoOp4[i],listaCustoOp4[i]))
            print(str.format("Custo total: {:>.2f}", custoTotal))
                        
        else:
            exit()
        
        
if __name__ == "__main__":
    main()