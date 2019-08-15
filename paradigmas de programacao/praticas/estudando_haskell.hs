import Data.Char
import Data.List 

-- Lista de Exercicios
-- 1. soma:recebe uma dupla de inteiros e retoma a sua soma.
-- Ex.:soma(1,2)==>3
soma :: (Int, Int) -> Int
soma (a,b) = a + b

-- 2. menorDeDois:recebe dois valores inteiros e retorna o menor.
menorDeDois::(Int,Int) -> Int
menorDeDois (x,y) = if  x < y then x else y

-- 3. menorDeTres:recebe tres valores inteiros e retorna o menor.
menorDeTres::(Int,Int,Int) -> Int
menorDeTres (x,y,z) = menorDeDois (x, menorDeDois(y,z))

-- 4. areaCircunf: recebe um float representando o raio de uma circunferencia e retorna sua area.
areaCircunf :: Float -> Float
areaCircunf a = pi * a^2

-- 5. andTres: recebe tres booleanos e retorna a operacao AND aplicada aos tres.
andTres :: Bool -> Bool -> Bool -> Bool
andTres a b c = (a && b) && c

-- 6. Defina o operador #que concatena duas strings caso elas sejam diferentes. Se forem iguais retorna uma das duas.
concatena :: String -> String -> String 
concatena x y = if  x == y then x else x ++ y

-- 7. ePrimo: recebe um numero natural everifica se ele e primo.
lcand n = [2..(n - 1)]
tem_divisor n [ ] = False
tem_divisor n (x:xs) = if (mod n x) == 0 then True else tem_divisor n xs
ePrimo :: Int -> Bool
ePrimo n = not (tem_divisor n (lcand n))

-- 8. fatorial:recebe um numero natural e retorna o seu fatorial.
fatorial :: Int -> Int  
fatorial 0 = 1  
fatorial n = n * fatorial (n - 1)

-- 9. fibonacci: recebe um numero inteiro positivo e retorna o n-esimoelemento  da sequencia de Fibonacci.
fibonacci :: Int -> Int
fibonacci 1 = 1
fibonacci 0 = 0
fibonacci n = fibonacci(n - 1) + fibonacci(n - 2)

-- 10. elemento: recebe uma lista qualquer e um numero inteiro positivo para retornar o n-esimo elemento da lista.
-- Ex.:elemento [3,5,7] 1 ==>5
-- elemento 
elemento :: [a] -> Int -> a
elemento [] k = error "List is empty"
elemento (x:xs) 0 = x
elemento (x:xs) k = elemento xs (k-1)

-- 11. pertence: recebe um elemento e uma lista e verifica se o elemento pertence à lista.
-- Ex.: pertence 1 [3,7,4,2] ==>False
pertence :: Int -> [Int] -> Bool
pertence _ [] = False
pertence n (x: xs) | (x == n) = True
                   | otherwise = pertence n xs

-- 12. nroElementos: recebe uma lista qualquer e retorna o numero de elementos na lista.
-- Obs.:nao usar a funcao length
nroElementos :: [Int] -> Int 
nroElementos [] = 0
nroElementos (x:xs) = 1 + nroElementos xs

-- 13. maior: recebe uma lista de inteiros e retorna o maior.
-- Obs.:nao usar a funcao max
maior :: [Int] -> Int
maior [x] = x
maior (x:xs) | (x > maior xs) = x
             | otherwise = maior xs

-- 14. contaOcorrencias: recebe um elemento e uma lista e retorna o numero de ocorrencias do elemento na lista.
contaOcorrencias :: [Int] -> Int -> Int
contaOcorrencias [] _= 0
contaOcorrencias (x:xs) n | (x == n) = 1 + contaOcorrencias xs n
                          | otherwise = contaOcorrencias xs n

