# d&d map
simple shiny app that allows uploading a map and a set of characters for combat situations in roleplay games like dungeons and dragons, pathfinder, and more...

the characters table must look like this:

character,x_pos,y_pos,hidden
character_1,10,20,0
character_2,10,30,0
character_3,20,20,0
monster_1,50,40,0

first column is the character name
second column and third column character's initial position
last column (hidden) represents the status of the character. if it's hidden, i.e. they can't be seen, set it to 1. 0 otherwise.

the map can be loaded from a jpeg or jpg file.
suggested to use a file below 400kb to be able to run the app smoothly. the heavier the image the more time to load and use it.
