module SparseArray where

data Value a = Null | Value a
  deriving (Eq,Read,Show)
data SparseArray a = Vacio | Nodo (Value a) (SparseArray a) (SparseArray a)
  deriving (Eq,Read,Show)

-- Función num2bin: recibe un Int y devuelve una lista con los dígitos de su representación en binario --
num2bin :: Int -> [Bool]
num2bin 0 = [False]
num2bin n = num2binAux n
  where num2binAux :: Int -> [Bool]
        num2binAux 0 = []
        num2binAux n = (num2binAux (div n 2))++[(mod n 2)==1]

-- Función newSparseArray: devuelve un SparseArray vacío --
newSparseArray :: Eq a => SparseArray a
newSparseArray =  Vacio

-- Función set: recibe un SparseArray, una posición y un elemento y cambia el valor del SparseArray de dicha posición --
set :: Eq a => SparseArray a -> Int -> a -> SparseArray a
setWithBooleans:: SparseArray a -> [Bool] -> a-> SparseArray a
setWithBooleans Vacio [] e = Nodo (Value e) Vacio Vacio
setWithBooleans (Nodo value izq der) [] e = Nodo (Value e) izq der
setWithBooleans Vacio (False:xs) e = Nodo Null (setWithBooleans Vacio xs e) Vacio
setWithBooleans Vacio (True:xs) e = Nodo Null Vacio  (setWithBooleans Vacio xs e)
setWithBooleans (Nodo value izq der) (False:xs) e = Nodo value (setWithBooleans izq xs e) der
setWithBooleans (Nodo value izq der) (True:xs) e = Nodo value izq (setWithBooleans der xs e) 
set tree spot e = setWithBooleans  tree (num2bin spot) e


-- Función get: recibe un SparseArray y una posición y devuelve el elemento del SparseArray en dicha posición --
get :: Eq a => SparseArray a -> Int -> (Value a)
getWithBooleans:: SparseArray a -> [Bool] -> (Value a)
getWithBooleans Vacio _ = Null
getWithBooleans (Nodo value izq der) [] = value
getWithBooleans (Nodo value izq der) (False:xs) = getWithBooleans izq xs
getWithBooleans (Nodo value izq der) (True:xs) = getWithBooleans der xs
get tree spot = getWithBooleans tree (num2bin spot)

-- Función delete: recibe un SparseArray y una posición y devuelve el SparseArray resultado de eliminar dicha posición --
--                 También elimina todos los nodos vacíos que resulten de la eliminación                               --
delete :: Eq a => SparseArray a -> Int -> SparseArray a
deleteWithBooleans:: SparseArray a -> [Bool] -> SparseArray a
podar:: SparseArray a -> SparseArray a
podar (Nodo Null Vacio Vacio) = Vacio
podar array = array
deleteWithBooleans Vacio _ = Vacio
deleteWithBooleans (Nodo value izq der) [] = podar (Nodo (Null) izq der)
deleteWithBooleans (Nodo value izq der) (False:xs) = podar (Nodo value (deleteWithBooleans izq xs) der)
deleteWithBooleans (Nodo value izq der) (True:xs) = podar (Nodo value izq (deleteWithBooleans der xs))
delete tree spot = deleteWithBooleans  tree (num2bin spot)