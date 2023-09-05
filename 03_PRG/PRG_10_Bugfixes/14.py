'''
The output should be:
True
'''
def rtn(x):
	return(x)

foo = rtn(3)

# since foo is 3 we change it to lesser than 4
# if foo > rtn(4):
if foo < rtn(4):
	print(True)
else:
	print(False)