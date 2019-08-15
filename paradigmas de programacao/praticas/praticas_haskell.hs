import Data.Char
---------------------------------------------------------
-- Eleva um numero ao quadrado (aqui temos um comentario!)
doubleMe :: Int -> Int
doubleMe x = x^2
---------------------------------------------------------
-- Verifica se um numero eh par (usa if/then/else para expressar funcao condicional)
-- mod: retorna resto da divisao inteira
isEven :: Int -> Bool
isEven n = if mod n 2 == 0 then True else False
-- Ou simplesmente:
-- isEven n = mod n 2 == 0
---------------------------------------------------------
-- Gera um numero a partir de um caracter (usa outra estrutura condicional em Haskell: guardas)
encodeMe :: Char -> Int
encodeMe c
  | c == 'S'  = 0
  | c == 'N'  = 1
  | otherwise = 2
---------------------------------------------------------
-- Calcula o quadrado do primeiro elemento da lista
-- Note que '[Int]' designa uma lista de elementos do tipo Int
doubleFirst :: [Int] -> Int
doubleFirst lis = (head lis)^2
---------------------------------------------------------
-- Verifica se uma palavra tem mais de 2 caracteres
isLong :: String -> Bool -- isso é o mesmo que: isLong :: [Char] -> Bool
isLong s = length s > 2
---------------------------------------------------------
-- Crie uma função somaQuad :: Int -> Int -> Int que calcule a soma dos quadrados de dois números x e y.
somaQuad :: Int -> Int -> Int
somaQuad a b = a^2 + b^2
-- modo 2
somaQuad' :: Int -> Int -> Int
somaQuad' x y = (doubleMe x) + (doubleMe y)
---------------------------------------------------------
-- Crie uma função hasEqHeads :: [Int] -> [Int] -> Bool que verifique se 2 listas possuem o mesmo primeiro elemento. Use a função head e o operador lógico == para verificar igualdade.
hasEqHeads :: [Int] -> [Int] -> Bool
hasEqHeads a b = head a == head b
-- modo 2 para lista de numeros
hasEqHeads' :: [Int] -> [Int] -> Bool
hasEqHeads' x y = (head x) == (head y)
---------------------------------------------------------
-- Escreva uma função que receba uma lista de nomes e adicione a string "Super " no início de cada nome. Use o operador ++ para concatenar strings (ou qualquer lista).
addSuper :: String -> String
addSuper str = "super" ++ str
concSuper :: [String] -> [String]
concSuper x = map(addSuper)x
-- modo 2
concatSuper' :: [String] -> [String]
concatSuper' x = map (\y -> "Super" ++ y) x
---------------------------------------------------------
-- Crie uma função que receba uma string e retorne o número de espaços nela contidos. Dica: aplique 2 funções consecutivamente.
contaEspacos :: String -> Int
contaEspacos x = length (filter (\y -> y == ' ') x)
---------------------------------------------------------
-- Escreva uma função que, dada uma lista de números, calcule 3*n^2 + 2/n + 1 para cada número n da lista. Dica: defina uma função anônima.
applyExpression :: [Double] -> [Double]
applyExpression x = map (\n -> 3 * n ^ 2 + 2 / n + 1) x
---------------------------------------------------------
-- Escreva uma função que, dada uma lista de números, selecione somente os que forem negativos.
somenteNegativos :: [Int] -> [Int]
somenteNegativos x = filter (\y -> y < 0) x
---------------------------------------------------------
-- Escreva uma função que receba uma lista de números e retorne somente os que estiverem entre 1 e 100, inclusive. Dica 1: use uma função anônima. Dica 2: use o operador && para expressar um 'E' lógico.
entre1e100 :: [Int] -> [Int]
entre1e100 list = filter (\y -> y > 0 && y <= 100) list
---------------------------------------------------------
-- Escreva uma função que, dada uma lista de idades de pessoas no ano atual, retorne uma lista somente com as idades de quem nasceu depois de 1980. Para testar a condição, sua função deverá subtrair a idade do ano atual.
idades :: [Int] -> [Int]
idades x = filter (\y -> 2018 - y > 1980) x
---------------------------------------------------------
-- Escreva uma função que receba uma lista de números e retorne somente aqueles que forem pares.
somentePares :: [Int] -> [Int]
somentePares x = filter isEven x
---------------------------------------------------------
-- Crie uma função charFound :: Char -> String -> Bool que verifique se o caracter (primeiro argumento) está contido na string (segundo argumento). Exemplos de uso da função:
-- > charFound 'a' ""  
-- False  
-- > charFound 'a' "uau"  
-- True  
charFound :: Char -> String -> Bool
charFound x y = length (filter (\z -> z == x) y) > 0
---------------------------------------------------------
-- Crie uma função que receba uma lista de nomes e retorne outra lista com somente aqueles nomes que terminarem com a letra 'a'. Dica: conheça o list monster :-)
namesThatEndWithA :: [String] -> [String]
namesThatEndWithA x = filter (\y -> (last y) == 'a') x
---------------------------------------------------------
-- A função takeWhile :: (a -> Bool) -> [a] -> [a] é uma função de alta ordem. Ela recebe uma função condicional e uma lista, retornando o "menor prefixo" (isto é, porção inicial) da lista que satisfaça a condição dada. Teste os exemplos abaixo no GHCi e depois crie um novo exemplo:
-- > takeWhile (< 5) [1,2,3,4,5]
-- > takeWhile (/=' ') "Fulana de Tal"
takeWhile :: (a -> Bool) -> [a] -> [a]
---------------------------------------------------------
-- Crie uma função isVowel :: Char -> Bool que verifique se um caracter é uma vogal ou não.
-- modelo 1
isVowel :: Char -> Bool
isVowel digito = length(filter (\x -> x == digito) "aAeEiIoOuU") > 0
-- modelo 2
isVowel_1 :: Char -> Bool
isVowel_1 dig = dig == 'a' || dig == 'e' || dig == 'i' || dig == 'o' || dig == 'u' || dig == 'A' || dig == 'E' || dig == 'I' || dig == 'O' || dig == 'U' 
-- modelo 3
isVowel_2 :: Char -> Bool
isVowel_2 dig = elem dig "aAeEiIoOuU"
-- modelo 4
isVowel_3 :: Char -> Bool
isVowel_3 c = elem (toLower(c)) "aeiou"
---------------------------------------------------------
-- Escreva uma função addComma, que adicione uma vírgula no final de cada string contida numa lista.
-- modelo 1
addComma :: [String] -> [String]
addComma lista_str = map (\x -> x ++ ",") lista_str