-- 15. unicaOcorrencia: recebe um elemento e uma lista everifica se existe uma unica ocorrencia do elemento na lista. Ex.:unicaOcorrencia 2 [1,2,3,2] ==>False
-- unicaOcorrencia 2 [3,1] ==>False
-- unicaOcorrencia 2 [2] ==>True
{-unicaOcorrencia :: [Int] -> Int -> Int
unicaOcorrencia [] _= 0
unicaOcorrencia (x:xs) n | (x == n) = if (1 + contaOcorrencias xs n > 1) then False else True
                          | otherwise = contaOcorrencias xs n
-}

-- 16. maioresQue: recebe um numero inteiro e uma lista de inteiros e retorna uma lista com os numeros que sao maiores que o fomecid.
maioresQue :: Int -> [Int] -> [Int]
maioresQue n lista = filter(>n) lista

-- 17. Escreva funções para calcular:
-- (a) Uma equação do primeiro grau (ax + b )
-- (b) Uma equação do segundo grau (ax² + bx + c)
primeiro_grau::Float->Float->Float
primeiro_grau x y = - y / x

delta::Float->Float->Float->Float
delta a b c = -b^2 * 4 * a * c

segundo_grau::Float->Float->Float->(Float, Float)
segundo_grau a b c = if (delta a b c) < 0.0 then undefined else ( (- b - sqrt(delta a b c)) / 2.0 * a, (- b + sqrt(delta a b c)) / 2.0 * a)

-- 18. Construa uma função que calcule o valor do mínimo múltiplo comum de três números inteiros.
mdc::Int->Int->Int
mdc a b | a < b = mdc b a
 | b == 0 = a
 | otherwise = mdc b (mod a b)
 
mmc::Int->Int->Int
mmc x y = (x * y) `div` (mdc x y)

mmc3n::Int->Int->Int->Int
mmc3n x y z = mmc x (mmc y z)

--  19. Construa uma função que calcule o valor do máximo divisor comum entre três números inteiros.
mdc3n::Int->Int->Int->Int
mdc3n a b c = mdc a (mdc b c)

-- 20. Faça uma função que, dado um ano, verifica se o mesmo é bissexto.
bissexto:: Int-> Bool
bissexto x | (mod x 400 == 0) = True
 | (mod x 4 == 0) && (mod x 100 /= 0) = True
 | otherwise = False
 
-- 21. Defina uma função que recebe três números inteiros representando, respectivamente, um dia, um mês e um ano e verifica se os números formam uma data válida
type Data = (Int,Int,Int)
valida::Data->Bool
valida (d,m,a)
          | d >= 1 && d <= 31 && (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) = True
          | d >= 1 && d <= 30 && (m == 4 || m == 6 || m == 9 || m == 11) = True
          | d >= 1 && d <= 28 && m == 2 && not (bissexto a) = True
          | d >= 1 && d <= 29 && m == 2 && (bissexto a) = True
          | otherwise = False

-- 22. Escreva uma funcao para calcular o dobro de um numero
dobroDeN :: Int -> Int
dobroDeN t = t * 2

-- 23. Defina uma funcao para calcular a distancia entre dois pontos (num plano).
distancia_entrePontos :: (Float, Float) -> (Float, Float) -> Float
distancia_entrePontos (a, b) (c, d) = sqrt (((a-c)^2) + ((b-d)^2))

-- 24. Dadas as medidas dos catetos de um triangulo retangulo, retornar o valor de sua hipotenusa.
hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt(a^2 + b^2)

-- 25. Calcular a soma entre dois números n1 e n2 incluindo os limites Soma 3 7 = 3+4+5+6+7 = 25

-- 26. Seja a sequência:
-- A1 = 6
-- A2 = 6 + 6
-- A3 = 6 + 6 + 6
-- A4 = ...
-- Encontre a forma recursiva para An+1

-- 27. Faça uma função que calcula a potência XY, sem a utilização dosoperadores de potenciação.

-- 28. Faça funções utilizando recursão de cauda que calcula:
-- a. O fatorial de um número.
-- b. A potência XY

-- 29. Reescreva a função para calcular uma equação do segundo grau (ax² + bx + c), retornando as duas raízes (se houver) numa tupla-2.

