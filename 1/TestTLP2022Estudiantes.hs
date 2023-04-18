module TestTLP2022Estudiantes where

import Data.Char
import System.IO
import SparseArray

type Test = (String,[String],[String],SparseArray String)

tfile :: String
tfile = "TestTLP2022Estudiantes.txt"

--- Ejecuta un test y devuelve la salida ---
exec :: [String] -> ([String],SparseArray String)
exec input = iExec input ([],newSparseArray)
  where iExec :: [String] -> ([String],SparseArray String) -> ([String],SparseArray String)
        iExec []     (output,sa) = (output,sa)
        iExec (x:xs) (output,sa) = case i of
                                   "SET"    -> iExec xs (output++["SET "++show(idx)++" "++elem]                  ,set sa idx elem) -- Instrucción SET
                                   "GET"    -> iExec xs (output++["GET "++show(idx)++": "++valueShow(get sa idx)],sa)              -- Instrucción GET
                                   "DELETE" -> iExec xs (output++["DELETE "++show(idx)]                          ,delete sa idx)   -- Instrucción DELETE
          where valueShow :: Show a => Value a -> String -- Muestra Null o el valor del SparseArray
                valueShow Null = "Null"
                valueShow (Value v) = show v
                i :: String                              -- Token con la instrucción
                i = map toUpper (tokens!!0)
                idx :: Int                               -- Índice donde ejecutar la instrucción
                idx = read(tokens!!1)::Int
                elem :: String                           -- Elemento a insertar
                elem = tokens!!2
                tokens :: [String]                       -- Divide la línea en tokens separados por espacios
                tokens = words x


--- CHECK A TEST ---
checkTest (id,input,output,final) = id ++
                                    " - Salida " ++ (if ( salida == output ) then "" else "in")++"correcta" ++
                                    " - Arbol final " ++ (if ( resultado == final ) then "" else "in")++"correcto\n"
  where (salida,resultado) = exec input


--- MAIN LOOP ---
loop :: [String] -> IO ()
loop []     = do { putStr "End of test file\n" }
loop (t:ts) = do { let test = (read t)::Test in do {
                     putStr (checkTest test);
                     loop ts;
                   }
                 }

--- FUNCTION MAIN ---
main :: IO ()
main = do { putStr ("Loading test file: " ++ tfile ++ "\n");  -- INDICAMOS QUE VAMOS A LEER EL FICHERO CON LOS TESTS
            hFlush stdout;                                    -- PROVOCA QUE LA SALIDA SE VUELQUE EN PANTALLA
            fcontent <- (readFile tfile);                     -- LEEMOS EL CONTENIDO DEL FICHERO
            let tests = (lines fcontent) in do {              -- CADA LÍNEA ES UN TEST
              loop tests;                                     -- EJECUTA EL BUCLE PRINCIPAL SOBRE LOS TESTS
            }
          }

