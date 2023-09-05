'''
We start with generating a random number 1 - 100. 
Set variables we need later to 0.

The while loop checks if we had 7 attempts or less.
We start of with asking the user with an input and increase tries by 1.

User input is the correct number. Yes? Break while loop, else continue.
User input is lower than number. Yes? give hint his number is to high, else continue.
User input is higher than number. Yes? give hint his number is to low, else continue.
User input is invalid, return to start of the while loop.

When out of the while loop, we check if tries == 7.
If so the user lost.
'''

import random

guess_number = random.randint(1, 100)
user_input = 0
tries = 0

# Used this to test the win condition
#print(guess_number)

# Continue as long as user input is below 7 (7 tries to win)
while tries < 7:
    user_input = int(input("Please enter a number: "))
    tries += 1

    # if the user input is 100, he guessed the correct number!
    if user_input == guess_number:
        print(f"{user_input} is a nice number! You finished this script")
        break
    # if the user has an input higher than 0 and lower than guess_number, continue the loop
    elif user_input > 0 and user_input < guess_number:
        print(f"{user_input} this number is to low!")
    # if the user has an input higher than guess_number and lower than 101, continue the loop
    elif user_input > guess_number and user_input < 101:
        print(f"{user_input} this number is to high!" )
    # when all IF statements fail, tell user to input a number between 1 and 100
    else:
        print("Please enter a number between 1 and 100")

# when the user broke from the while loop and his tries equal 7, the user lost
if tries == 7:
    print("You have lost the game")
    print(f"The number was: {guess_number}")


