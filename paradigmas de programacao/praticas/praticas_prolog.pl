% Exemplo de programa em Prolog que define
% fatos e regras sobre pessoas e localizacoes geograficas.

localizado_em(santa_maria, rs).
localizado_em(salvador, bahia).
localizado_em(rs, brasil).
localizado_em(bahia, brasil).
localizado_em(paris, franca).
localizado_em(franca, europa).

nasceu_em(andre, santa_maria).
nasceu_em(joao, salvador).
nasceu_em(X, Y) :- localizado_em(Z, Y), nasceu_em(X, Z).

mora_em(andre, paris).
mora_em(joao, salvador).
mora_em(joana, salvador).
mora_em(michel, paris).
mora_em(X, Y) :- localizado_em(Z, Y), mora_em(X, Z).

idade(andre, 25).
idade(joao, 32).
idade(joana, 22).
idade(michel, 40).

gaucho(X) :- nasceu_em(X, rs).
brasileiro(X) :- nasceu_em(X, brasil).
europeu(X) :- nasceu_em(X, europa).

% 1- Qual será o resultado das seguintes consultas?
% ?- europeu(andre). *R FALSE
% ?- gaucho(andre). *R TRUE
% ?- brasileiro(X). *R ANDRE JOAO

% 2- Expresse as seguintes afirmações em um ou mais fatos Prolog:
% "Joana nasceu em Salvador."
% "Joana tem 22 anos."
% "Michel nasceu em Paris e tem 40 anos."
 
% 3- Expresse as seguintes perguntas em consultas Prolog:
% "José nasceu no Brasil?" *r nasceu_em(jose, brasil).
% "Quais são as pessoas nascidas na Europa?" brasileiro(X)
% "Quais são as pessoas com mais de 30 anos?" idade(, 30).
% "Quem são os brasileiros com menos de 30 anos?"


% 4- Crie um predicado maisVelho(A,B) que permita deduzir se a pessoa A é mais velha que a pessoa B. Use o predicado idade. Exemplo de uso:
% ?- maisVelho(joao, andre).
% true.
maisVelho(A,B) :- idade(A, X), idade(B, Y), X>Y.

% 5- Em Prolog, o operador is serve para calcular uma expressão aritmética e atribuir seu valor a uma variável, como nos exemplos abaixo:
% soma(A,B,C) :- C is A + B. 
% pred(A,B,C) :- X is (A+B)^2, C is X*2+1.
% Sabendo disso, verifique qual será o resultado das consultas abaixo:
% ?- soma(8,5,S). s = 13
% ?- pred(3,2,X). x = 51
soma(A,B,C) :- C is A + B.
pred(A,B,C) :- X is (A+B)^2, C is X*2+1.

% 6- Usando o operador is, crie um predicado anoNasc(P,A) que permita deduzir o ano aproximado de nascimento (A) de uma pessoa (P). Use o predicado idade e o ano corrente como 
% referência. Exemplo de uso:
% ?- anoNasc(joao, A).
% A = 1986.
anoNasc(P, A) :- idade(P, X), A is 2018-X.

% 7- Em Prolog, listas são tipos de dados nativos. Como em Python, uma lista se representa com colchetes. Existem também vários predicados pré-definidos que manipulam listas. 
% Teste as consultas abaixo com os member, length e nextto:
% ?- member(a, [a,b,c]).
% ?- member(x, [a,b,c]).
% ?- member(A, [a,b,c]).
% ?- member(a, [a,b,c,a]).
% ?- length([a,b,c], L).
% ?- length([], X).
% ?- length(a, X).
% ?- length([a,b,c], 2).
% ?- nextto(1, 2, [1,2,3]).
% ?- nextto(2, Y, [1,2,3]).
% ?- nextto(4, X, [1,2,3]).
% ?- nextto(1, 2, [1,2,3,1,2]).

