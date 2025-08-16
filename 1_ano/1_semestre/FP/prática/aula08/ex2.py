
file = open("names.txt",'r')

apelidos = {}

file.readline()
for line in file:
    parts = line.split(' ')
    apelido = parts[-1].removesuffix('\n')
    if apelido not in apelidos.keys():
        apelidos[apelido] = {parts[0]}
    else:
        apelidos[apelido].add(parts[0])

print(apelidos)
    