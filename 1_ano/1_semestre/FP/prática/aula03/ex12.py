def countdown(n):
    while(n != 0):
        print(n)
        countdown(n-1)
        return 0
    
n = int(input("n: "))
assert n > 0
countdown(n)