-- modelo 2
func_auxiliar_addComma :: String -> String
func_auxiliar_addComma x = x ++ ","
addComma_2 :: [String] -> [String]
addComma_2 x = map func_auxiliar_addComma x
---------------------------------------------------------
-- Crie uma função htmlListItems :: [String] -> [String], que receba uma lista de strings e retorne outra lista contendo as strings formatadas como itens de lista em HTML. Resolva este exercício COM e SEM funções anônimas (lambda). Exemplo de uso da função:
-- > htmlListItems ["abra", "ca", "dabra"]
-- ["<LI>abra</LI>", "<LI>ca</LI>", "<LI>dabra</LI>"]
-- sem LAMBDA
html_Aux :: String -> String
html_Aux string = "<LI>" ++ string ++ "</LI>"
htmlListItems_2 :: [String] -> [String]
htmlListItems_2 lista = map html_Aux lista
-- com LAMBDA
htmlListItems :: [String] -> [String]
htmlListItems lista = map (\x -> "<LI>" ++ x ++ "</LI>") lista
---------------------------------------------------------
-- Defina uma função que receba uma string e produza outra retirando as vogais, conforme os exemplos abaixo. Resolva este exercício COM e SEM funções anônimas (lambda).
-- > semVogais "andrea"
-- "ndr"
-- > semVogais "xyz"
-- "xyz"
-- > semVogais "ae"
-- ""
-- sem LAMBDA  
semVogais :: String -> String 
semVogais string = filter (not.isVowel) string
-- com LAMBDA
semVogais_1 :: String -> String
semVogais_1 s = filter (\x -> not (x `elem` "aeiouAEIOU")) s
---------------------------------------------------------
-- Defina uma função que receba uma string, possivelmente contendo espaços, e que retorne outra string substituindo os demais caracteres por '-', mas mantendo os espaços. Resolva este exercício COM e SEM funções anônimas (lambda). Exemplos:
-- > codifica "Rio Grande do Sul"
-- "--- ------ -- ---"
-- > codifica ""
-- ""
-- sem LAMBDA
troca_carac :: Char -> Char
troca_carac carac = if (carac /= ' ') then '-' else ' '

