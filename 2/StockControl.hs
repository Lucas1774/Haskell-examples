module StockControl where

data Stock = ROOTNODE [Stock] | INNERNODE Char [Stock] | INFONODE Int
  deriving (Show,Read,Eq)

-------------------------
-- FUNCIÓN CREATESTOCK --
-------------------------

-- FUNCIÓN QUE DEVUELVE UN STOCK VACÍO --
createStock :: Stock
createStock = ROOTNODE[]


---------------------------
-- FUNCIÓN RETRIEVESTOCK --
---------------------------

-- FUNCIÓN QUE DEVUELVE EL NÚMERO DE UNIDADES DE UN PRODUCTO EN EL STOCK --
-- SI NO ESTÁ, DEBERÁ DEVOLVER -1                                        --

retrieveStock :: Stock -> String -> Int
retrieveStock (ROOTNODE []) _ = -1 --empty -> do not bother
retrieveStock (ROOTNODE children) string = retrieveStock' children string --not empty -> operate with children
  where
    retrieveStock' :: [Stock] -> String -> Int
    retrieveStock' (INFONODE n:[]) "" = n --found end -> get value
    retrieveStock' (INNERNODE c children:rest) (x:xs) --inner node -> check if match
      | c == x = retrieveStock' children xs --found match -> go deeper
      | c < x = retrieveStock' rest (x:xs) --explore level -> go wider
      | otherwise = -1 --not found
    retrieveStock' _ _ = -1 --default not found


-------------------------
-- FUNCIÓN UPDATESTOCK --
-------------------------

-- FUNCIÓN QUE MODIFICA EL VALOR ASOCIADO A UN PRODUCTO EN EL STOCK --
-- SÓLO PUEDE ALMACENAR NÚMEROS MAYORES O IGUALES A 0               --

updateStock :: Stock -> String -> Int -> Stock
updateStock (ROOTNODE children) string value = ROOTNODE (updateStock' children string value) --operate with children
  where
    updateStock' :: [Stock] -> String -> Int -> [Stock]
    updateStock' [] "" value = [INFONODE value] --found end -> create infonode
    updateStock' (INFONODE _ : rest) "" value = INFONODE value : rest --a different end -> update infonode, keep siblings-
    updateStock' [] (x:xs) value = [INNERNODE x (updateStock' [] xs value)] --dead end -> create innernode and go deeper
    updateStock' (INNERNODE c children : rest) (x:xs) value --inner node -> check if match
      | c == x = INNERNODE c (updateStock' children xs value) : rest --found match -> go deeper
      | c < x = INNERNODE c children : updateStock' rest (x:xs) value --explore level -> go wider
      | otherwise = INNERNODE x (updateStock' [] xs value) : INNERNODE c children : rest --not found -> create innernode and go deeper
    updateStock' (node : rest) string value = node : updateStock' rest string value --default not found


-----------------------
-- FUNCIÓN LISTSTOCK --
-----------------------

-- FUNCIÓN QUE DEVUELVE UNA LISTA PARES PRODUCTO-EXISTENCIA --
-- DEL CATÁLOGO QUE COMIENZAN POR LA CADENA PREFIJO p       --
listStock :: Stock -> String -> [(String, Int)]
listStock stock string = toTuples(bt isSolution children (get stock string, string))
  where
    toTuples nodes = concatMap toTuples' nodes
      where
        toTuples' (INFONODE i, s) = [(s, i)]

    isSolution (INFONODE _, _) = True --infonodes are solution because filtering is done beforehand
    isSolution _ = False

    children (ROOTNODE next, s) = [(child, s) | child <- next] --create tuples with string s
    children (INNERNODE c next, s) = [(child, s ++ [c]) | child <- next] -- create tuples with string s + c
    children _ = []

    get (ROOTNODE []) _ = ROOTNODE [] --empty -> return empty
    get (ROOTNODE children) string = ROOTNODE (get' children string) --not empty -> return new with children
      where
        get' :: [Stock] -> String -> [Stock]
        get' nodes "" = nodes --found end -> return children
        get' (INNERNODE char first:rest) (x:xs) --inner node -> check if match
          | char == x = get' first xs --found match -> go deeper
          | char < x = get' rest (x:xs) --explore level -> go wider
          | otherwise = [] --not found -> return empty
        get' _ _ = [] --default return empty


-- FUNCIÓN GENÉRICA DE BACKTRACKING --
bt :: (a -> Bool) -> (a -> [a]) -> a -> [a]
bt    eS             c             n
  | eS n      = [n]
  | otherwise = concat (map (bt eS c) (c n))

