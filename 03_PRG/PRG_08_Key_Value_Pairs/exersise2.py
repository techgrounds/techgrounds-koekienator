"""
Create a new script.
Use user input to ask for their information (first name, last name, job title, company). Store the information in a dictionary.
Write the information to a csv file (comma-separated values). 
The data should not be overwritten when you run the script multiple times.
"""
import os 
import csv


# clear screen function
def clear():
    '''clear the console'''
    # Clear the console screen depending on the operating system
    os.system('cls' if os.name == 'nt' else 'clear')

# This function will create a new dictionary 
def add_employee():
    '''create a new employee'''
    new_dict = {}
    # Assigning keys with a value via user input
    new_dict["First name"] = input("Please enter your first name: ").lower().title()
    new_dict["Last name"] = input("Please enter your last name: ").lower().title()
    new_dict["Job title"] = input("Please enter your job title: ").lower().title()
    new_dict["Company"] = input("Please enter your company: ").lower().title()

    # We return the new created dictionary
    return new_dict

#function to add our new dictionary to a csv file
def add_to_csv(person_to_add_to_csv):
    '''write a new employee to a csv file'''
    new_list = []
    new_list.append(person_to_add_to_csv)

    # Just testing if .append worked
    # print(new_list)

    # Her we open the file we want to write to including the path!!
    with open("03_PRG/PRG_08_Key_Value_Pairs/names.csv", mode="a+") as csvfile:

        # Since our list already has key-values, we name the fieldnames the same as in our list
        fieldnames = new_list[0].keys()

        # This allows us to write to the file and pick our own field names
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames, dialect="unix")

        # Every entry is the value from the key in new_list
        for key in new_list:
            writer.writerow(key)

def add_more():
    user_input = input("Do you want to add more people? y/n \n")
    # return False if user wants to stop
    if user_input == "n":
        return False
    # return True if user wants to continue
    elif user_input == "y":
        clear()
        return True
    # return add_more() if user has an invalid input
    else:
        print("please enter a valid input")
        return add_more()

# function that will run add_employee() and add_to_csv() in a loop till user stops it
def csv_converter():
    '''Create new employee and add to a csv file, prompt if use want's to continue'''
    new_person = add_employee()
    add_to_csv(new_person)
    if add_more() == True:
        csv_converter()

def main():
    '''the main program'''
    clear()
    csv_converter()  

main()

'''
Was stuck on add_more() for a few hours.
With user input "n" the loop in csv_converter() kept going.
Used while and if, neither worked.
Even suggestions from ChatGPT or Bard didn't help.
After a while I tried if add_more() could be in a statement.
It finally worked
'''