codifica :: String -> String 
codifica string = map (troca_carac) string

-- com LAMBDA
codifica_1 :: String -> String 
codifica_1 string = map (\x -> if x /= ' ' then '-' else ' ') string
---------------------------------------------------------
-- Escreva uma função firstName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu primeiro nome. Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome. Dica: estude funções pré-definidas em Haskell (List operations -> Sublists) em http://hackage.haskell.org/package/base-4.10.1.0/docs/Prelude.html#g:18. Exemplos de uso da função:
-- > firstName "Anderson Silva"
-- "Anderson"
-- > firstName "JON BON JOVI"
-- "JON"
-- modelo 1
firstName :: String -> String
firstName string = takeWhile(/= ' ') string

-- modelo 2
firstName_1 :: String -> String
firstName_1 string = head(words string)
---------------------------------------------------------
-- Escreva uma função isInt :: String -> Bool que verifique se uma dada string só contém dígitos de 0 a 9. Exemplos:
-- > isInt "901"
-- True
-- > isInt "2014a"
-- False
-- modelo 1
isInt :: String -> Bool
isInt [] = True
isInt (x:xs) = if isDigit x then isInt xs else False

-- modelo 2
isInt_2 :: String -> Bool
isInt_2 string = all isDigit string
---------------------------------------------------------
-- Escreva uma função lastName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu último sobrenome. Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome. Exemplos de uso da função:
-- > lastName "Anderson Silva"
-- "Silva"
-- > lastName "JON BON JOVI"
-- "JOVI"
lastName :: String -> String
lastName string = last (words string)
---------------------------------------------------------
-- Escreva uma função userName :: String -> String que, dado o nome completo de uma pessoa, crie um nome de usuário (login) da pessoa, formado por: primeira letra do nome seguida do sobrenome, tudo em minúsculas. Dica: estude as funções pré-definidas no módulo Data.Char, para manipulação de maiúsculas e minúsculas. Você precisará carregar este módulo usando import Data.Char no interpretador ou no início do arquivo do programa.
-- Exemplos de uso da função:
-- > userName "Anderson Silva"
-- "asilva"
-- > userName "JON BON JOVI"
-- "jjovi"
userName :: String -> String
userName string = map toLower ([head string] ++ lastName string)
---------------------------------------------------------
-- Escreva uma função encodeName :: String -> String que substitua vogais em uma string, conforme o esquema a seguir: a = 4, e = 3, i = 2, o = 1, u = 0.Exemplos de uso da função:
-- > encodeName "Anderson Silva"
-- "4nd3rs1n s2lv4"
-- > encodeName "Badtz Maru"
-- "B4dtz M4r0"
encodeName :: String -> String
encodeName string = map substituiVogal string

substituiVogal :: Char -> Char
substituiVogal char | (char == 'a') || (char == 'A') = '4' | (char == 'e') || (char == 'E') = '3'  | (char == 'i') || (char == 'I') = '2' | (char == 'o') || (char == 'O') = '1' | (char == 'u') || (char == 'U') = '0' | otherwise = char

---------------------------------------------------------
-- Escreva uma função betterEncodeName :: String -> String que substitua vogais em uma string, conforme este esquema: a = 4, e = 3, i = 1, o = 0, u = 00. Exemplos de uso da função:
-- > betterEncodeName "Anderson Silva"
-- "4nd3rs0n s1lv4"
-- > betterEncodeName "Badtz Maru"
-- "B4dtz M4r00"
betterEncodeName :: String -> String
betterEncodeName s = concatMap substituiVogal2 s

