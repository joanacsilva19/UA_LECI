def shorten(str):
    parts = str.split(" ")
    nova = ""
    for i in range(len(parts)):
        if len(parts[i]) > 2:
                nova += parts[i][0]
    return nova.upper()

str = input("Digite uma string: ")
print(shorten(str))