def score(guess, secret):
    bulls = 0
    cows = 0
    for i in range(len(guess)):
        if guess[i] in secret:
            cows += 1
        if guess[i] == secret[i]:
            bulls += 1
            cows -= 1
            
    return (bulls, cows)        

if __name__ == "__main__":
    print(score('1234','4271'))
    