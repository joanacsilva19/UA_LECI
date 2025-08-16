# Complete este programa como pedido no guião da aula.

def listContacts(dic):
    """Print the contents of the dictionary as a table, one item per row."""
    print("{:>12s} : {}".format("Numero", "Nome"))
    for num in dic:
        print("{:>12s} : {}".format(num, dic[num]))

def filterPartName(contacts, partName):
    """Returns a new dict with the contacts whose names contain partName."""
    ...

def AddContacts(name, number, contactos):
    contactos[number] = name
    return None

def RemoveContacts(number, contactos):
    for key in contactos:
        if key == number:
            del contactos[key]
            break
    return None

def SearchNumber(number, contactos):
    for key in contactos.keys():
        if key == number:
            return(contactos.get(key))
        else: continue
    return(number)

def menu():
    """Shows the menu and gets user option."""
    print()
    print("(L)istar contactos")
    print("(A)dicionar contacto")
    print("(R)emover contacto")
    print("Procurar (N)úmero")
    print("Procurar (P)arte do nome")
    print("(T)erminar")
    op = input("opção? ").upper()   # converts to uppercase...
    return op


def main():
    """This is the main function containing the main loop."""

    # The list of contacts (it's actually a dictionary!):
    contactos = {"234370200": "Universidade de Aveiro",
        "727392822": "Cristiano Aveiro",
        "387719992": "Maria Matos",
        "887555987": "Marta Maia",
        "876111333": "Carlos Martins",
        "433162999": "Ana Bacalhau"
        }

    op = ""
    while op != "T":
        op = menu()
        if op == "T":
            print("Fim")
        elif op == "L":
            print("Contactos:")
            listContacts(contactos)
        elif op == "A":
            name = input("nome: ")
            number = input("número: ")
            AddContacts(name, number, contactos)
        elif op == "R":
            number = input("número a remover: ")
            RemoveContacts(number, contactos)
        elif op == "N":
            number = input("número a procurar: ")
            print(SearchNumber(number, contactos))
        else:
            print("Não implementado!")
    

# O programa começa aqui
main()

