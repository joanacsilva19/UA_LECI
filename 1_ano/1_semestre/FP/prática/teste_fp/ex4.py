countries = [
    ("Grenada", "NA", 344.0, 108825),
    ("Portugal", "EU", 92212.0, 10310000),
    ("Brazil", "SA", 8515767.0, 214000000),
    ("Iceland", "EU", 103000.0, 366425),
    ("Japan", "AS", 377975.0, 125800000)
]

def morePop(countries, N):
    resultado = []
    final = []
    for i in range(len(countries)):
        if countries[i][3] > N:
            resultado.append([countries[i][2],countries[i][0], countries[i][3]])
    resultado.sort(key=lambda t: t[2])
    for i in range(len(resultado)):
        final.append((resultado[i][0],resultado[i][1]))
    return final

if __name__ == "__main__":
    print(morePop(countries,200000))