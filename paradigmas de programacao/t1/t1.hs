-- Nome: Juliano Leonardo Soares
-- trabalho 01

import Data.Char

---------------------------------------------------------
-- **1-Crie uma função isVowel :: Char -> Bool que verifique se um caracter é uma vogal ou não.

-- modelo 1
isVowel :: Char -> Bool
isVowel digito = length(filter (\x -> x == digito) "aAeEiIoOuU") > 0
-- modelo 2
isVowel_1 :: Char -> Bool
isVowel_1 dig = dig == 'a' || dig == 'e' || dig == 'i' || dig == 'o' || dig == 'u' || dig == 'A' || dig == 'E' || dig == 'I' || dig == 'O' || dig == 'U' 
-- modelo 3
isVowel_2 :: Char -> Bool
isVowel_2 dig = elem dig "aAeEiIoOuU"

---------------------------------------------------------
-- **2-Escreva uma função addComma, que adicione uma vírgula no final de cada string contida numa lista.

-- modelo 1
addComma :: [String] -> [String]
addComma lista_str = map (\x -> x ++ ",") lista_str

-- modelo 2
func_auxiliar_addComma :: String -> String
func_auxiliar_addComma x = x ++ ","

addComma_2 :: [String] -> [String]
addComma_2 x = map func_auxiliar_addComma x

---------------------------------------------------------
-- **3-Crie uma função htmlListItems :: [String] -> [String], que receba uma lista de strings e retorne outra lista contendo as strings formatadas como itens de lista em HTML. Resolva este exercício COM e SEM funções anônimas (lambda). Exemplo de uso da função:
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
-- **4-Defina uma função que receba uma string e produza outra retirando as vogais, conforme os exemplos abaixo. Resolva este exercício COM e SEM funções anônimas (lambda).> semVogais "andrea" "ndr"       > semVogais "xyz""xyz"> semVogais "ae"""
  
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
-- **5-Defina uma função que receba uma string, possivelmente contendo espaços, e que retorne outra string substituindo os demais caracteres por '-', mas mantendo os espaços. Resolva este exercício COM e SEM funções anônimas (lambda). Exemplos:
  
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
-- **6-Escreva uma função firstName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu primeiro nome. Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome. Dica: estude funções pré-definidas em Haskell (List operations -> Sublists) em http://hackage.haskell.org/package/base-4.10.1.0/docs/Prelude.html#g:18. Exemplos de uso da função:
  
  -- > firstName "Anderson Silva" 
  -- "Anderson"
  -- > firstName "JON BON JOVI"
  -- "JON"

-- firstName :: String -> String
-- firstName str = head(span (== " ") str)

-- modelo 1
firstName :: String -> String
firstName string = takeWhile(/= ' ') string

-- modelo 2
firstName_1 :: String -> String
firstName_1 string = head(words string)

---------------------------------------------------------
-- **7-Escreva uma função isInt :: String -> Bool que verifique se uma dada string só contém dígitos de 0 a 9. Exemplos:
  
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
-- **8-Escreva uma função lastName :: String -> String que, dado o nome completo de uma pessoa, obtenha seu último sobrenome. Suponha que cada parte do nome seja separada por um espaço e que não existam espaços no início ou fim do nome. Exemplos de uso da função:

  -- > lastName "Anderson Silva"
  -- "Silva"
  -- > lastName "JON BON JOVI"
  -- "JOVI"
lastName :: String -> String
lastName string = last (words string)

---------------------------------------------------------
-- **9-Escreva uma função userName :: String -> String que, dado o nome completo de uma pessoa, crie um nome de usuário (login) da pessoa, formado por: primeira letra do nome seguida do sobrenome, tudo em minúsculas. Dica: estude as funções pré-definidas no módulo Data.Char, para manipulação de maiúsculas e minúsculas. Você precisará carregar este módulo usando import Data.Char no interpretador ou no início do arquivo do programa.

  -- Exemplos de uso da função:
  -- > userName "Anderson Silva"
  -- "asilva"
  -- > userName "JON BON JOVI"
  -- "jjovi"
userName :: String -> String
userName string = map toLower ([head string] ++ lastName string)

---------------------------------------------------------
-- **10-Escreva uma função encodeName :: String -> String que substitua vogais em uma string, conforme o esquema a seguir: a = 4, e = 3, i = 2, o = 1, u = 0.

  -- Exemplos de uso da função:
  -- > encodeName "Anderson Silva"
  -- "4nd3rs1n s2lv4"
  -- > encodeName "Badtz Maru"
encodeName :: String -> String
encodeName string = map substituiVogal string

substituiVogal :: Char -> Char
substituiVogal char | (char == 'a') || (char == 'A') = '4' | (char == 'e') || (char == 'E') = '3'  | (char == 'i') || (char == 'I') = '2' | (char == 'o') || (char == 'O') = '1' | (char == 'u') || (char == 'U') = '0' | otherwise = char

---------------------------------------------------------
-- **11-Escreva uma função betterEncodeName :: String -> String que substitua vogais em uma string, conforme este esquema: a = 4, e = 3, i = 1, o = 0, u = 00. Exemplos de uso da função:
  
  -- > betterEncodeName "Anderson Silva"
  -- "4nd3rs0n s1lv4"
  -- > betterEncodeName "Badtz Maru"
  -- "B4dtz M4r00"
betterEncodeName :: String -> String
betterEncodeName s = concatMap substituiVogal2 s

substituiVogal2 :: Char -> String
substituiVogal2 c | (c == 'a') || (c == 'A') = "4" | (c == 'e') || (c == 'E') = "3" | (c == 'i') || (c == 'I') = "1" | (c == 'o') || (c == 'O') = "0" | (c == 'u') || (c == 'U') = "00" | otherwise = [c]---------------------------------------------------------

---------------------------------------------------------
-- **12-Dada uma lista de strings, produzir outra lista com strings de 10 caracteres, usando o seguinte esquema: strings de entrada com mais de 10 caracteres são truncadas, strings com até 10 caracteres são completadas com '.' até ficarem com 10 caracteres. Exemplo:

  -- > func ["palavras","paralelas","pedal","paralelepipedo"]
  -- ["palavras..","paralelas.","pedal.....","paralelepi"]
  -- "B4dtz M4r0"
func :: [String] -> [String]
func s = map (\x -> if length x < 10 then x ++ replicate (10-length x) '.' else take 10 x) s
