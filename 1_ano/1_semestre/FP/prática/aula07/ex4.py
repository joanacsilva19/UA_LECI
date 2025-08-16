

#função aula05 ex4
def allMatches(teams):
   assert len(teams) >= 2
   lista = []
   for i in range(len(teams)):
      for j in range(len(teams)):
         if teams[i] != teams[j]:
            jogo = (str(teams[i]),str(teams[j]))
            lista.append(jogo)
   return lista

listaEquipas = []
equipa = '1'
while equipa != '0':
    equipa = input("Equipa? (pressione '0' quando terminar.) ")
    if equipa != '0' and len(equipa) >= 2:
        listaEquipas.append(equipa)
    
jogos = allMatches(listaEquipas)
resultado = {}

for e in jogos:
    print("Jogo: ", e)
    r1,r2 = input("Resultados de cada equipa(separados por vírgula): ").split(',')
    resultado[e] = (int(r1),int(r2))

tabela = {}
#tabela[equipa] = [vitorias, empates, derrotas, g marcados, g sofridos, pontos]
#PONTOS: ganhar - 3 pontos, derrota - 0 pontos, empate - 1 ponto

for jogo in 

