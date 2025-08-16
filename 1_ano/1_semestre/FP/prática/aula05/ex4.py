"""
Escreva uma função que, dada uma lista de equipas de futebol,
crie e devolva uma lista de todos os jogos que se podem fazer entre elas.
Cada jogo deve ser representado por um tuplo de duas equipas distintas.
Por exemplo:
   allMatches(["FCP", "SCP", "SLB"])  ->
      [('FCP', 'SCP'), ('FCP', 'SLB'), ('SCP', 'FCP'), ..., ('SLB', 'SCP')]
Com 3 equipas deve obter 6 jogos, com 4 equipas deve obter 12 jogos.
"""

def allMatches(teams):
   assert len(teams) >= 2, "Requires two or more teams!"
   lista = []
   for i in range(len(teams)):
      for j in range(len(teams)):
         if teams[i] != teams[j]:
            jogo = (str(teams[i]),str(teams[j]))
            lista.append(jogo)
   return lista