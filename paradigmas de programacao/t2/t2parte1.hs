-- juliano leonardo soares
-- Trabalho 2: Mais programação funcional em Haskell
-- Parte 1
-- exercícios sobre recursividade em Haskell.
-- 1-Usando recursão, escreva uma função geraTabela :: Int -> [(Int,Int)] que produza uma lista com n tuplas, cada tupla com números de n a 1 e seus respectivos quadrados. Exemplo:

-- > geraTabela 5
-- [(5,25),(4,16),(3,9),(2,4),(1,1)]
-- > geraTabela 0
-- []
geraTabela :: Int -> [(Int,Int)]
geraTabela 0 = []
geraTabela x = (x,x*x) :geraTabela (x-1)

-- 2-Defina uma função recursiva que verifique se um dado caracter está contido numa string, conforme os exemplos abaixo:

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
       
-- 3-Defina uma função recursiva que receba uma lista de coordenadas de pontos 2D e desloque esses pontos em 2 unidades, conforme o exemplo abaixo:

-- > translate [(0.1,0.2),(1.1,6.0),(2.0,3.1)]
-- [(2.1,2.2),(2.1,8.0),(4.0,5.1)]
translate :: [(Float, Float)] -> [(Float, Float)]
translate [] = []
translate ((x,y):xs) = (x + 2, y + 2) : translate xs

-- 4-Defina uma função que receba um número n e retorne uma lista de n tuplas, cada tupla com números de 1 a n e seus respectivos quadrados. Dica: defina uma função auxiliar recursiva com 2 argumentos, sendo um deles que se mantém inalterado na chamada recursiva. Exemplo:

-- > geraTabela' 5
-- [(1,1),(2,4),(3,9),(4,16),(5,25)]

geraTabela' :: Int -> [(Int,Int)]
geraTabela' 0 = [(0, 0)]
geraTabela' n = aux 1 n

aux :: Int -> Int -> [(Int, Int)]
aux h n = if(h  <= n)
   then (h, h^2) : aux(h + 1) n
   else []
