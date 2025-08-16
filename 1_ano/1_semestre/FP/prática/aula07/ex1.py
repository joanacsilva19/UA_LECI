import unicodedata

letras = {}

f = open("lusiadas.txt", 'r', encoding='utf-8')
for line in f:
    for c in line:
        if c.isalpha():
            s = c.lower()
            if s in letras:
                letras[s] += 1
            else:
                letras[s] = 1



f.close()

for key,value in letras.items():
    print(key, ' ', value)