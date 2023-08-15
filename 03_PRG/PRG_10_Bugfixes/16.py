'''
Removed the win == False condition from the while loop.
Instead winning now breaks the whole loop.

Last if statement now checks for total tries.
When it's more than 7 tries you lost. 

'''
import random

# generate random int
goal = random.randint(1,100)

# We no longer need this variable
# win = False

tries = 0

# Removed the win contrition and added a break if input == goal.
# while win == False and tries < 7:
while tries < 7:
	try:
		# ask for input
		inpt = int(input("Please input a number between 1 and 100: "))
		# count attempt as a try
		tries += 1

		# check for match
		if inpt == goal:
			# Changed win == True to Break, moved break below the print()
			# win = True
			print("Congrats, you guessed the number!")
			print("It took you", tries, "tries")
			break
		# give hints
		elif inpt < goal:
			print("The number should be higher")
		else:
			print("The number should be lower")

	except:
		print("Please type an integer")

# changed win == False to tries == 7
# if win == False:
if tries == 7:
	print("Game over! You took more than seven tries")