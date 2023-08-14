"""
Create a new script.
Create a dictionary with the following keys and values:
Loop over the dictionary and print every key-value pair in the terminal.
""" 

# This function will create a new dictionary 
def add_employee():
    new_dict = {}

    # Assigning keys with a value via user input
    new_dict["First name"] = input("Please enter your first name: ").lower().title()
    new_dict["Last name"] = input("Please enter your last name: ").lower().title()
    new_dict["Job title"] = input("Please enter your job title: ").lower().title()
    new_dict["Company"] = input("Please enter your company: ").lower().title()

    # We return the new created dictionary
    return new_dict


# We give the key-values to a new variable by assigning the add_employee() to it
new_person = add_employee()

# We go trough the whole dictionary, printing out the key + value every loop.
for key in new_person:
    print(f"{key}: {new_person[key]}")