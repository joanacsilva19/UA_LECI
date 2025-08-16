rendimento = int(input("rendimento: "))
taxa = 0.0
deducao = 0
if rendimento < 10000:
    taxa = 0.05
    deducao = 0
elif 10000 <= rendimento < 20000:
    taxa = 0.1
    deducao = 500
else:
    taxa = 0.15
    deducao = 1500

imposto = taxa * rendimento - deducao

print(imposto)