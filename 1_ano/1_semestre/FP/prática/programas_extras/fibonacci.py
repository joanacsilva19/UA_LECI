def fib(x):
    #calcula numeros de fibonacci
    assert x > 0
    if x == 1 or x == 2:
        return 1    
    else:
        return fib(x-2) + fib(x-1)

def seq_fib(y):
    #imprime a sequência de fibonacci até uma determinada ordem
    for i in range(1,y+1):
        print(fib(i))
    return 0

y = int(input("Digite quantos números terá a sequência: "))
assert y > 0
seq_fib(y)