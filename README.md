## CS396 Assignment2 ##

### Problem 1 ###
Write a function to circulate a list. The function takes two parameters, the first defines how many elements of the list to circulate, and the second is the list. The output should be the circulated list. For example: 

    (circulate 3 â(1 -5 2 4 3 7 9))
    (3 7 9 1 -5 2 4) 
 
### Problem 2 ###
Write a function to obtain the solution of equations of the form ax2 + bx + c = 0. The equation is represented in a list as (a b c). The output should be a list of the two solutions for the equations. For example: 

    % 2 solutions 
    (solution â(1 -5 4)) 
    (1 4) 
    % only one solution 
    (solution â(1 4 4)) 
    (-2) 
    % no solutions 
    (solution â(1 -1 4)) 
    (none) 

### Problem 3 ###

Write a Scheme program that allows two players to play a game of Tic-Tac-Toe.