substituiVogal2 :: Char -> String
substituiVogal2 c | (c == 'a') || (c == 'A') = "4" | (c == 'e') || (c == 'E') = "3" | (c == 'i') || (c == 'I') = "1" | (c == 'o') || (c == 'O') = "0" | (c == 'u') || (c == 'U') = "00" | otherwise = [c]
---------------------------------------------------------
-- Dada uma lista de strings, produzir outra lista com strings de 10 caracteres, usando o seguinte esquema: strings de entrada com mais de 10 caracteres são truncadas, strings com até 10 caracteres são completadas com '.' até ficarem com 10 caracteres. Exemplo:
-- > func ["palavras","paralelas","pedal","paralelepipedo"]
-- ["palavras..","paralelas.","pedal.....","paralelepi"]
func :: [String] -> [String]
func s = map (\x -> if length x < 10 then x ++ replicate (10-length x) '.' else take 10 x) s
---------------------------------------------------------
-- Escreva uma função addSuffix :: String -> [String] -> [String] usando list comprehension, para adicionar um dado sufixo às strings contidas numa lista. Exemplo:
-- > addSuffix "@inf.ufsm.br" ["fulano","beltrano"]
-- ["fulano@inf.ufsm.br","beltrano@inf.ufsm.br]
addSuffix :: String -> [String] -> [String]
addSuffix sufixo lista = map(\k -> k ++ sufixo ) lista
---------------------------------------------------------
-- Escreva uma função countShorts :: [String] -> Int, que receba uma lista de palavras e retorne a quantidade de palavras dessa lista que possuem menos de 5 caracteres. Use list comprehension.
countShorts :: [String] -> Int
countShorts lista = length(filter (\y -> length (y) < 5) lista)
---------------------------------------------------------
-- Qual será o resultado de cada expressão abaixo?
-- a) [ (x,y) | x <- [1..5], even x, y <- [(x + 1)..6], odd y ]
-- b) [ a ++ b | a <- ["lazy","big"], b <- ["frog", "dog"]]
-- c) concat [ [a,'-'] | a <- "paralelepipedo", not (elem a "aeiou")]
funcA :: Int -> Int -> [(Int,Int)]
funcA x y = [ (x,y) | x <- [1..5], even x, y <- [(x + 1)..6], odd y ]

funcB :: String -> String -> [String]
funcB a b = [ a ++ b | a <- ["lazy","big"], b <- ["frog", "dog"]]

funcC :: String-> String
funcC a = concat [ [a,'-'] | a <- "paralelepipedo", not (elem a "aeiou")]
---------------------------------------------------------
-- Nesta questão você também deverá usar list comprehension. Suponha que um retângulo seja representado por uma tupla (Float,Float,Float,Float), contendo respectivamente as coordenadas x e y do ponto no seu canto superior esquerdo, seguidas das suas medidas de largura e altura. Sabendo que o eixo x cresce de cima para baixo e o eixo y da esquerda para direita, crie uma função genRects :: Int -> (Int,Int) -> [(Float,Float,Float,Float)] que receba um número N e um ponto (x,y) e gere uma sequência de N retângulos não sobrepostos. Os retângulos devem ser alinhados pelos seus topos, a partir do ponto dado, com largura e altura constantes. Por exemplo, usando largura e altura iguais a 5.5:
-- n> genRects 3 (0,0) 
-- [(0.0,0.0,5.5,5.5),(5.5,0.0,5.5,5.5),(11.0,0.0,5.5,5.5)]
-- Obs.: Use conversão explícita de tipos quando misturar Int e Float.
-- enRects :: Int -> (Int,Int) -> [(Float,Float,Float,Float)]

---------------------------------------------------------
-- Usando recursão, escreva uma função geraTabela :: Int -> [(Int,Int)] que produza uma lista com n tuplas, cada tupla com números de n a 1 e seus respectivos quadrados. Exemplo:
-- > geraTabela 5
-- [(5,25),(4,16),(3,9),(2,4),(1,1)]
-- > geraTabela 0
--- []
geraTabela :: Int -> [(Int,Int)]
geraTabela 0 = []
geraTabela x = (x,x*x) :geraTabela (x-1)
---------------------------------------------------------
-- Defina uma função recursiva que verifique se um dado caracter está contido numa string, conforme os exemplos abaixo:
-- > contido 'e' "andrea"
-- True
-- > contido 'x' "andrea"
-- False
-- > contido 'a' ""
-- False
contido :: Char -> String -> Bool
contido _ [] = False
contido x (y:ys) | x == y    = True
                 | otherwise = contido x ys
