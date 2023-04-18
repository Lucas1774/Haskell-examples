module StockControl where

data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

createStock :: Stock
createStock = ROOTNODE[]

retrieveStock :: Stock -> String -> Int
retrieveStock (ROOTNODE []) _ = -1
retrieveStock (ROOTNODE children) string = faux children string
  where
    faux :: [Stock] -> String -> Int
    faux (INFONODE n:[]) "" = n
    faux (INNERNODE c children:rest) (x:xs)
      | c == x = faux children xs
      | otherwise = faux rest (x:xs)
    faux _ _ = -1

updateStock :: Stock -> String -> Int -> Stock
updateStock (ROOTNODE children) str val = ROOTNODE (faux children str val)
  where
    faux :: [Stock] -> String -> Int -> [Stock]
    faux [] "" val = [INFONODE val]
    faux [] (x:xs) val = [INNERNODE x (faux [] xs val)]
    faux (INFONODE _ : rest) "" val = INFONODE val : rest
    faux (INFONODE _ : rest) (x:xs) val = INFONODE val : faux rest (x:xs) val
    faux (INNERNODE c children : rest) (x:xs) val
      | c == x = INNERNODE c (faux children xs val) : rest
      | otherwise = INNERNODE c children : faux rest (x:xs) val
    faux (node : rest) str val = node : faux rest str val



-- in this function String is a prefix --
listStock :: Stock -> String -> [(String, Int)]
listStock s string = [("a",2)]
-- generic backtracking function --
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))