-- 30. Defina uma função que dada uma lista de inteiros, retorna os elementos de valor inferior a um número n qualquer.
-- > retornaInf 4 [3,2,5,6]
-- [2, 3]
retornaInf :: Int -> [Int] -> [Int]
retornaInf n lista = filter(<n) lista

-- 31. A função que, dada uma lista e um elemento, o coloca no ﬁm da lista.
lista_fim :: [a] -> a -> [a]
lista_fim [] x = [x]
lista_fim (h:t) x = h : lista_fim t x

-- 32. Escreva uma função que recebe duas listas de inteiros e produz uma lista de listas. Cada uma corresponde à multiplicação de um elemento da primeira lista por todos os elementos da segun
-- > mult_listas [1,2] [3,2,5]
-- [[3,2,5],[6,4,10]]

-- 33. Escreva uma função para verificar se os elementos de uma lista são distintos.
dif :: Eq a => [a] -> Bool
dif [] = True
dif (h:t) = not(elem h t) && dif t

-- 34. Seja a função união abaixo, definida através da construção de listas por compreensão. Teste esta função e implemente a interseção utilizando a mesma estratégia.
-- uniao :: Eq t => [t] -> [t] -> [t]
-- uniao as bs = as ++ [b | b <- bs, not (pertence b as)]

-- 35. Use a construção de listas por compreensão para definir uma função que recebe uma lista e retorna uma lista contendo apenas os elementos negativos da lista original,

-- 36. Seja a função abaixo que recebe uma lista de pontos no plano cartesiano e calcula a distância de cada ponto à origem:
distancias :: [(Float,Float)] -> [Float]
distancias [] = []
distancias ((x,y):xys) = (sqrt (x^2 + y^2)) : (distancias xys)
-- Escreva uma outra versão da função distâncias, utilizando a construção de listas por compreensão.

-- 37. Defina a função tabuada :: Int -> [(Int, Int, Int)] que dado um inteiro n produz uma lista da tabuada dos n.
-- > tabuada 5
-- [(5,1,5), (5,2,10),(5,3,15), … , (5,10,50)]

-- 38. Duplicar os elementos de uma lista.
-- dupli [ 1 , 2 , 3 ] 
-- [ 1 , 1 , 2 , 2 , 3 , 3 ]
dupli :: [a] -> [a]
dupli list = concatMap (\x -> [x,x]) list

-- 39. Replicar os elementos de uma lista um determinado número de vezes.
-- repli "abc"  3 
-- "aaabbbccc"
repli :: [a] -> Int -> [a]
repli list n = concatMap (\x -> replicate n x) list

-- 40. Divida uma lista em duas partes; o comprimento da primeira parte é dado.
-- dividir "abcdefghik"  3 
-- ( "abc" , "defghik" )
dividir [] _ = ([],[])
dividir (x:xs) a | x<a = (x:z,b)
                 | otherwise = (z,x:b)
                            where (z,b) = dividir xs a

-- 41. Gire uma lista N lugares à esquerda
-- girar [ 'a', 'b', 'c', 'd', 'e', ​​'f', 'g', 'h' ]  3 
-- "defghabc"
girar :: [a] -> Int -> [a]
girar list n | n < 0 = girar list ((length list) + n)
             | otherwise = let (first, second) = splitAt n list in second ++ first
             
-- 42. Remova o elemento K de uma lista.
-- removeAt [ " a " , " b " , " c " , " d " ] 2
-- ([" a "," c "," d "]," b ")
removeAt :: [a] -> Int -> ([a],a)
removeAt list k = let (first, second) = splitAt k list
                  in ((init first) ++ second, last first)

-- 43. inserir um elemento em uma determinada posição em uma lista.
-- insertAt 'X' "abcd"  2 
-- "aXbcd"
insertAt :: a -> [ a ] -> Int -> [ a ]
insertAt x ys 1 = x : ys
insertAt x ( y : ys ) n = y : insertAt x ys ( n - 1 )