---------------------------------------------------------                 
--- Defina uma função recursiva que receba uma lista de coordenadas de pontos 2D e desloque esses pontos em 2 unidades, conforme o exemplo abaixo:
-- > translate [(0.1,0.2),(1.1,6.0),(2.0,3.1)]
-- [(2.1,2.2),(2.1,8.0),(4.0,5.1)]
translate :: [(Float, Float)] -> [(Float, Float)]
translate [] = []
translate ((x,y):xs) = (x + 2, y + 2) : translate xs
---------------------------------------------------------
-- Defina uma função que receba um número n e retorne uma lista de n tuplas, cada tupla com números de 1 a n e seus respectivos quadrados. Dica: defina uma função auxiliar recursiva com 2 argumentos, sendo um deles que se mantém inalterado na chamada recursiva. Exemplo:
-- > geraTabela' 5
-- [(1,1),(2,4),(3,9),(4,16),(5,25)]
geraTabela' :: Int -> [(Int,Int)]
geraTabela' 0 = [(0, 0)]
geraTabela' n = aux 1 n

aux :: Int -> Int -> [(Int, Int)]
aux h n = if(h  <= n)
   then (h, h^2) : aux(h + 1) n
   else []
---------------------------------------------------------   
-- Escreva uma função recursiva isBin :: String -> Bool para verificar se uma dada String representa um número binário, ou seja, contém apenas caracteres '0' ou '1'. As únicas funções pré-definidas autorizadas aqui são head e tail. Exemplos de uso de isBin:
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
---------------------------------------------------------        
-- Reescreva a função acima de forma não-recursiva. Dê outro nome para ela, por exemplo isBin'. Aqui você pode usar quaisquer funções auxiliares pré-definidas em Haskell.
isBin' :: String -> Bool
isBin' str = all (\x -> x == '1' || x== '0') str
---------------------------------------------------------
-- Encontra-se abaixo a definição parcial da função bin2dec :: [Int] -> Int, que converte uma lista de 0's e 1's (representando um número binário), em seu equivalente em decimal.
-- bin2dec :: [Int] -> Int
-- bin2dec [] = undefined
-- bin2dec bits = auxBin2Dec bits ((length bits)-1)
bin2dec :: [Int] -> Int
bin2dec [] = undefined
bin2dec bits = auxBin2Dec bits ((length bits)-1)

