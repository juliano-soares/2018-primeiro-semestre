# -*- coding: utf-8 -*-
"""
Created on Sun Mar 18 15:17:50 2018

@author: Juliano Leonardo Soares
"""

"""
1-Crie uma função isVowel :: Char -> Bool que verifique se um caracter é uma vogal ou não.
"""
def vogal(z):
    vogais = ['a', 'e', 'i', 'o', 'u','A','E','I','O','U'];
    return z.lower() in vogais;

"""
2-Escreva uma função addComma, que adicione uma vírgula no final de cada string contida numa lista.
"""
def addComma(lista): return list(map(lambda string: string +",", lista));
    
"""
3-Crie uma função htmlListItems :: [String] -> [String], que receba uma lista de strings e 
retorne outra lista contendo as strings formatadas como itens de lista em HTML. Resolva este 
exercício COM e SEM funções anônimas (lambda). Exemplo de uso da função:

> htmlListItems ["abra", "ca", "dabra"]
["<LI>abra</LI>", "<LI>ca</LI>", "<LI>dabra</LI>"]
"""
def htmlListItems(strings): return list(map(lambda string: "<h1>"+string+"</h1>", strings));

#sem lambda
def aux_html(x):return "<h1>"+ x +"</h1>";
    
def htmlListItems_2(strings): return map(aux_html, strings);
"""
4-Defina uma função que receba uma string e produza outra retirando as vogais, conforme 
os exemplos abaixo. Resolva este exercício COM e SEM funções anônimas (lambda).

> semVogais "andrea"
"ndr"
> semVogais "xyz"
"xyz"
> semVogais "ae"
""
"""
# sem lambda
def semVogais(palavra): return ''.join([vogais for vogais in palavra if not vogais in 'aeiouAEIOU']);

#com lambda
def semVogais_2(palavra): 
    return filter(lambda x: x!='a' and x!='e' and x!='i' and x!='o'and x!='u'
                    and x!='A' and x!='E' and x!='I' and x!='O' and x!='U', palavra);
"""
5-Defina uma função que receba uma string, possivelmente contendo espaços, e que retorne 
outra string substituindo os demais caracteres por '-', mas mantendo os espaços. Resolva 
este exercício COM e SEM funções anônimas (lambda). Exemplos:

> codifica "Rio Grande do Sul"
"--- ------ -- ---"
> codifica ""
""
"""
def codifica(string): return ''.join([letra if letra==" " else "-" for letra in string if letra]);
    
"""
6-Escreva uma função firstName :: String -> String que, dado o nome completo de uma pessoa, 
obtenha seu primeiro nome. Suponha que cada parte do nome seja separada por um espaço e 
que não existam espaços no início ou fim do nome. Dica: estude funções pré-definidas em 
Haskell (List operations -> Sublists) em 
http://hackage.haskell.org/package/base-4.10.1.0/docs/Prelude.html#g:18. Exemplos de uso da função:

> firstName "Anderson Silva"
"Anderson"
> firstName "JON BON JOVI"
"JON"
"""
def firstName(string): 
    nome = string.split ();
    return nome[0];
"""
7-Escreva uma função isInt :: String -> Bool que verifique se uma dada string só contém 
dígitos de 0 a 9. Exemplos:

> isInt "901"
True
> isInt "2014a"
False
"""
def isInt(string): return string.isdigit();
    
"""
8-Escreva uma função lastName :: String -> String que, dado o nome completo de uma pessoa, 
obtenha seu último sobrenome. Suponha que cada parte do nome seja separada por um espaço e 
que não existam espaços no início ou fim do nome. Exemplos de uso da função:

> lastName "Anderson Silva"
"Silva"
> lastName "JON BON JOVI"
"JOVI"
"""
def lastName(string): 
    nome = string.split();
    return nome[-1];
"""
9-Escreva uma função userName :: String -> String que, dado o nome completo de uma pessoa, 
crie um nome de usuário (login) da pessoa, formado por: primeira letra do nome seguida do 
sobrenome, tudo em minúsculas. Dica: estude as funções pré-definidas no módulo Data.Char, 
para manipulação de maiúsculas e minúsculas. Você precisará carregar este módulo usando import 
Data.Char no interpretador ou no início do arquivo do programa.

Exemplos de uso da função:

> userName "Anderson Silva"
"asilva"
> userName "JON BON JOVI"
"jjovi"
"""
def userName(string): 
    nome = string.split();
    return string[0] +nome[-1];
"""
10-Escreva uma função encodeName :: String -> String que substitua vogais em uma string, 
conforme o esquema a seguir: a = 4, e = 3, i = 2, o = 1, u = 0.

Exemplos de uso da função:

> encodeName "Anderson Silva"
"4nd3rs1n s2lv4"
> encodeName "Badtz Maru"
"B4dtz M4r0"
"""

def encodeName(string):
    string = string.replace("a","4") or string.replace("A","4");
    string = string.replace("e","3") or string.replace("E","3");
    string = string.replace("i","2") or string.replace("I","2");
    string = string.replace("o","1") or string.replace("O","1");
    string = string.replace("u","0") or string.replace("U","0");
    return string;
"""
11-Escreva uma função betterEncodeName :: String -> String que substitua vogais em uma string, 
conforme este esquema: a = 4, e = 3, i = 1, o = 0, u = 00. Exemplos de uso da função:

> betterEncodeName "Anderson Silva"
"4nd3rs0n s1lv4"
> betterEncodeName "Badtz Maru"
"B4dtz M4r00"
"""
def betterEncodeName(string):
    string = string.replace("a","4") or string.replace("A","4");
    string = string.replace("e","3") or string.replace("E","3");
    string = string.replace("i","1") or string.replace("I","1");
    string = string.replace("o","0") or string.replace("O","0");
    string = string.replace("u","00") or string.replace("U","00");
    return string;
"""
12-Dada uma lista de strings, produzir outra lista com strings de 10 caracteres, usando o 
seguinte esquema: strings de entrada com mais de 10 caracteres são truncadas, strings com 
até 10 caracteres são completadas com '.' até ficarem com 10 caracteres. Exemplo:

> func ["palavras","paralelas","pedal","paralelepipedo"]
["palavras..","paralelas.","pedal.....","paralelepi"]
"""
def aux(string):
    n = len(string);
    if (n < 10): 
        string = string +("," * (10 - n));
    else:
        string = string[0:10];
    return string;
    
          
def func(lista): return map(aux, lista);
                                        
