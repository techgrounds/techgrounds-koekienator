'''
The output should be:
4
16129
'''
def square(x):
	return x**2

nr = square(2)
print(nr)

foo = 127
big = square(foo)
print(big)

# This is after the point where it is called
# Must be placed above big = square(foo)
# foo = 127