'''
The output should be:
a5|||5|||5|||a5|||5|||5|||a5|||5|||5|||
'''
foo = ''
for i in range(3):
	foo += 'a'
	for j in range(3):
		foo += '5'
		# just needed to indent the next loop to be in the current loop
		for k in range(3):
			foo += '|'

print(foo)