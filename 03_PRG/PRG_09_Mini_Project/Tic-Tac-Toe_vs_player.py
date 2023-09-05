'''
Can't find any more bugs, think it works good now!
Worked on this for about 10 hours, way to much but I had a lot of fun!
At the bottom is the code commented out I created before adding functions or error handling.
There was no winner, and they would over write each other, game was infinite.

You can play it with input as following:
    Pick a row 1, 2 or 3
    Pick a column 1, 2 or 3
    Then type row & colum.
    Example: Top row in the middle is 12 (row1, column 2) 

1) We set some variables at the start and print the empty field before starting the game.

2) The main while loop runs till 9 moves (full field), or player_1/Player_2 win condition is changed to True:
    Add 1 to tries, so the loop can break after 9 moves

3) Via tries we determine who's turn it is, we use the % modulo to check if it's an uneven or even turn.
    "tries % 2 == 0" is Even, so I started chronological with "not tries % 2 == 0" as player_1 starts the game.

4) The current player loop.

    Ask the current player for input.
    If statement that checks if valid input == True.

    When valid input is False:
        I Check for 3 conditions, if they are all True, return True to break valid input loops
        If row is in range(0,2) as it is a 3 by 3 field.
        If column is in range(0,2) as it a 3 by 3 field.
        If position is empty " "
        Else return False, this will not continue the if statement and returns to the player loop

    When valid input condition is True:
        Add player input to the play_field, via coordinates (example: split input like 23 to x = 2, y = 3)
        Print the players input
        Print the new play_field
        Set the player to True of False, depending if they completed a win condition
            There are 3 win conditions, a row, a colum, a diagonal
        Break from the loop

5) When one of the main loop conditions is broken.
    Check if player 1 has won & congratulate player 1 if won.
    Check if player 2 has won & congratulate player 2 if won.
    Check if field is full (tries == 9), if so say there are no more moves left.
'''

row1 = [" ", " ", " "]
row2 = [" ", " ", " "]
row3 = [" ", " ", " "]
play_field = [row1,row2,row3]

player_1 = False
player_2 = False
tries = 0

# Printed the rows to visualize the playing field
print(f"{row1}\n{row2}\n{row2}")

def check_columns(row1, row2, row3):
    '''Check for columns win conditions'''
    for i in range(len(row1)):
        if "x" in row1[i] and "x" in row2[i] and "x" in row3[i]:
            player_1 = True
            # Check if it's a column win
            # print("Win check_columns")
            return player_1
        elif "o" in row1[i] and "o" in row2[i] and "o" in row3[i]:
            player_2 = True
            # Check if it's a column win
            # print("Win check_columns")
            return player_2
                
def check_rows(play_field):
    '''Check for rows win conditions'''
    # Check all rows in the play_field list
    for rows in play_field:
        # all() gives a True or False value
        # if correct x or o is set to True
        x = all(row == "x" for row in rows)
        o = all(row == "o" for row in rows)
        
        # Check if x or o is True
        if x == True:
            player_1 = True
            # Check if it's a row win
            # print("Win check_rows")
            return player_1
        elif o == True:
            player_2 = True
            # Check if it's a row win
            # print("Win check_rows")
            return player_2

def check_diagonals(row1, row2, row3):
    '''Check for diagonals win conditions'''
    # Check for diagonal top left to bottom right
    if "x" in row1[0] and "x" in row2[1] and "x" in row3[2]:
        player_1 = True
        # Check if its a diagonal win
        # print("Win check_diagonals")
        return player_1
    elif "o" in row1[0] and "o" in row2[1] and "o" in row3[2]:
        player_2 = True
        # Check if its a diagonal win
        # print("Win check_diagonals")
        return player_2
    # Check for diagonal top right to bottom left
    if "x" in row1[2] and "x" in row2[1] and "x" in row3[0]:
        player_1 = True
        # Check if its a diagonal win
        # print("Win check_diagonals")
        return player_1
    elif "o" in row1[2] and "o" in row2[1] and "o" in row3[0]:
        player_2 = True
        # Check if its a diagonal win
        # print("Win check_diagonals")
        return player_2

def isWinner(player_1, player_2, tries):
    '''Check for all possible win conditions'''
    # Check for column win condition
    player_1 = check_columns(row1, row2, row3)
    player_2 = check_columns(row1, row2, row3)
    if player_1 == True:
        return player_1
    elif player_2 == True:
        return player_2

    # Check for rows win condition
    player_1 = check_rows(play_field)
    player_2 = check_rows(play_field)
    if player_1 == True:
        return player_1
    elif player_2 == True:
        return player_2
    
    # Check for diagonals win condition
    player_1 = check_diagonals(row1, row2, row3)
    player_2 = check_diagonals(row1, row2, row3)
    if player_1 == check_diagonals(row1, row2, row3):
        return player_1
    elif player_2 == check_diagonals(row1, row2, row3):
        return player_2
    
    # When none of the win conditions are met, return False to current player
    if not tries % 2 == 0:
        player_1 = False
        return player_1
    else:
        player_2 = False
        return player_2

def new_position(position):
        '''This function return x and y coordinates'''
        coordinates = list(position) 
        x = int(coordinates[0]) -1
        y = int(coordinates[1]) -1
        return x, y

def valid_input(position, play_field):
        '''This function checks if the input is valid'''
        x, y = new_position(position)

        # Check if x coordinates are out of range 
        if x >= 0 and x < 3: 
            # Check if y coordinates are out of range 
            if y >= 0 and y < 3:
                # Check if field is " "
                if play_field[x][y] == " ":
                    return True
        
        print("This is not a valid position")
        return False


# Play field is 3x3 = 9, so we can have max 9 tries combined.
while tries < 9 and not (player_1 or player_2):
    tries += 1 
    
    if not tries % 2 == 0:
        # Turn for player 1
        while True:
            position = input(f"Player 1, where to place 'x'? ")
            if valid_input(position, play_field):
                x_coordinate, y_coordinate = new_position(position) 
                play_field[x_coordinate][y_coordinate] = "x"
                print(f"Player 1 placed 'x' at [{x_coordinate + 1},{y_coordinate + 1}]")
                print(f"{row1}\n{row2}\n{row3}")
                player_1 = isWinner(player_1, player_2, tries)
                break

    else:
        # Turn for player 2
        while True:
            position = input(f"Player 2, where to place 'o'? ")
            if valid_input(position, play_field):
                x_coordinate, y_coordinate = new_position(position) 
                play_field[x_coordinate][y_coordinate] = "o"
                print(f"Player 2 placed 'x' at [{x_coordinate + 1},{y_coordinate + 1}]")
                print(f"{row1}\n{row2}\n{row3}")
                player_2 = isWinner(player_1, player_2, tries)
                break

if player_1 == True:
    print("Player 1 wins the game!")
elif player_2 == True:
    print("Player 2 wins the game!") 
elif tries == 9:
    print("Game over, no more placement's left")
        

# Turn for player loop before error handling or functions
# while True:
#     position = input("Player 1, where to place 'o'? ").upper()
#     coordinates = list(position) 
#     x_coordinate = int(coordinates[0]) -1
#     y_coordinate = int(coordinates[1]) -1
#     play_field[x_coordinate][y_coordinate] = "o"
#     print(f"Player 1 placed 'o' at {coordinates}")
#     print(f"{row1}\n{row2}\n{row3}")
#     break

