# spanzuratoarea_optimised
I created a simple hangman game where you have 2 options:
  1.You can start a new game
  2.You can play a previously saved game with the saved game's data

1. A random word with the length between 5 and 12 is generated from a list. We also generate a new array of lines that has the same length as the word but the lines are separated. example: word:rainy  array_of_lines: _ _ _ _ _
Each time we get a letter right from the word 'rainy' we complete the line array with the letter in the correct position. Lets say we guess the letter 'i' , the lines array would be: _ _ i _ _ . You get the logic. You also get the option to save the current progress in a file and play it later

2. Loaded games work this way: once you saved a game, the game's data is serialized and dumped into a file. WHen you want to play that particular game again,the game is deserialized and loaded and you can get back at it from where you was when you saved the progress.


I HOPE YOU LIKE IT. If you see this and see a mistake or you wanna give me a sugestion,feel free to do so. Thank youuu <3
