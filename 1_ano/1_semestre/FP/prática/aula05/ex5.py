def countDigits(str):
    if str.isdigit() == True:
        return len(str)
    else:
        counter = 0 
        for i in range(len(str)):
            if str[i].isdigit() == True:
                counter += 1
        return counter
    

str = input("Digite uma string: ")
print(countDigits(str))