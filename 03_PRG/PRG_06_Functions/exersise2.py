"""
Create a new script.
Write a custom function myfunction() that prints “Hello, world!” to the terminal. Call myfunction.
Rewrite your function so that it takes a string as an argument. Then, it should print “Hello, <string>!”.
"""

# Create the function myfunction()
def myfunction():
    # ask the user for an input
    user_input = input("Please write a random word: ")
    # print the output in a f-string
    print(f"Hello {user_input}!")

# Call the function we just made
myfunction()