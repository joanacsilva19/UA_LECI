def tax(r):
    if(r <= 1000):
        return 0.1*r
    elif(r > 1000 and r <= 2000):
        return 0.2*r - 100
    else: return 0.3*r - 300
    

r =int(input("r: "))
print(tax(r))
