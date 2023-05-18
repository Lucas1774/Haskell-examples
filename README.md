THIS WAS A COLLEGE PROJECT.

## Program

These are two Haskell data structure implementation programs (I know, right? Why?). I very vividly remember writing this file before, Git is doing that thing where you don't have linked remotes, but you can't properly create one either, because you used to have one... no idea where it went but:  
- The first one seems (I don't remember) to be implementing a binary tree of integers, where whether if a number is stored in one half of the tree or the other depends on some criteria that I don't dare to guess or can be bothered to figure out.
- The second one implements what I believe is called a "trie": a non-binary tree that represents a string and (not necessarily) an associated integer, where instead of these tuples being stored in nodes, the whole branch represents the string, and (not necessarily) there is a leaf at the button containing the integer.

I don't love Haskell. I'm sure it does some things ok. I just have huge trouble with the fact that, in its purest form, it is impossible to read, despite this being supposed to be one of its main strengths. I rather type something in Polish-reversed.

## Context and usage

The programs I wrote (`SparseArray.hs` and `StockControl.hs`) are wrapped in a bigger architecture, provided by my professors, that consists of `test.hs` and `test.txt` files, as well as one with a user interface. I didn't write this, but it's called Main for a reason.  
Install a Haskell interpreter, load the file and run `main`. I don't remember if I ever used the first one, but the second one is a nice program that, again, I did not write.
