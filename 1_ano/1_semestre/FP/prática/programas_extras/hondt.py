def hondt(votes, numseats):
    numseatsLista = []
    quocientes = []
    etapas = 0
    for i in range(len(votes)):
        numseatsLista.append(0) # cria a lista de lugares(inicializada a 0)
    
    while etapas <= numseats:
        
        for i in range(len(votes)):
            q = votes[i]/(numseatsLista[i] + 1)
            quocientes.append(q)
            #max = q[0]
            #for i in range(1,len(quocientes)):
                #if q[i] > max:
                    #max = q[i]
            
            #j = q.index(max)
            #print (j)
            
    
    print(quocientes)
        
        
        
    


print(hondt([15300,12000,6600,5100], 6)) # ---> [2,2,1,1]