% 8- Usando lista em Prolog, crie um predicado isVowel(X) que verifique se um dado símbolo X é uma vogal. Dica: você vai precisar de uma lista de vogais possíveis. Exemplo de uso:
% ?- isVowel(a).
% true.
% ?- isVowel(b).
% false.
isVowel(X) :- X == 'a' or X == 'e'.

% 9- Defina um predicado ao_lado(X, Y, L) para determinar se X está imediatamente ao lado de Y na lista L. Neste caso, X pode estar imediatamente à esquerda OU à direita de Y. Você pode usar o predicado nextto.
ao_lado(X, Y, L) :-

% 10- Defina um predicado um_entre(X, Y, L) para determinar se os elementos X e Y da lista L estão separados por exatamente um elemento. Você pode usar o predicado nextto. Abaixo estão exemplos de consultas com o predicado um_entre:
% ?- um_entre(b,c,[a,b,c,d]).
% false.
% ?- um_entre(b,d,[a,b,c,d]).
% true .
% ?- um_entre(a,d,[a,b,c,d]).
% false.
um_entre(X, Y, L) :-

% 11-Veja aqui a descrição de um problema de lógica e sua resolução em Prolog. Estude o código da solução (o código usa os predicados nextto e ao_lado).
% Seguindo o exemplo anterior, resolva o problema de lógica descrito em http://rachacuca.com.br/logica/problemas/esquadrilha-de-avioes/. Nesse problema, há uma esquadrilha de 5 aviões em um show aéreo. Cada um deles solta fumaça de uma cor e possui uma anomalia diferente. Além disso, os aviões são comandados por cinco experientes pilotos que praticam um esporte cada um, além de preferirem uma bebida distinta. Sua tarefa é encontrar todas as informações a partir das seguintes dicas:
% O avião do Cel. Milton solta fumaça vermelha.
% O rádio transmissor do Ten. Walter está com problemas.
% O piloto do avião que solta fumaça verde adora pescar.
% O Major Rui joga futebol nos finais de semana.
% O avião que solta fumaça verde está imediatamente à direita do avião que solta fumaça branca.
% O piloto que bebe leite está com o altímetro desregulado.
% O piloto do avião que solta fumaça preta bebe cerveja.
% O praticante de natação pilota o avião que solta fumaça vermelha.
% O Cap. Farfarelli está na ponta esquerda da formação.
% O piloto que bebe café voa ao lado do avião que está com pane no sistema hidráulico.
% O piloto que bebe cerveja voa ao lado do piloto que enfrenta problemas na bússola.
% O homem que pratica equitação gosta de beber chá.
% O Cap. Nascimento bebe somente água.
% O Cap. Farfarelli voa ao lado do avião que solta fumaça azul.
% Na formação, há um avião entre o que tem problema hidráulico e o com pane no altímetro.
% Um dos pilotos joga tênis.
% Há um avião com problema de temperatura.
% Dica final: use o predicado um_entre criado em outro exercício.

% 12- Abaixo encontram-se 2 definições para um predicado que permite verificar se uma lista contém somente números maiores que zero. Você acha que uma das 
% implementações pode ser mais eficiente que a outra? Dica: busque informações sobre o predicado time do SWI-Prolog, que permite verificar a quantidade de 
% inferências realizadas numa dada consulta.
positivos1([],[]).
positivos1([H|T],L) :- H > 0, positivos1(T,Resto), L = [H|Resto].
positivos1([H|T],L) :- H =< 0, positivos1(T,L).

positivos2([],[]).
positivos2([H|T],L) :- H > 0, L = [H|Resto], positivos2(T,Resto).
positivos2([H|T],L) :- H =< 0, positivos2(T,L).

% 13- Abaixo encontram-se 2 definições para um predicado que permite encontrar o maior elemento em uma lista de inteiros. Você acha que uma das implementações 
% pode ser mais eficiente que a outra?
largest1([X],X).
largest1([X|Xs],X) :- largest1(Xs,Y), X>=Y.
largest1([X|Xs],N) :- largest1(Xs,N), N>X.