-- 44. Crie uma lista contendo todos os inteiros dentro de um determinado intervalo.
-- intervalo 4  9 
-- [ 4 , 5 , 6 , 7 , 8 , 9 ]
intervalo :: Int -> Int -> [Int]
intervalo start end = [start..end]

-- 45. Loteria: Desenhe N números aleatórios diferentes do conjunto 1.M.

-- 46. Uma lista de números primos. Dado um intervalo de inteiros por seu limite inferior e superior, construa uma lista de todos os números primos nesse intervalo.
-- primesR 10  20 
-- [ 11 , 13 , 17 , 19 ]

-- 47. Dadas duas strings xs e ys, verificar se xs é substring de ys.
substring :: String -> String -> Bool 
substring (x:xs) [] = False 
substring xs ys | prefix xs ys = True 
                | substring xs (tail ys) = True 
                | otherwise = False 
                
prefix :: String -> String -> Bool 
prefix [] ys = True 
prefix (x:xs) [] = False 
prefix (x:xs) (y:ys) = (x == y) && prefix xs ys

-- 48. Determinar a posição de um elemento x em uma lista xs, se ele ocorrer na lista.
posicao_elemento :: [Int] -> Int -> Bool
posicao_elemento [] _ = False
posicao_elemento (x:xs) n | (x==n) = True
                          | otherwise = posicao_elemento xs n
                          
-- 49. Dadas duas listas xs e ys, ordenadas em ordem crescente, obter a lista ordenada resultante da intercalação de xs e ys.

-- 50. Defina a função isIn :: Eq a => a -> [a] -> Bool que dados um valor e uma lista, retorna verdadeiro se o valor está na lista e falso caso contrário.

-- 51. Defina a função strip :: Eq a => [a] -> [a] -> [a] que dadas duas listas, retira da segunda todos os elementos que ocorrem na primeira.
-- strip "a" "batata" -> "btt"

-- 52. Construa a funcao ocorrencias::Int->[Int]->Int que, dada uma
-- lista de inteiros e um valor inteiro, retorne o numero de 
-- ocorrencias desse valor na lista
ocorrencias :: Int -> [Int] -> Int
-- tamanho da lista: 'x' pertece a 'l' tal que 'x' == 'n'
ocorrencias n l = length [ x | x <- l, x == n ]


-- 53. Construa a funcao unicos::[Int]->[Int] que dada uma lsita de inteiros
-- retorna uma lista contendo os valores que ocorrem apenas uma vez na 
-- lista de entrada.
unicos :: [Int] -> [Int]
isMember :: Int -> [Int] -> Bool
elimina :: Int -> [Int] -> [Int]
isMember n lista = [ x | x <- lista, n == x ] /= []
elimina n lista = [ x | x <- lista, x /= n]
unicos [] = []

-- se a cabeca aparece na calda:
--   elimina cabeca da calda e faz recursao sobre o resultado
-- se nao adiciona cabeca mais recusao sobre a calda
unicos (h:tail)
   | isMember h tail = unicos (elimina h tail)
   | otherwise       = [h] ++ unicos tail


-- 54. Defina a funcao desloque::[Int]->[Int] que, dada uma lista de
-- inteiros, retorna uma lista correspondente a original deslocada 
-- uma posicao a esquerda.
desloque :: [Int] -> [Int]
desloque [] = []
desloque (h:tail) = tail ++ [h]

-- 55. Encontre o último elemento de uma lista.
-- myLast [ 1 , 2 , 3 , 4 ] 
-- 4 
mylast :: [t] -> t
mylast t = last t

-- 56. Encontre o último, mas um elemento de uma lista.
-- myButLast [ 1 , 2 , 3 , 4 ] 
-- 3
myButLast :: [t] -> t
myButLast t = last (init t)

-- 57. Desenvolva uma função recursiva em Haskell que retorne o produto dos elementos de uma lista.
produtodelistas :: [Int] -> Int
produtodelistas [] = 1
produtodelistas (x:xs) = 0 + x * produtodelistas xs

