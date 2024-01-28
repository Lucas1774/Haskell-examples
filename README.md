THIS WAS A COLLEGE PROJECT.

## Program

These are two Haskell data structure implementation programs, which is a weird thing to do in Haskell, but it works. 
- The first one seems to be implementing a binary tree of integers, where whether if a number is stored in one half of the tree or the other depends on some criteria.
- The second one implements what I believe is called a "trie": a non-binary tree that represents a string (and here an associated integer sometimes also), where instead of these tuples being stored in nodes, the whole branch represents the string, and (sometimes) there is a leaf at the button containing the integer.

I don't love Haskell. I'm sure it does some things ok. I have trouble reading functional programming, besides, most modern programming languages already implement this feature.

## Context and usage

The programs I wrote (`SparseArray.hs` and `StockControl.hs`) are wrapped in a bigger architecture, provided by my professors, that consists of `test.hs` and `test.txt` files, as well as one that provides a user interface. I didn't write this, but it's called Main for a reason.  
Install a Haskell interpreter, load the file and run `main`. I don't remember if I ever used the first one, but the second one is a nice program.
