"""
Create a new script.
Ask the user of your script for a number. 
Give them a response based on whether the number is higher than, lower than, or equal to 100.
Make the game repeat until the user inputs 100.
"""

user_input = 0

# Continue this loop until the user input is 100
while user_input != 100:
    user_input = int(input("Please enter a number: "))

    # if the user input is 100, he guessed the correct number!
    if user_input == 100:
        print(f"{user_input} is a nice number! You finished this script")
    # if the user has an input higher than 0 and lower than 100 (1 - 99), continue the loop
    elif user_input > 0 and user_input < 100:
        print(f"{user_input} this number is to low!")
    # if the user has an input higher than 100 and lower than 201 (101 - 200), continue the loop
    elif user_input > 100 and user_input < 201:
        print(f"{user_input} this number is to high!" )
    # when all IF statements fail, tell user to input a number between 1 and 200
    else:
        print("Please enter a number between 1 and 200")

