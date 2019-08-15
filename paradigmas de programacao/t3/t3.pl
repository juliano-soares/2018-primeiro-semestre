% 1 - exercício: Defina um predicado zeroInit(L) que é 
%verdadeiro se L for uma lista que inicia com o número 0 (zero). 
%Exemplo de uso:
%?- zeroInit([9,6,7]).
%false.
%?- zeroInit([0,6,7]).
%true.

zeroInit([H|T]) :- H is 0. 

% 2 - exercício: Defina um predicado has5(L) que é verdadeiro 
se L for uma lista de 5 elementos. Resolva este exercício sem 
usar um predicado auxiliar.

has5(L) :- L = [_,_,_,_,_].

% 3 - exercício: Defina um predicado hasN(L,N) que é 
%verdadeiro se L for uma lista de N elementos.
 
hasN([], 0).
hasN(L,N) :- T = N, length(L,T). 
 
% 4 - exercício: Defina um predicado potN0(N,L), 
%de forma que L seja uma lista de potências de 2, 
%com expoentes de N a 0. Exemplo de uso:
%?- potN0(7,L).
%L = [128, 64, 32, 16, 8, 4, 2, 1]
potN0(0, [1]).
potN0(N,L) :-
    N > 0,
    J is N - 1,
    H is 2^N, 
    L = [H | T],
    potN0(J,T).
    
     
% 5 - exercício: Defina um predicado zipmult(L1,L2,L3), de forma 
%que cada elemento da lista L3 seja o produto dos 
%elementos de L1 e L2 na mesma posição do elemento de L3.
%?zipmult([1,2,3],[2,2,2],L). 
%L = [2, 4, 6].
 
zipmult(_, [], 0). 
zipmult([], _, 0).
zipmult([H|T],[H1|T1],L3) :-
    G is H*H1,
    L3 = [G|J],
    zipmult(T,T1,J).
    
    
% 6 - exercício: Defina um predicado potencias(N,L), de forma que L 
%seja uma lista com as N primeiras potências de 2, sendo a primeira 
%2^0 e assim por diante, conforme o exemplo abaixo:
%? potencias(5,L). 
%L = [1, 2, 4, 8, 16]
%? potencias(0,L).
%L = []
%Dica: defina um predicado auxiliar.

potencias(N,L) :- aux(0, N, L).
aux(MAX, MAX, []).
aux(MIN, MAX, L) :- 
    MIN < MAX,
    G is MIN+1,
    H is 2^MIN,
    L = [G|L2],
    aux(G, MAX, L2).
    
    
% 7 - exercício: Defina um predicado positivos(L1,L2), de forma que 
%L2 seja uma lista só com os elementos positivos de L1, conforme o 
%exemplo abaixo:
%? positivos([-1,0,1,-2,9],L). 
%L = [1, 9]

positivos([], []).
positivos([H|T], L) :- H > 0, positivos(T, Resto), L = [H|Resto].
positivos([H|T], L) :- H =< 0, positivos(T, L).

% 8 - exercício: Considere que L1 e L2 sejam permutações de uma lista 
%de elementos distintos, sem repetições. Sabendo disso, defina um predicado 
%mesmaPosicao(A,L1,L2) para verificar se um elemento A está na mesma 
%posição nas listas L1 e L2. Exemplo de uso:
%? mesmaPosicao(c,[a,b,c,d,e],[e,d,c,b,a]). 
%true
%? mesmaPosicao(b,[a,b,c,d,e],[e,d,c,b,a]).
%false

mesmaPosicao(A,L1,L2) :- verificaPosicao(A, L1, P1), verificaPosicao(A, L2, P2), P1 is P2.

verificaPosicao(A, [A|_], 0).
verificaPosicao(A, [_|T], P) :-
    verificaPosicao(A, T, P3),
    P is P3+1.
    
% 9 - exercício: Dada uma lista de N alunos, deseja-se escolher NP 
%alunos (NP < N) para formar uma comissão. Para isso, defina um predicado 
%comissao(NP,LP,C), que permita gerar as possíveis combinações C com NP 
%elementos da lista LP. Exemplo:
%? comissao(3,[maria,jose,joao,mario],C). 
%C = [maria, jose, joao] ; 
%C = [maria, jose, mario] ; 
%C = [maria, joao, mario] ; 
%C = [jose, joao, mario] 
%? comissao(0,[maria,jose,joao,mario],C).
%C = []

% Eu não vou mentir eu vi como fazer na internet 
% Portanto vou explicar passo a passo o que entendi
% neste primeiro se pede combinação de zero elemento retorna uma lista vazia
comissao(0,_,[]).
% neste se o head das lista forem iguais chama o proximo para verificar se é igual ou não e torna o np um valor a menos
comissao(NP,[X|T],[X|C]) :- NP > 0, N1 is NP-1, comissao(N1,T,C).
% nesta se não forem iguais adiciona o elemento na combinação C enquanto NP > 0
comissao(NP,[_|T],C) :- NP > 0, comissao(NP,T,C).

% 10 - exercício: (Adaptado de OBI2006-F1N1) Tem-se N azulejos 10cm x 10cm e, 
%com eles, deve-se montar um conjunto de quadrados de modo a utilizar todos os 
%azulejos dados, sem sobrepô-los. Inicialmente, deve-se montar o maior quadrado 
%possível; então, com os azulejos que sobraram, deve-se montar o maior quadrado 
%possível, e assim sucessivamente. Por exemplo, se forem dados 31 azulejos, o 
%conjunto montado terá 4 quadrados. Para resolver este problema, você deverá definir 
%um predicado azulejos(NA, NQ), de forma que NQ seja o número de quadrados que se 
%deve montar com NA azulejos. Dica: use os predicados sqrt e floor, pré-definidos em Prolog.

% OBS : visto como fazer as raizes e encontrar o maior quadrado na internet 
azulejos(0, 0).
azulejos(NA, NQ) :-
    RAIZ is sqrt(NA),
    INTDARAIZ is floor(RAIZ),
    RESULT is INTDARAIZ^2,
    NAMENOSRESULT is NA-RESULT,
    azulejos(NAMENOSRESULT, R),
    NQ is R+1.
    