largest2([X|Xs], N) :- aux(Xs, X, N).
aux([], N, N).
aux([X|Xs], M, N) :-
   M1 is max(X, M),
   aux(Xs, M1, N).

% 14- Copie o código Prolog abaixo para um arquivo .pl. Este código define um predicado recursivo repete, que é verdadeiro se a lista L contém N repetições do símbolo C.
repete(0, _, []).
repete(N, C, L) :- 
 N > 0,
 L = [C | T],
 N1 is N - 1,
 repete(N1, C, T).
 
% Qual será o resultado das seguintes consultas?
% ?- repete(1,a,L).
% ?- repete(2,b,L).
% ?- repete(-2,b,L).
% ?- repete(2,a,[a,b,c]).
% ?- repete(3,a,[a|T]).

% 15- Defina um predicado zeroInit(L) que é verdadeiro se L for uma lista que inicia com o número 0 (zero). Exemplo de uso:
% ?- zeroInit([9,6,7]).
% false.
% ?- zeroInit([0,6,7]).
% true.
zeroInit([H|T]) :- H is 0.

% 16- Defina um predicado has5(L) que é verdadeiro se L for uma lista de 5 elementos. Resolva este exercício sem usar um predicado auxiliar.
has5(L) :- L = [_,_,_,_,_].

% 17- Defina um predicado hasN(L,N) que é verdadeiro se L for uma lista de N elementos.
hasN([], 0).
hasN(L,N) :- T = N, length(L,T).

% 18- Defina um predicado potN0(N,L), de forma que L seja uma lista de potências de 2, com expoentes de N a 0. Exemplo de uso:
% ?- potN0(7,L).
% L = [128, 64, 32, 16, 8, 4, 2, 1]
potN0(0, [1]).
potN0(N,L) :-
    N > 0,
    J is N - 1,
    H is 2^N, 
    L = [H | T],
    potN0(J,T).

% 19- Defina um predicado zipmult(L1,L2,L3), de forma que cada elemento da lista L3 seja o produto dos elementos de L1 e L2 na mesma posição do elemento de L3. Exemplo:
% ? zipmult([1,2,3],[2,2,2],L). 
% L = [2, 4, 6].
zipmult(_, [], 0). 
zipmult([], _, 0).
zipmult([H|T],[H1|T1],L3) :-
    G is H*H1,
    L3 = [G|J],
    zipmult(T,T1,J).

% 20- Defina um predicado potencias(N,L), de forma que L seja uma lista com as N primeiras potências de 2, sendo a primeira 2^0 e assim por diante, conforme o exemplo abaixo:
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

% 21- Defina um predicado positivos(L1,L2), de forma que L2 seja uma lista só com os elementos positivos de L1, conforme o exemplo abaixo:
% ?positivos([­-1,0,1,-­2,9],L). 
% L = [1, 9]
positivos([], []).
positivos([H|T], L) :- H > 0, positivos(T, Resto), L = [H|Resto].
positivos([H|T], L) :- H =< 0, positivos(T, L).

% 22- Considere que L1 e L2 sejam permutações de uma lista de elementos distintos, sem repetições. Sabendo disso, defina um predicado mesmaPosicao(A,L1,L2) para verificar 
% se um elemento A está na mesma posição nas listas L1 e L2. Exemplo de uso:
% ? mesmaPosicao(c,[a,b,c,d,e],[e,d,c,b,a]). 
% true
% ? mesmaPosicao(b,[a,b,c,d,e],[e,d,c,b,a]).
% false
mesmaPosicao(A,L1,L2) :- verificaPosicao(A, L1, P1), verificaPosicao(A, L2, P2), P1 is P2.

verificaPosicao(A, [A|_], 0).
verificaPosicao(A, [_|T], P) :-
    verificaPosicao(A, T, P3),
    P is P3+1.

