def numberOfDigits(n):
    assert n >= 0
    #if n // 10 == 0:
    #    return 1
    if n == 0:
        return 0
    else:
        return numberOfDigits(n//10) + 1
        
if __name__ == "__main__":
    print(numberOfDigits(1234))