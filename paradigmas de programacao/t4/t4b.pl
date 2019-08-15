/*
    nome: Juliano Leonardo Soares
    
    Paradigmas de Programação - UFSM
    Resolvendo problemas da OBI em Prolog
    
    Problema:escola colorida (https://olimpiada.ic.unicamp.br/static/extras/obi2010/provas/ProvaOBI2010_f1i1.pdf)
                    Escola colorida
    Uma escola ocupa um prédio com seis andares, numerados
    de 1 a 6 (1 é o andar mais baixo, 6 o mais alto).
    Os alunos e professores decidiram em conjunto que
    cada andar será pintado com uma cor diferente, entre
    amarelo, branco, rosa, azul, laranja e verde. Ficou
    também decidido que as seguintes condições devem ser
    obedecidas:
*/

% Branco deve ser usado para pintar ou o andar 3 ou o andar 4
regra1(CA) :- nth0(P, CA, branco), P =:= 2; nth0(P, CA, branco), P =:= 3.

% O andar pintado de laranja é mais baixo do que o andar pintado de rosa.
regra2(CA) :- 
    nth0(P, CA, laranja),
    nth0(P1, CA, rosa),
    P < P1.

% O andar pintado de azul é mais baixo do que o andar pintado de laranja, mas mais alto do que o andar pintado de amarelo.
regra3(CA) :-
    nth0(P, CA, azul),
    nth0(P1, CA, laranja),
    nth0(P2, CA, amarelo),
    P < P1 , P > P2.
    
% permutacoes
perm(List, [H|Perm]) :- delete(H, List, Rest), perm(Rest, Perm).
perm([],[]).

delete(X, [X|T], T).
delete(X, [H|T], [H|NT]) :- delete(X, T, NT).

escolacolorida(CA) :-
   CA = [_,_,_,_,_,_],
   Cores = [amarelo, branco, rosa, azul, laranja, verde],
   perm(Cores, CA),
   regra1(CA),
   regra2(CA),
   regra3(CA).
/*   
Quest˜ao 16. Qual das alternativas abaixo ´e uma lista
correta de cores para os andares da escola, do andar 1
ao andar 6?
(A) amarelo, azul, branco, verde, laranja, rosa.
(B) amarelo, azul, laranja, rosa, branco, verde.
(C) amarelo, laranja, branco, azul, rosa, verde.
(D) azul, amarelo, laranja, branco, rosa, verde.
(E) verde, amarelo, rosa, branco, azul, laranja. 

?- escolacolorida([amarelo, azul, branco, verde, laranja, rosa]).
?- escolacolorida([amarelo, azul, laranja, rosa, branco, verde]).
?- escolacolorida([amarelo, laranja, branco, azul, rosa ,verde]).
?- escolacolorida([azul, amarelo, laranja, branco, rosa, verde]).
?- escolacolorida([verde, amarelo, rosa, branco, azul, laranja]).

correta: (A).
*/

/*Quest˜ao 17. Qual das seguintes cores pode ser usada
para pintar qualquer um dos seis andares?
(A) amarelo
(B) rosa
(C) azul
(D) laranja
(E) verde

?- escolacolorida([_, _, _, _, _, amarelo]). false
?- escolacolorida([_, _, _, _, _, rosa]). true
?- escolacolorida([_, _, _, _, _, azul]). false
?- escolacolorida([_, _, _, _, _, laranja]). false 
?- escolacolorida([_, _, _, _, _, verde]). true para todos

escolacolorida([_, _, _, _, rosa, _]).  true
escolacolorida([_, _, _, rosa, __, _]). false

correta: (E)
*/

/*
Questão 18. Qual das seguintes cores NAO PODE ˜
ser usada para pintar o andar 3?
(A) amarelo
(B) branco
(C) azul
(D) laranja
(E) verde

?- escolacolorida([_, _, amarelo, _, _, _]). false
?- escolacolorida([_, _, branco, _, _, _]).
?- escolacolorida([_, _, azul, _, _, _]).
?- escolacolorida([_, _, laranja, _, _, _]).
?- escolacolorida([_, _, verde, _, _, _]).

correta: (A)
*/

/*
Questão 19. Se o andar 5 não é pintado de laranja,
qual das seguintes afirmativas é necessariamente verdadeira?
(A) O andar 6 e pintado de rosa.
(B) O andar 5 é pintado de verde.
(C) O ander 4 é pintado de branco.
(D) O andar 3 é pintado de laranja.
(E) O andar 2 é pintado de azul.


escolacolorida([laranja, _, _, _, _, _]). false
escolacolorida([_, laranja, _, _, _, _]). false
escolacolorida([_, _, _, _, _, laranja]). false

escolacolorida([A, B, laranja, C, D, F]). true
A = amarelo,
B = azul,
C = branco,
D = rosa,
F = verde 
A = amarelo,
B = azul,
C = branco,
D = verde,
F = rosa

escolacolorida([A, B, C, laranja, D, F]).
A = amarelo,
B = azul,
C = branco,
D = rosa,
F = verde

correto: (E)
*/

/*Quest˜ao 20. Se o andar 3 ´e pintado de laranja, qual
´e o andar mais baixo que pode ser pintado de verde?
(A) 6
(B) 5
(C) 4
(D) 2
(E) 1
questão respondida no teste anterior 
correta: (B) 5
*/
