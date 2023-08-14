""""
Create a new script.
Use the input() function to get input from the user. Store that input in a variable.
Find out what data type the output of input() is. See if it is different for different kinds of input (numbers, words, etc.).
"""

user_input = input("Please type something: ")

# print out and check what type input generates, this is always STR
print(f"This value is a {type(user_input)}: {user_input}")