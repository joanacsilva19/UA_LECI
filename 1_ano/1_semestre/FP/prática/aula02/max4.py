# coding: utf-8
# This program finds the maximum of four numbers.
# It uses the built-in max function.
# Can you do it with a conditional statement (if / if-else) instead?

x1 = float(input("number? "))
x2 = float(input("number? "))
x3 = float(input("number? "))
x4 = float(input("number? "))

# Use a conditional statement instead of max function!
#mx = max(x1, x2, x3, x4)

if x2 > x1 and x2 > x3 and x2 > x4:
    mx = x2
elif x1 > x2 and x1 > x3 and x1 > x4:
    mx = x1
elif x3 > x1 and x3 > x2 and x3 > x2:
    mx = x3
else:
    mx = x4

print("Maximum:", mx)

