-- juliano leonardo soares
-- Trabalho 2: Mais programação funcional em Haskell
-- Parte 4
-----------------------------------------------------------------------------------
import Data.Char

-- Converte um caracter em um inteiro
encodeChar :: Char -> Int
encodeChar c = ord c - ord 'a'

-- Converte um inteiro em um caracter
decodeChar :: Int -> Char
decodeChar n = chr (ord 'a' + n)

-- Calcula percentagem: n/m*100
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m)*100

-- Rotacao de uma lista para esquerda em n posicoes
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

-- Tabela de frequencias das letras 'a'..'z' (lingua portuguesa)
-- https://pt.wikipedia.org/wiki/Frequ%C3%AAncia_de_letras
table :: [Float]
table = [14.6, 1.0, 3.9, 5.0, 12.6, 1.0, 1.3, 1.3, 6.2, 0.4, 0.1, 2.8, 4.7, 
         5.0, 10.7, 2.5, 1.2, 6.5, 7.8, 4.3, 4.6, 1.7, 0.1, 0.2, 0.1, 0.5]

-- Distancia entre 2 listas de frequencia
chi2 :: [Float] -> [Float] -> Float
chi2 os es = sum [((o-e)^2)/e | (o,e) <- zip os es]

-- Use esta funcao para decodificar uma mensagem!
crack :: String -> String
crack cs = encodeStr cs (-factor)
           where factor = head (positions (minimum chitab) chitab)
                 chitab = [ chi2 (rotate n table' ) table | n <- [0..25] ]
                 table' = freqs cs
                 
-- ############################################################################# --
------------------------------------ PARTE 4 --------------------------------------
-- 1-Usando encodeChar e decodeChar, defina uma função shiftChar :: Char -> Int -> Char. Essa função, ao receber um caracter de 'a' a 'z', aplicará um deslocamento de 'n' unidades sobre ele, produzindo outro caracter no intervalo ['a'..'z']. Por exemplo:

-- > shiftChar 'a' 3
-- 'd'
shiftChar :: Char -> Int -> Char
shiftChar x n
            | isLower x = decodeChar (mod (encodeChar x + n) 26)
            | otherwise = x
            
-----------------------------------------------------------------------------------
-- Note, pelos exemplos acima, que caracteres fora do intervalo não devem sofrer deslocamento. Além disso, o deslocamento deve ser aplicado de forma circular sobre o intervalo.
-- 2-Usando shiftChar, defina uma função encodeStr :: String -> Int -> String que codifique uma string usando um dado deslocamento. Por exemplo:
-- > encodeStr "abracadabra" 3
-- "deudfdgdeud"
-- > encodeStr "paradigmas de programacao" 3
-- "sdudgljpdv gh surjudpdfdr"
encodeStr :: String -> Int -> String
encodeStr str n = map (\x -> shiftChar x n) str

-----------------------------------------------------------------------------------
-- 3-Defina uma função countValids :: String -> Int, que receba uma string e retorne a quantidade de seus caracteres contidos no intervalo ['a'..'z']. Exemplo:
--  > countValids "paradigmas de programacao"
-- 23
countValids :: String -> Int
countValids str = length (filter isLower str)

-----------------------------------------------------------------------------------
-- 4-Defina uma função countChar :: Char -> String -> Int, que retorne a quantidade de um dado caracter em uma string. Exemplo:

-- > countChar 'a' "paradigmas de programacao"
-- 6
countChar :: Char -> String -> Int
countChar l str = length (filter (\x -> x == l) str)

-----------------------------------------------------------------------------------
-- 5-Usando countValids, countChar e percent, defina uma função freqs :: String -> [Float] que retorne as frequências dos caracteres ['a'..'z'] numa dada string. Use list comprehension. A frequência de um caracter é dada pelo percentual deste caracter entre os caracteres válidos da string. Por exemplo:
-- > freqs "abc" 
-- [33.333336,33.333336,33.333336,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
freqs :: String -> [Float]
freqs str = map (\x -> percent (countChar x str) (countValids str)) ['a'..'z']

-----------------------------------------------------------------------------------
-- 6-Defina uma função positions :: Float -> [Float] -> [Int], que retorne uma lista de posições de um dado número em uma lista. Considere que as posições comecem em zero. Use a função zip como auxiliar no seu código. Exemplos de uso da função:
-- > positions 1.5 [0,7.5,8,1.5]
-- [3]
positions :: Float -> [Float] -> [Int]
positions float lista = map snd (filter (\x -> fst x == float) (zip lista [0..]))
