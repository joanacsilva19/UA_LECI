
#A)
# Given a string, return a string composed first of all characters at even 
# positions and then of all characters at odd positions.

def evenThenOdd(s):
   s1 = s[::2]
   s2 = ''
   for i in range(len(s)):
      if i%2 != 0:
         s2 += s[i]
   return s1+s2
   


# B)
# Given a string s, return the string with adjacent duplicates removed. 
# For example, Mississippi yields Misisipi. You may assume there is at least 
# one character in the given string. 

def removeAdjacentDuplicates(s):
   nova = ''
   for i in range(len(s)):
      if s[-i] != s[-i+1]:
         nova += s[i]
   return nova



# C)
# Given an integer n, return a list containing 
# 1 2 2 3 3 3 4 4 4 4 ... and finally n repeated n times.
# You may assume n is 0 or greater.

def reapeatNumTimes(n):
   num = 0
   lista = []
   while num <= n:
      for i in range(num):
         lista.append(num)
      num += 1
   return lista



#D)
# Given a list of integers, return the 
# position of the first occurrence of the largest element.
# You may assume the given list has at least one element.
# Do not use the index, find, or max methods.

def positionOfFirstLargest(arr):
   max = arr[0]
   arr1 = sorted(arr)
   for i in range(len(arr)):
      if arr[i] >= max:
         max = arr[i]
      if arr[i] == arr1[-1]:
         position = i
         break
   return position
   


