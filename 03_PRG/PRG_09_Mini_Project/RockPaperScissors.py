'''
Made this code with 100 days of Python but reduced the win condition statement from 7 to 4. 

You must in put a number 0, 1 , 2.
Then the computer picks a random number 0, 1, 2.
With an if/else statement I determine the winner.

Added a function to continue the game or leave.

'''
import random

rock = '''
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)
'''

paper = '''
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)
'''

scissors = '''
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)
'''

game = [rock, paper, scissors]
hand = ["Rock", "Paper", "Scissors"]

# function to check if user wants to play the game again.
# return True/False or loop back to the function start.
def continue_game():
    user_input = input("Do you want to play an other game? y/n ").lower()

    if user_input == "n":
        return False
    elif user_input == "y":
        return True
    else:
        print("Please enter a valid input")
        continue_game()
    

def the_game():
    while True:
        user_input = int(input("What do you choose? Type 0 for Rock, 1 for Paper or 2 for Scissors. \n"))

        if user_input >= 3 or user_input < 0:
            print("You typed an invalid number")
            the_game()
        else:
            print(f"\nYou choose {hand[user_input]}\n{game[user_input]}")

            computer_input = random.randint(0, 2)
            print(f"\nThe computer used {hand[computer_input]}\n{game[computer_input]}")

            if user_input == computer_input:
                print(f"Both used {hand[user_input]}")
                print("It's a draw")
            elif user_input == 0 and computer_input == 2:
                print(f"{hand[user_input]} beats {hand[computer_input]}")
                print("You win")
            elif user_input == 2 and computer_input == 1:
                print(f"{hand[user_input]} beats {hand[computer_input]}")
                print("You win")
            else:
                print(f"{hand[computer_input]} beats {hand[user_input]}")
                print("You lose")
        
        # Check if user want's to continue the game
        if continue_game() == False:
            break

the_game()

# This was the statement I used for 100 days of Code, reduced the code a fair bit and it still works
# if user_input == 0 and computer_input == 1:
#     print(f"{hand[computer_input]} beats {hand[user_input]}")
#     print("You lose")
# elif user_input == 0 and computer_input == 2:
#     print(f"{hand[user_input]} beats {hand[computer_input]}")
#     print("You win")
# elif user_input == 1 and computer_input == 0:
#     print(f"{hand[user_input]} beats {hand[computer_input]}")
#     print("You win")
# elif user_input == 1 and computer_input == 2:
#     print(f"{hand[computer_input]} beats {hand[user_input]}")
#     print("You lose")
# elif user_input == 2 and computer_input == 0:
#     print(f"{hand[computer_input]} beats {hand[user_input]}")
#     print("You lose")
# elif user_input == 2 and computer_input == 1:
#     print(f"{hand[user_input]} beats {hand[computer_input]}")
#     print("You win")
# else:
#     print(f"Both used {hand[user_input]}")
#     print("It's a draw")
