"""
Create a new script.
Copy the code below into your script.
def avg():
	# write your code here

# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)
Write the custom function avg() so that it returns the average of the given parameters. 
You are not allowed to edit any code below the second comment.
"""

# Create the avg() function, put x, y as arguments required as input
def avg(x, y):
	# Average is x / y
	z = x / y
	# return the value of z, rounded to 2 numbers after the decimal
	return round(z, 2)

# you are not allowed to edit any code below here
x = 128
y = 255
z = avg(x,y)
print("The average of",x,"and",y,"is",z)