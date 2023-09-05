"""
Create a new script.
Copy the code below into your script.
a = 'int'
b = 7
c = False
d = "18.5"
Determine the data types of all four variables (a, b, c, d) using a built in function.
Make a new variable x and give it the value b + d. Print the value of x. This will raise an error. Fix it so that print(x) prints a float.
Write a comment above every line of code that tells the reader what is going on in your script.
"""

a = "int"
b = 7
c = False
d = "18.5"

# Check what type the variable is
print(type(a))

# Check what type the variable is
print(type(b))

# Check what type the variable is
print(type(c))

# Check what type the variable is
print(type(d))

# Convert d to a float so we can add b + d
x = b + float(d)
print(x)