-- 58. Inverta uma lista.
inv_aux :: [t] -> [t] -> [t]
inv_aux [] a = a
inv_aux (x:xs) a = inv_aux xs a++[x]

inverteLista :: [t] ->  [t]
inverteLista [] = []
inverteLista x = inv_aux x []

inverteLista' :: [t] ->  [t]
inverteLista' [] = []
inverteLista' (x:xs) = inverteLista' xs ++ [x]

-- 59. Descubra se uma lista é um palíndromo. Um palíndromo pode ser lido para frente ou para trás; por exemplo (xamax).
isPalindrome :: Eq a => [a] -> Bool
isPalindrome list = (list == (reverse list))

-- 60. Elimine duplicatas consecutivas de elementos da lista.
-- comprimir "aaaabccaadeeee" 
-- "abcade"
comprimir :: Eq a => [a] -> [a]
comprimir [] = []
comprimir (x:xs) = x : comprimir (dropWhile (== x) xs)

-- 61. verifica na lista se todos pares 
todosPares :: [Int] -> Bool
todosPares [] = True
todosPares (x:xs) | (mod x 2 /= 0) = False
                  | otherwise = todosPares xs
                  
-- 62. soma n numeros 
somaN :: Int -> Int
somaN 1 = 1
somaN n = somaN(n-1) + n

-- 63. soma duas duplas 
somaDuplas :: (Int, Int) -> (Int, Int) -> (Int, Int)
somaDuplas (a,b) (c,d) = (a+c, b+d)

-- 64. Desenvolva uma função em Haskell que retorne uma lista com o quadrado de cada elemento de uma lista fornecida.
quadrado_lista :: [Int] -> [Int]
quadrado_lista t = map(\x-> x^2) t

-- 65. Desenvolva uma função em Haskell que retorne as letras de seu nome ordenadas.

-- 66. Desenvolva uma função em Haskell que retorne uma lista de inteiros ordenada.

-- 67. Desenvolva uma função em Haskell que retorne o somatório dos N primeiros termos da série de Fibonacci.
fib :: Int -> Int 
fib 0 = 0 
fib 1 = 1 
fib x = fib (x-1) + fib (x-2)

sumFib :: Int -> Int 
sumFib x = sum (map fib [1..x]) 

-- 68. combinar duas listas com zip
-- zip :: [a] -> [b] -> [(a,b)]

-- 69. retorna o quadrado de um numero
quad :: Int -> Int
quad n = quad_n
             where 
                  quad_n = n * n
                  
-- 70. soma todos elemntos da listas
soma_lista :: [Int] -> Int
soma_lista [] = 0
soma_lista (x:xs) = x + soma_lista xs

-- 71. intersecção de duas listas
interseccaoL :: Eq t => [t] -> [t] -> [t]
interseccaoL lista1 lista2 = intersect lista1 lista2

-- 72. pegar n primeiros numeros de uma lista
takelista :: Int -> [t] -> [t]
takelista _ [] = []
takelista n lista = take n lista

-- 73. Verificar se um elemento está numa lista
elemc :: Eq a => ([a],a) -> Bool
elemc ([], _) = False
elemc ((x:xs), y) = if x == y then True else elemc (xs, y)

-- 74. Definir uma função recursiva primitiva capaz de comprimir a lista removendo todos os elementos repetidos em sequencia. Ex : aaabbbcddd → abcd
removeDups :: (Eq a) => [a] -> [a]
removeDups []             =  []
removeDups (xs : [])      =  [xs]
removeDups (x1:x2:xs)
          | x1 == x2     =      removeDups (x2 : xs)
          | otherwise    = x1 : removeDups (x2 : xs)
          
-- 75. verificar se um caracter é um dígito decimal:
isDigit :: Char -> Bool
isDigit c = c >= '0' && c <= '9'

-- 76. calcular o recíproco de um número:
recip :: Fractional a => a -> a
recip n = 1/n

-- site de estudos http://www.facom.ufu.br/~madriana/PF_BCC.html
