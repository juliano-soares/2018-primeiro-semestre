-- juliano leonardo soares
-- Trabalho 2: Mais programação funcional em Haskell
-- Parte 3
-- A codificação EAN-13 é um padrão de código de barras usado em vários tipos de produtos. O número codificado em barras tem 13 dígitos (0-9), sendo o último um dígito verificador (exemplo: 5901234123457, dígito verificador 7). O cálculo do dígito verificador obedece a algumas regras simples disponíveis em: https://www.gs1.org/services/how-calculate-check-digit-manually
import Data.Char
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
