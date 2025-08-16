import math

a = float(input("cateto 1: "))
b = float(input("cateto 2: "))
c = math.hypot(a,b)

angulo = math.degrees(1/math.cos(a/c))
print("hipotenusa: " + str(c) +"\nangulo: " + str(angulo))