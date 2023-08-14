"""
Create a new script.
Use the input() function to ask the user of your script for their name. 
If the name they input is your name, print a personalized welcome message. 
If not, print a different personalized message.
"""

# ask for user input and make it lower case
user_input = input("Please enter your name: ").lower()

# check if the input is my name, added .title() to make the names start with a Capital again
if user_input == "marcel":
    print(f"Welcome back {user_input.title()}, it has been a longtime!")
# if not print a different message
else:
    print(f"Welcome {user_input.title()}, nice to meet you for the first time")

