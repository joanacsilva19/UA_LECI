# Complete the code to make the HiLo game.
# i added a counter to show how many tries were needed until the guess is right

import random

def playHiLo():
    # Pick a random number between 1 and 100, inclusive
    secret = random.randrange(1, 101); # 101, exclusive

    print("I picked a number between 1 and 100. Can you guess it?")
    # put your code here
    guess = -1
    tries = 0
    while(guess != secret):
        guess = int(input("guess: "))
        if guess < secret:
            print("too LOW :( try again.")
        else: print("too HIGH :( try again.")
        tries += 1
    
    print("\nCongrats! You guessed it!\nYou needed {} tries.\n".format(tries))


playHiLo()