-- para modelo 2
bin2dec1 :: [Int] -> Int
bin2dec1 [] = undefined
bin2dec1 bits = auxBin2Dec1 bits ((length bits)-1)
---------------------------------------------------------
--- Observe que:
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
--5
----- modelo 1
auxBin2Dec :: [Int] -> Int -> Int
auxBin2Dec [] _ = 0
auxBin2Dec (x:xs) n = x*(2^n) + auxBin2Dec xs (n-1)
----- modelo 2
auxBin2Dec1 :: [Int] -> Int -> Int
auxBin2Dec1 [] _ = 0
auxBin2Dec1 x n = head x *(2^n) + auxBin2Dec1 (tail x) (n-1)
---------------------------------------------------------
-- Reescreva a função do exercício anterior de forma não-recursiva, usando funções pré-definidas em Haskell. Dê outro nome para a função (por exemplo, bin2dec').
bin2dec' :: [Int] -> Int
bin2dec' [] = undefined
bin2dec' bits = sum (zipWith (\x y -> x*(2^y)) bits [((length bits)-1),((length bits)-2)..0])
---------------------------------------------------------
-- Crie uma função recursiva dec2bin :: Int -> [Int] que receba um número inteiro positivo e retorne sua representação em binário, sob forma de uma lista de 0's e 1's. As funções auxiliares autorizadas aqui são mod, div e reverse. Exemplos de uso da função:
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
---------------------------------------------------------          
-- Implemente uma dessas funções: isHex :: String -> Bool ou hex2dec :: String -> Int ou dec2hex :: Int -> String, que são semelhantes às dos exercícios anteriores, porém com números hexadecimais no lugar de números binários. Aqui está tudo liberado: você pode escolher qual das funções irá implementar, sem restrições sobre como deve fazer isso.
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
---------------------------------------------------------   
-- Parte 3
-- A codificação EAN-13 é um padrão de código de barras usado em vários tipos de produtos. O número codificado em barras tem 13 dígitos (0-9), sendo o último um dígito verificador (exemplo: 5901234123457, dígito verificador 7). O cálculo do dígito verificador obedece a algumas regras simples disponíveis em: https://www.gs1.org/services/how-calculate-check-digit-manually

-- Você deverá implementar uma função isEanOk :: String -> Bool, que verifique se uma dada string representa um número EAN-13 com dígito verificador válido.
isEanOk :: String -> Bool
isEanOk str = if (length str) /= 13
  then False
  else (digitToInt (last str) == verificador str)

verificador :: String -> Int
verificador x = 10 - (mod (soma x) 10)

soma :: String -> Int
soma x = sum (zipWith (*) (listaINT x) [1,3,1,3,1,3,1,3,1,3,1,3])

listaINT :: String -> [Int]
listaINT [] = []
listaINT (x:xs) = (digitToInt x):(listaINT xs)
---------------------------------------------------------  
-- Parte 4
-- Nesta parte do trabalho, vamos trabalhar com uma forma simples de codificar mensagens secretas :-) Para isso, você vai precisar baixar o programa t2parte4.hs e completá-lo com as funções abaixo.
---------------------------------------------------------
-- Converte um caracter em um inteiro
encodeChar :: Char -> Int
encodeChar c = ord c - ord 'a'
---------------------------------------------------------
-- Converte um inteiro em um caracter
decodeChar :: Int -> Char
decodeChar n = chr (ord 'a' + n)
---------------------------------------------------------
-- Calcula percentagem: n/m*100
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m)*100
---------------------------------------------------------
-- Rotacao de uma lista para esquerda em n posicoes
rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs
---------------------------------------------------------
-- Tabela de frequencias das letras 'a'..'z' (lingua portuguesa)
-- https://pt.wikipedia.org/wiki/Frequ%C3%AAncia_de_letras
table :: [Float]
table = [14.6, 1.0, 3.9, 5.0, 12.6, 1.0, 1.3, 1.3, 6.2, 0.4, 0.1, 2.8, 4.7, 
         5.0, 10.7, 2.5, 1.2, 6.5, 7.8, 4.3, 4.6, 1.7, 0.1, 0.2, 0.1, 0.5]
