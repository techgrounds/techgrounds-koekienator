"""
Create a new script.
Create a list of five integers.
Use a for loop to do the following for every item in the list:
Print the value of that item added to the value of the next item in the list. 
If it is the last item, add it to the value of the first item instead (since there is no next item).
"""
import random

numbers = []

# loop 5 times to generate a list with random numbers 
for i in range(5):
    # Generate a random int 0 - 100
    numbers.append(random.randint(0,101))

print(f"My list: {numbers}")

# we need a var to check what the length is from our list
list_length = range(len(numbers))

def add_index_and_next_index_from_list(list_length):
    for i in list_length:
        # Create a new empty list every time
        new_number = []
        # if i equals the end of the list then we add it with 1st index
        if i == len(numbers) -1:
            new_number = numbers[i] + numbers[0]
            print(new_number)
        # else we just add current and next index in the list
        else:
            new_number = numbers[i] + numbers[i+1]
            print(new_number)

add_index_and_next_index_from_list(list_length)

"""
Tried to do it without making a new list, didn't work.
Googled a bit how this worked.
"""