# coding: utf-8
# This program finds the maximum of three numbers.
# It uses the built-in max function.
# Can you do it with a conditional statement (if / if-else) instead?

x1 = float(input("number? "))
x2 = float(input("number? "))
x3 = float(input("number? "))

# Use a conditional statement instead of max function!
#mx = max(x1, x2, x3)

if x2 > x1 and x2 > x3:
    mx = x2
elif x1 > x2 and x1 > x3:
    mx = x1
else:
    mx = x3

print("Maximum:", mx)

