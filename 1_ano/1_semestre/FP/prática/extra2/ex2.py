
import sys

def menu():
    op = int(input("Jornada? "))
    return op

def validarAposta(aposta):
    if aposta not in ["1", "2", "X", "1X", "X2", "12", "1X2"]:
        return False
    else: return True
    
def resultadoJogo(elemento1,elemento2):
    if elemento1 == elemento2:
        return "X"
    elif elemento1 > elemento2:
        return "1"
    else: 
        return "2"
        

def main():
    
    saldo = 0
    
    while True:
        
        apostasEquivalentes = 0
        apostasSimples = 0
        apostasDuplas = 0
        apostasTriplas = 0
        
        op = menu()
        
        if op == 0:
            print("Terminado.")
            sys.exit(0)
            
        while op not in [1,2,3,4,5,6,7,8,9,10,11,12,13]:
            print("Jornada inválida!")
            op = menu()
      
        
        file = open("Jornadas.csv")
        listaApostas = []
        numeroJogos = []
        
        jogoApostas = []
        
        for line in file:
            parts = line.split(',')
            jornada = parts[0]
            if op == int(jornada):
                parts[2] = parts[2].split("\n")
                jogoApostas.append([parts[1],parts[2][0]]) #jogo.append([anfitria, visitante])
        
        for i in range(1, len(jogoApostas)+1):
            aposta = input("{:d} - {} vs {}:  ".format(i, jogoApostas[i-1][0], jogoApostas[i-1][1]))
            while validarAposta(aposta) == False:
                print("Aposta inválida!")
                aposta = input("{:d} - {} vs {}: ".format(i, jogoApostas[i-1][0], jogoApostas[i-1][1]))
            
            numeroJogos.append(i)
            listaApostas.append(aposta)
            
            if len(aposta) == 2:
                apostasDuplas += 1
            elif len(aposta) == 3:
                apostasTriplas += 1
            else: apostasSimples += 1
            
        apostasEquivalentes += pow(1,apostasSimples)*pow(2,apostasDuplas)*pow(3,apostasTriplas)
        print("apostas eq: ", apostasEquivalentes)
        saldo -= apostasEquivalentes * 0.40 
        
        filename = "jornada{}.txt".format(op)
        
        with open(filename, "w") as f:
            for i in range(len(listaApostas)):
                f.write("{}, {}\n".format(numeroJogos[i], listaApostas[i]))
        
        file.close()
        
        file1 = open("Jogos.csv")
        
        jogo1 = []
        resultadoAnfitria1 = []
        resultadoVisitante1 = []    
        
        for line in file1:
            parts1 = line.split(',')
            parts1[-1].split("\n")
            jogo1.append([parts1[1],parts1[2]])
            resultadoAnfitria1.append(parts1[3])
            resultadoVisitante1.append(parts1[4][0])
            
        listaJogosTabela = [] #armazena os jogos que serão exibidos na tabela final
        resultadosTabela = [] #armazena os resultados dos jogos da jornada escolhida
        classificacaoJogos = [] #armazena a classificacao do resultado do jogo (1,2,X)
        classificacaoTotobola = [] #armazena se o jogador acertou ou errou a aposta que fez ("CERTO", "ERRADO")

        for j in jogoApostas:
            for t in jogo1:
                if j == t:
                    i = jogo1.index(t)
                    listaJogosTabela.append(t)
                    resultadosTabela.append([resultadoAnfitria1[i],resultadoVisitante1[i]])
                
        for i in range(len(resultadosTabela)):
            classificacaoJogos.append(resultadoJogo(resultadosTabela[i][0],resultadosTabela[i][1]))
        
        counterCertos = 0
        
        for i in range(len(resultadosTabela)):
            if classificacaoJogos[i] in listaApostas[i]:
                classificacaoTotobola.append("CERTO")
                counterCertos += 1
            else:
                classificacaoTotobola.append("ERRADO")
        
        if counterCertos == len(numeroJogos) and counterCertos != 0:
            premio = "GANHOU O 1º PRÉMIO."
            saldo += 5000
        elif counterCertos == 8:
            premio = "GANHOU O 2º PRÉMIO."
            saldo += 1000
        elif counterCertos == 7:
            premio = "GANHOU O 3º PRÉMIO."
            saldo += 100
        else: 
            premio = "SEM PRÉMIO."
        
        print("Jornada ", op)
        for i in range(len(numeroJogos)):
            print("{:<} {:>15s} {:>1s}-{:<1s} {:<20s} : {:<10} {:<s}".format(numeroJogos[i], listaJogosTabela[i][0], resultadosTabela[i][0], resultadosTabela[i][1], listaJogosTabela[i][1], listaApostas[i], '(' + classificacaoTotobola[i] + ')'))
        print("TEM {} CERTAS. {}".format(counterCertos, premio))
        print("SALDO: {:.2f} EURO".format(saldo))
        
        file1.close()
    
    
if __name__ == "__main__":
    main()
