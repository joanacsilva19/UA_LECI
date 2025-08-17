
# M*S
# multiplicação de matrizes não é comutativa!!!!!!!!!!

M = [[1, 2, 3], [4, 5, 6]] 
S = [[7, 8], [9, 0], [1, 2]]

rows_M = len(M)
cols_S = len(S[0])

assert rows_M == cols_S

#definir tamanho da matriz resultado
T = []
for i in range(rows_M):
    T.append([])
    for j in range(cols_S):
        T[i].append(0)

#preencher as entradas da matriz
for i in range(0, rows_M):
    for j in range(0, cols_S):
        for a in range(0, len(S)):
            T[i][j] += M[i][a] * S[a][j]
        
print(T)
        