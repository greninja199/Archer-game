# Archer-game
This game is a type of archery game. In this game there is an invisible archer which holds up a bow, that can turn 35 degrees on both direction(up or down). This bow fires up an arrow at a time. Score is calculated on the basis of the box striked by the arrow. 

#Score Distribution
Box Touched by arrow : POINTS gained
                   1 : 10
                   2 : 20
                   3 : 30
                   4 : 40
                   5 : 50
                   6 : 40
                   7 : 30
                   8 : 20
                   9 : 10

# Language and Software Used to develop
I used 'LUA' language for coding the game. Love2d is the software in which the code is run. 
It provides the environment to run the code. 

# How to play

Press 'W' to increase the angle with the horizontal direction.
Press 'S' to decrease the angle with the horizontal direction.
Press 'A' to Increase the draw length.
Press 'D' to Decrease the draw length.
Press 'L' to Launch the arrow.
Press 'Enter' to reset the arrow to initial position.

# Installation required to play

You must have Lua language installed in the syatem.
To run the code you should have 'LOVE2D' installed. 
To play the game you should drag the .lua file present in the directory to Love2d software.

# Gameplay

Gameplay has 3 parts:
1) When the arrow is in the bow, you can use A/D to increase/decrease draw length, you can use W/S to increase/decrease the angle owith the horizontal.
2) When you press 'L' the arrow is launched and it follows a projectile path and hits according to angle and draw length.
3) When the arrow has travelled its path. Now, the score is increased according to Box hit by the arrows tip.

# Projectile Motion 

This game is setup in an alternate space which follows the rules of physics as our planet but has some different value of constants there.
Accelaration due to gravity(ACCEL_Y) = 2p/s^2.
Spring Constant of the string in the bow(K)= 2.025(p)(kg)/s^3. 
Here, p -> pixels.
Spring constant is used to calculate Velocity multiplier (VELOCITY_MUL) which is equal to square root(2*K/m).
 m=0.018kg, taken an average mass of arrow