---------------------------------------------------------
-- Distancia entre 2 listas de frequencia
chi2 :: [Float] -> [Float] -> Float
chi2 os es = sum [((o-e)^2)/e | (o,e) <- zip os es]
---------------------------------------------------------
-- Use esta funcao para decodificar uma mensagem!
crack :: String -> String
crack cs = encodeStr cs (-factor)
           where factor = head (positions (minimum chitab) chitab)
                 chitab = [ chi2 (rotate n table' ) table | n <- [0..25] ]
                 table' = freqs cs
---------------------------------------------------------                 
-- Usando encodeChar e decodeChar, defina uma função shiftChar :: Char -> Int -> Char. Essa função, ao receber um caracter de 'a' a 'z', aplicará um deslocamento de 'n' unidades sobre ele, produzindo outro caracter no intervalo ['a'..'z']. Por exemplo:
-- > shiftChar 'a' 3
-- 'd'
-- > shiftChar 'a' 0
-- 'a'
-- > shiftChar 'A' 3
-- 'A'
-- > shiftChar ' ' 1
-- ' '
-- > shiftChar 'z' 3
-- 'c'
-- > shiftChar 'z' 1
-- 'a'
shiftChar :: Char -> Int -> Char
shiftChar x n
            | isLower x = decodeChar (mod (encodeChar x + n) 26)
            | otherwise = x
---------------------------------------------------------            
-- Note, pelos exemplos acima, que caracteres fora do intervalo não devem sofrer deslocamento. Além disso, o deslocamento deve ser aplicado de forma circular sobre o intervalo.

-- Usando shiftChar, defina uma função encodeStr :: String -> Int -> String que codifique uma string usando um dado deslocamento. Por exemplo:
-- > encodeStr "abracadabra" 3
-- "deudfdgdeud"
-- > encodeStr "paradigmas de programacao" 3
-- "sdudgljpdv gh surjudpdfdr"
encodeStr :: String -> Int -> String
encodeStr str n = map (\x -> shiftChar x n) str
---------------------------------------------------------
-- Defina uma função countValids :: String -> Int, que receba uma string e retorne a quantidade de seus caracteres contidos no intervalo ['a'..'z']. Exemplo:
-- > countValids "paradigmas de programacao"
-- 23
countValids :: String -> Int
countValids str = length (filter isLower str)
---------------------------------------------------------
-- Defina uma função countChar :: Char -> String -> Int, que retorne a quantidade de um dado caracter em uma string. Exemplo:
-- > countChar 'a' "paradigmas de programacao"
-- 6
countChar :: Char -> String -> Int
countChar l str = length (filter (\x -> x == l) str)
---------------------------------------------------------
-- Usando countValids, countChar e percent, defina uma função freqs :: String -> [Float] que retorne as frequências dos caracteres ['a'..'z'] numa dada string. Use list comprehension. A frequência de um caracter é dada pelo percentual deste caracter entre os caracteres válidos da string. Por exemplo:
-- > freqs "abc" 
-- [33.333336,33.333336,33.333336,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
-- > freqs ['a'..'z']
-- [3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154]
-- > sum $ freqs ['a'..'z']
-- 99.99999
-- > freqs "abc def ghi jkl mno pqr stu vwx yz"
-- [3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154,3.846154]
-- > freqs "aaa"
-- [100.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
freqs :: String -> [Float]
freqs str = map (\x -> percent (countChar x str) (countValids str)) ['a'..'z']
---------------------------------------------------------
-- Defina uma função positions :: Float -> [Float] -> [Int], que retorne uma lista de posições de um dado número em uma lista. Considere que as posições comecem em zero. Use a função zip como auxiliar no seu código. Exemplos de uso da função:
-- > positions 1.5 [0,7.5,8,1.5]
-- [3]
-- > positions 1.5 [1.5,7.5,8,1.5]
-- [0,3]
-- > positions 9 [1.5,7.5,8,1.5]
-- []
positions :: Float -> [Float] -> [Int]
positions float lista = map snd (filter (\x -> fst x == float) (zip lista [0..]))
---------------------------------------------------------
-- Decifre os códigos abaixo para descobrir ideias de extras! :-)

-- Phvtxlvh vreuh d ixqfdr gh dowd rughp irog, wdpehp fkdpdgd gh uhgxfh, h vxdv yduldfrhv irogu, irogo, irogu1, irogo1. Fruqhfd xpd qryd yhuvdr gh dojxpd ixqfdr gd sduwh txdwur, xvdqgr dojxpd yduldfdr gh irog.
{-
  Pesquise sobre a funcao de alta ordem fold, tambem chamada de reduce,
  e suas variacoes foldr, foldl, foldr1, foldl1. Forneca uma nova versao 
  de alguma funcao da parte quatro, usando alguma variacao de fold.
-}

-- 41 6c 67 75 6d 61 73 20 66 72 61 73 65 73 20 66 61 6d 6f 73 61 73 20 64 6f 20 41 6c 61 6e 20 4a 2e 20 50 65 72 6c 69 73 
-- 20 70 61 72 61 20 65 73 70 69 63 68 61 72 20 61 20 6d 65 6e 73 61 67 65 6d 3a a 46 6f 6e 74 65 3a 20 68 74 74 70 3a 2f 
-- 2f 77 77 77 2e 63 73 2e 79 61 6c 65 2e 65 64 75 2f 68 6f 6d 65 73 2f 70 65 72 6c 69 73 2d 61 6c 61 6e 2f 71 75 6f 74 65 73 
-- 2e 68 74 6d 6c a 38 2e 20 41 20 70 72 6f 67 72 61 6d 6d 69 6e 67 20 6c 61 6e 67 75 61 67 65 20 69 73 20 6c 6f 77 20 6c 65 
-- 76 65 6c 20 77 68 65 6e 20 69 74 73 20 70 72 6f 67 72 61 6d 73 20 72 65 71 75 69 72 65 20 61 74 74 65 6e 74 69 6f 6e 20 74 
-- 6f 20 74 68 65 20 69 72 72 65 6c 65 76 61 6e 74 2e a 39 2e 20 49 74 20 69 73 20 62 65 74 74 65 72 20 74 6f 20 68 61 76 65 
-- 20 31 30 30 20 66 75 6e 63 74 69 6f 6e 73 20 6f 70 65 72 61 74 65 20 6f 6e 20 6f 6e 65 20 64 61 74 61 20 73 74 72 75 63 74 
-- 75 72 65 20 74 68 61 6e 20 31 30 20 66 75 6e 63 74 69 6f 6e 73 20 6f 6e 20 31 30 20 64 61 74 61 20 73 74 72 75 63 74 75 72 
-- 65 73 2e 20 a 31 39 2e 20 41 20 6c 61 6e 67 75 61 67 65 20 74 68 61 74 20 64 6f 65 73 6e 27 74 20 61 66 66 65 63 74 20 74 
-- 68 65 20 77 61 79 20 79 6f 75 20 74 68 69 6e 6b 20 61 62 6f 75 74 20 70 72 6f 67 72 61 6d 6d 69 6e 67 2c 20 69 73 20 6e 6f
-- 74 20 77 6f 72 74 68 20 6b 6e 6f 77 69 6e 67 2e a 41 67 6f 72 61 20 73 69 6d 2c 20 61 20 55 52 4c 20 69 6d 70 6f 72 74 61 
-- 6e 74 65 20 70 61 72 61 20 65 73 74 65 20 74 72 61 62 61 6c 68 6f 3a a 68 74 74 70 3a 2f 2f 62 69 74 2e 6c 79 2f 64 65 73 
-- 61 66 69 6f 2d 70 61 72 61 64 69 67 6d 61 73 a 41 63 65 73 73 65 20 70 61 72 61 20 73 61 62 65 72 20 6d 61 69 73 21

-- Ne tevxi xviw, ew vikvew hi gepgyps hs hmkmxs zivmjmgehsv iwxes mpywxvehew iq yq ibiqtps jsvqexehs gsqs yqe xefipe lxqp. Cvmi yqe jyrges uyi tvshyde s gshmks lxqp hi yqe xefipe wiqiplerxi, teve yq hehs ryqivs ier hi xvidi hmkmxsw.
{-
  "Na parte tres, as regras de calculo do digito verificador estao ilustradas em um exemplo formatado como uma tabela html. Crie uma funcao que produza o codigo html de uma tabela semelhante, para um dado numero ean de treze digitos."
-}

-- 41 63 65 73 73 65 20 65 73 74 61 20 75 72 6c 20 65 20 64 65 73 63 75 62 72 61 20 75 6d 61 20 73 65 6c 65 63 61 6f 20 64 
-- 65 20 71 75 65 73 74 6f 65 73 20 64 65 20 70 61 72 61 64 69 67 6d 61 73 20 64 65 20 70 72 6f 67 72 61 6d 61 63 61 6f 20 
-- 64 61 73 20 70 72 6f 76 61 73 20 64 6f 20 65 6e 61 64 65 20 65 20 70 6f 73 63 6f 6d 70 3a 20 68 74 74 70 73 3a 2f 2f 64 
-- 6f 63 73 2e 67 6f 6f 67 6c 65 2e 63 6f 6d 2f 73 70 72 65 61 64 73 68 65 65 74 73 2f 64 2f 31 76 78 34 59 47 63 4a 46 61 
-- 38 48 42 49 4a 2d 59 57 4f 5f 72 76 31 42 63 37 4c 6e 77 4a 79 4e 45 46 74 67 50 4a 53 56 6b 36 35 63 2f 65 64 69 74 3f 
-- 75 73 70 3d 73 68 61 72 69 6e 67 20 45 73 63 6f 6c 68 61 20 75 6d 61 20 71 75 65 73 74 61 6f 20 71 75 65 20 65 6e 76 6f 
-- 6c 76 61 20 6f 20 70 61 72 61 64 69 67 6d 61 20 66 75 6e 63 69 6f 6e 61 6c 20 65 20 65 78 70 6c 69 71 75 65 20 73 75 61 20 
-- 72 65 73 6f 6c 75 63 61 6f 2e

-- Esywjlzj xjz htinlt jr Hfxpjqq zxfit ufwf ijhnkwfw fx rjsxfljsx fhnrf.
{-
  "Entregue seu codigo em Haskell usado para decifrar as mensagens acima."
-}
