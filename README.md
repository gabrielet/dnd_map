# exploration and combat map for rpg games
simple shiny app that allows uploading a map and a set of characters for combat situations in roleplay games like d&d, pathfinder, and more...

the characters table must look like this:

```
character,x_pos,y_pos,hidden
character_1,10,20,0
character_2,10,30,0
character_3,20,20,0
monster_1,50,40,0
```
`character` column is the character name

`x_pos` and `y_pos` represent character's initial position (x, y)

`hidden` column represents the status of the character. if they are hidden, i.e. they can't be seen, set it to 1. 0 otherwise.

the map can be loaded from a jpeg or jpg file. i suggest to use a file below 400kb to run the app smoothly. the heavier the image the more time to update after a character is moved.
