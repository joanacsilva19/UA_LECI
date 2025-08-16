import math

ctp = float(input("CTP: "))
cp = float(input("CP: "))
assert 0.0 <= cp <= 20.0 and 0.0 <= ctp <= 20.0

notafinal = 66

if ctp >= 6.5 and cp >= 6.5:
    notafinal = 0.3*ctp + 0.7*cp
    if notafinal < 10.0:
        notafinal = 66
        print(f"nota final: {notafinal:.2f}")
        
        atpr = float(input("ATPR: "))
        apr = float(input("APR: "))
        assert 0.0 <= atpr <= 20.0 and 0.0 <= apr <= 20.0
        
        notarecurso = int(0.3*max(ctp,atpr) + 0.7*max(cp,apr))
        print(f"nota recurso: {notarecurso:.2f}")
    else:
        print(f"nota final: {notafinal:.2f}")    
        if notafinal == 66:
            atpr = float(input("ATPR: "))
            apr = float(input("APR: "))
            assert 0.0 <= atpr <= 20.0 and 0.0 <= apr <= 20.0
            
            notarecurso = 0.3*max(ctp,atpr) + 0.7*max(cp,apr)
            print(f"nota recurso: {notarecurso:.2d}")
else:
    print(f"nota final: {notafinal:.2f}")
    
    atpr = float(input("ATPR: "))
    apr = float(input("APR: "))
    assert 0.0 <= atpr <= 20.0 and 0.0 <= apr <= 20.0
    
    notarecurso = int(0.3*max(ctp,atpr) + 0.7*max(cp,apr))
    print(f"nota recurso: {notarecurso:.2f}")

