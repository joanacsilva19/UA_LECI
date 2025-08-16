#ex5
def max2(n1,n2):
    if(n1 > n2):
        return n1
    else: return n2
    
n1 = int(input("n1: "))
n2 = int(input("n2: "))

print(max2(n1, n2))

#ex6

def max3(n1,n2,n3):
    if(n1 > n2 and n1 > n3):
        return n1
    elif(n2 > n1 and n2 > n3):
        return n2
    else: return n3
    
n1 = int(input("n1: "))
n2 = int(input("n2: "))
n3 = int(input("n3: ")) 

print(max3(n1,n2,n3))        