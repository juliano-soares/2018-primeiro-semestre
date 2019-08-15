/*
                Móbile
O móbile na sala da Maria é composto de três hastes exatamente como na figura abaixo. Para que
ele esteja completamente equilibrado, com todas as hastes na horizontal, os pesos das quatro bolas
A, B, C e D têm que satisfazer todas as seguintes três condições:
1. A = B + C + D; e
2. B + C = D; e
3. B = C.

Nesta tarefa, dados os pesos das quatro bolas, seu programa deve decidir se o móbile está ou não
completamente equilibrado.
Entrada
A entrada consiste de quatro linhas contendo, cada uma, um número inteiro, indicando os pesos
das bolas. Os números são dados na ordem: A, B, C e D.
Saída
Seu programa deve escrever uma única linha na saída, contendo o caractere “S” se o móbile estiver
equilibrado, ou o caractere “N” se não estiver equilibrado.

ENTRADAS MODIFICADAS PARA PROLOG:
mobile([12,3,3,6]). true
mobile([2002,560,560,882]). false
*/
regra1([A,B,C,D]) :-
        A =:= B + C + D. 

regra2([_,B,C,D]) :-
        D =:= B + C.

regra3([_,B,C,_]) :-
        B =:= C.
    
mobile(S) :-
    regra1(S),
    regra2(S),
    regra3(S).
