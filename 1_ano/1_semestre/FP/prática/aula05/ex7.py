def ispalindrome(katchau):
    str = katchau[::-1]
    if str == katchau:
        return True
    return False


katchau = input("palavra? ")
print(ispalindrome(katchau))