% 23-Dada uma lista de N alunos, deseja-se escolher NP alunos (NP < N) para formar uma comissão. Para isso, defina um predicado comissao(NP,LP,C), que permita gerar 
% as possíveis combinações C com NP elementos da lista LP. Exemplo:
% ? comissao(3,[maria,jose,joao,mario],C). 
% C = [maria, jose, joao] ; 
% C = [maria, jose, mario] ; 
% C = [maria, joao, mario] ; 
% C = [jose, joao, mario] 
% ? comissao(0,[maria,jose,joao,mario],C).
% C = []
comissao(0,_,[]).
comissao(NP,[X|T],[X|C]) :- NP > 0, N1 is NP-1, comissao(N1,T,C).
comissao(NP,[_|T],C) :- NP > 0, comissao(NP,T,C).

% 24- (Adaptado de OBI2006-F1N1) Tem-se N azulejos 10cm x 10cm e, com eles, deve-se montar um conjunto de quadrados de modo a utilizar todos os azulejos dados, sem 
% sobrepô-los. Inicialmente, deve-se montar o maior quadrado possível; então, com os azulejos que sobraram, deve-se montar o maior quadrado possível, e assim 
% sucessivamente. Por exemplo, se forem dados 31 azulejos, o conjunto montado terá 4 quadrados. Para resolver este problema, você deverá definir um predicado 
% azulejos(NA, NQ), de forma que NQ seja o número de quadrados que se deve montar com NA azulejos. Dica: use os predicados sqrt e floor, pré-definidos em Prolog.
azulejos(0, 0).
azulejos(NA, NQ) :-
    RAIZ is sqrt(NA),
    INTDARAIZ is floor(RAIZ),
    RESULT is INTDARAIZ^2,
    NAMENOSRESULT is NA-RESULT,
    azulejos(NAMENOSRESULT, R),
    NQ is R+1.
    
% 25- Copie o código Prolog abaixo para um arquivo .pl.

b(2).
b(3).
c(4).
c(5).
regra1(X, Y) :- b(X), c(Y).
regra2(X, Y) :- b(X), !, c(Y).

% 26- Considerando o programa acima, qual será o resultado da seguinte consulta?
% ?- regra1(X,Y).
% Execute a consulta e verifique se sua resposta está correta. Obs: use ; para buscar todas as respostas possíveis.

% Ainda considerando o mesmo programa, qual será o resultado da seguinte consulta?

% ?- regra2(X,Y).
% Execute a consulta para verificar se sua resposta está correta, lembrando de usar ; para buscar todas as respostas possíveis.

% Ative o modo de rastreamento (trace) e re-execute as consultas acima. Observe a ocorrência de backtracking (Redo) nos 2 casos.

% 27- Baixe o programa fatoriais.pl e carregue-o no SWI-Prolog.

fatv1(0,1).
fatv1(N,X) :- 
	N1 is N - 1,
	fatv1(N1, X1),
	X is N*X1.

fatv2(0,1).
fatv2(N,X) :- 
	N1 is N - 1,
	fatv2(N1, X1),
	X is N*X1, !.


fatv3(0,1).
fatv3(A,B) :-  
	A > 0, 
        C is A-1,
        fatv3(C,D),
        B is A*D. 
        
% Execute a consulta abaixo e use ; para verificar se há outras respostas possíveis.
% ?- fatv1(3,N).
% A consulta acima deve ter gerado um erro depois que for digitado ;. Você consegue identificar o motivo deste erro?

% Para melhor entender o erro acima, ative o modo trace e re-execute a consulta:
% ?- trace.
% true.
% [trace]  ?- fatv1(3,N).
% Dica: quando você cansar de rastrear a execução passo-a-passo, digite a (abort) no lugar de Enter.

% Analise o código em fatoriais.pl, comparando os predicados fatv2 e fatv3 com o predicado fatv1.

% Execute as consultas abaixo, digitando ; após cada resposta. Compare os resultados com os da consulta anterior (fatv1).
% ?- fatv2(3,N).
% ?- fatv3(3,N).
% Ative o modo trace e re-execute as consultas acima, acompanhando suas execuções.
% Você consegue identificar alguma vantagem de fatv2 sobre fatv3?
