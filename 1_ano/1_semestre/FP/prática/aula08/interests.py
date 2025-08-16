
def main():
    A = "reading"
    B = "eating"
    C = "traveling"
    D = "writing"
    E = "running"
    F = "music"
    G = "movies"
    H = "programming"

    interests = {
        "Marco": {A, D, E, F},
        "Anna": {E, A, G},
        "Maria": {G, D, E},
        "Paolo": {B, D, F},
        "Frank": {D, B, E, F, A},
        "Teresa": {F, H, C, D}
        }

    people = []
    interesses = []
    
    for key in interests.keys():
        people.append(key)
    
    for interesse in enumerate(interests.values()):
        interesses.append(interesse[1])
    
    pares = [(people[i],people[j]) for i in range(0, len(people)) 
                for j in range(i+1,len(people)) if people[i] != people[j]]
    print(pares)
    
    print("a) Table of common interests:")
    commoninterests = {[x for x in pares]:[y for y in "abc"]}  
    
    print(commoninterests)

    print("b) Maximum number of common interests:")
    maxCI = ...
    print(maxCI)

    print("c) Pairs with maximum number of matching interests:")
    maxmatches = ...
    print(maxmatches)

    print("d) Pairs with low similarity:")
    lowJaccard = ...
    print(lowJaccard)


# Start program:
main()

