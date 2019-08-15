-- juliano leonardo soares
-- Trabalho 2: Mais programação funcional em Haskell
-- Parte 2
import Data.Char

-- 1-Escreva uma função recursiva isBin :: String -> Bool para verificar se uma dada String representa um número binário, ou seja, contém apenas caracteres '0' ou '1'. As únicas funções pré-definidas autorizadas aqui são head e tail. Exemplos de uso de isBin:

-- > isBin "101010"
-- True
-- > isBin "1212"
-- False
-- > isBin ""
-- False
isBin :: String -> Bool
isBin "" = False
isBin str
        | tail str == "" && seforZeroUm = True
        | seforZeroUm = isBin (tail str)
        | otherwise = False
    where 
        seforZeroUm = head str == '0' || head str == '1'

-- 2-Reescreva a função acima de forma não-recursiva. Dê outro nome para ela, por exemplo isBin'. Aqui você pode usar quaisquer funções auxiliares pré-definidas em Haskell.
isBin' :: String -> Bool
isBin' str = all (\x -> x == '1' || x== '0') str

-- 3-Encontra-se abaixo a definição parcial da função bin2dec :: [Int] -> Int, que converte uma lista de 0's e 1's (representando um número binário), em seu equivalente em decimal.

bin2dec :: [Int] -> Int
bin2dec [] = undefined
bin2dec bits = auxBin2Dec bits ((length bits)-1)

-- para modelo 2
bin2dec1 :: [Int] -> Int
bin2dec1 [] = undefined
bin2dec1 bits = auxBin2Dec1 bits ((length bits)-1)
-- Observe que:
-- Usou-se undefined para o caso em que a função não tem resultado definido.
-- Usou-se uma função auxiliar (auxBin2Dec) que recebe, como segundo argumento, o expoente que deverá multiplicar o primeiro elemento da lista.
-- Implemente a função auxBin2Dec de forma recursiva, para que bin2dec funcione corretamente, conforme os exemplos abaixo:
-- > bin2dec [0]
-- 0
-- > bin2dec [1]
-- 1
-- > bin2dec [0,1]
-- 1
-- > bin2dec [1,0,1]
-- 5
----- modelo 1
auxBin2Dec :: [Int] -> Int -> Int
auxBin2Dec [] _ = 0
auxBin2Dec (x:xs) n = x*(2^n) + auxBin2Dec xs (n-1)
----- modelo 2
auxBin2Dec1 :: [Int] -> Int -> Int
auxBin2Dec1 [] _ = 0
auxBin2Dec1 x n = head x *(2^n) + auxBin2Dec1 (tail x) (n-1)

-- 4-Reescreva a função do exercício anterior de forma não-recursiva, usando funções pré-definidas em Haskell. Dê outro nome para a função (por exemplo, bin2dec').
bin2dec' :: [Int] -> Int
bin2dec' [] = undefined
bin2dec' bits = sum (zipWith (\x y -> x*(2^y)) bits [((length bits)-1),((length bits)-2)..0])

-- 5-Crie uma função recursiva dec2bin :: Int -> [Int] que receba um número inteiro positivo e retorne sua representação em binário, sob forma de uma lista de 0's e 1's. As funções auxiliares autorizadas aqui são mod, div e reverse. Exemplos de uso da função:

-- > dec2bin 0
-- [0]
-- > dec2bin 1
-- [1]
-- > dec2bin 11
-- [1,0,1,1]
-- > dec2bin 4
-- [1,0,0]
dec2bin :: Int -> [Int]
dec2bin 0 = []
dec2bin x 
          |mod x 2 == 1 = dec2bin (div x 2) ++ [1]
          |mod x 2 == 0 = dec2bin (div x 2) ++ [0]


-- 6-Implemente uma dessas funções: isHex :: String -> Bool ou hex2dec :: String -> Int ou dec2hex :: Int -> String, que são semelhantes às dos exercícios anteriores, porém com números hexadecimais no lugar de números binários. Aqui está tudo liberado: você pode escolher qual das funções irá implementar, sem restrições sobre como deve fazer isso.

hexInt :: Char -> Int
hexInt x
    | x == '0' = 0
    | x == '1' = 1
    | x == '2' = 2
    | x == '3' = 3
    | x == '4' = 4
    | x == '5' = 5
    | x == '6' = 6
    | x == '7' = 7
    | x == '8' = 8
    | x == '9' = 9
    | x == 'A' = 10
    | x == 'B' = 11
    | x == 'C' = 12
    | x == 'D' = 13
    | x == 'E' = 14
    | x == 'F' = 15
    | otherwise = 0

hex2dec :: String -> Int
hex2dec str 
    | length str /= 0 = (hexInt(last(str)))+(16*hex2dec(init(str)))
    | otherwise       = 0  
  
