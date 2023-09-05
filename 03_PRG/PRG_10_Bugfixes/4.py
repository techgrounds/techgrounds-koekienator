'''
The output should be:
there are 0 kids on the street
there are 1 kids on the street
there are 2 kids on the street
there are 3 kids on the street
there are 4 kids on the street
'''
foo = 0
# we iterate from 0 to 5 instead of till 5
# while foo <= 5:
while foo < 5:
	print('there are', foo, 'kids on the street')
	foo += 1