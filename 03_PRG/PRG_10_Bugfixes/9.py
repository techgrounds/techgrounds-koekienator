'''
The output should be:
0
1
2
3
4
8
9
'''
for i in range(10):
    
	if i < 5:
		print(i)
	# we need to print > 7 or >= 8, the break will not allow us to print all if put in any of the statements
	# elif i < 8:
	# 	break
	# else:
	# 	print(i)
	elif i > 7:
		print(i)
	
