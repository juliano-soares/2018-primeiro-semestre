/*
nome: Juliano Leonardo Soares

Uma banda formada por alunos e alunas da escola est´a gravando um CD com exatamente sete m´usicas
distintas – S, T, V, W, X, Y e Z. Cada m´usica ocupa exatamente uma das sete faixas contidas no
CD. Algumas das m´usicas s˜ao sucessos antigos de rock; outras s˜ao composi¸c˜oes da pr´opria banda. As
seguintes restri¸c˜oes devem ser obedecidas:
 S ocupa a quarta faixa do CD.
 Tanto W como Y precedem S no CD (ou seja, W e Y est˜ao numa faixa que ´e tocada antes de S
no CD).
 T precede W no CD (ou seja, T est´a numa faixa que ´e tocada antes de W).
 Um sucesso de rock ocupa a sexta faixa do CD.
 Cada sucesso de rock ´e imediatamente precedido no CD por uma composi¸c˜ao da banda (ou seja,
no CD cada sucesso de rock toca imediatamente ap´os uma composi¸c˜ao da banda).
 Z ´e um sucesso de rock.
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S ocupa a quarta faixa do CD.
% sete musicas 4° posição
% CD = faixas do cd
% s = musica
regra1(CD) :- CD = [_,_,_,s,_,_,_].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tanto W como Y precedem S no CD (ou seja, W e Y estão numa faixa que é tocada antes de S no CD)
% pego posição de y, w e s e verifico se a posição de y e w são menores que a posição de s
regra2(CD) :-
    nth0(P1, CD, y),
    nth0(P2, CD, w),
    nth0(P3, CD, s),
    P1 < P3 , P2 < P3.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% T precede W no CD (ou seja, T estão numa faixa que é tocada antes de W).
% pego posição de t e w e verifico se a posição de t é menor que a posição de w
regra3(CD) :-
    nth0(P1, CD, t),
    nth0(P2, CD, w),
    P1 < P2.
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Um sucesso de rock ocupa a sexta faixa do CD.
% como sei que z ja é um sucesso de rock
% pego o sucesso e vejo se esta na 5° posição
regra4(CD) :-
    regra6(X, sucessorock),
    nth0(5, CD, X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cada sucesso de rock é imediatamente precedido no CD por uma composição da banda (ou seja,
% no CD cada sucesso de rock toca imediatamente após uma composição da banda).
% como a sexta posição deve ser um sucesso a 5° e a 7° são composições da banda e sucessiva mente pode-se 
% determinar as outras posições
% 1° composições da banda
% 2° sucesso
% 3° composições da banda
% 4° sucesso               * ja deduzimos que s é um sucesso
% 5° composições da banda  * segundo a regra5   
% 6° sucesso               * segundo a regra4 quatro
% 7° composições da banda  * segundo a regra5
regra5(CD) :- 
   regra6(X, sucessorock),
   regra6(Y, compBanda),
   nextto(Y, X, CD).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Z é um sucesso de rock
% não é uma regra e sim uma afirmação
regra6(z, sucessorock).
regra6(_, compBanda).    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% permutacoes
perm(List, [H|Perm]) :- delete(H, List, Rest), perm(Rest, Perm).
perm([],[]).

delete(X, [X|T], T).
delete(X, [H|T], [H|NT]) :- delete(X, T, NT).

cdindependente(CD) :-
    cd = [_,_,_,_,_,_,_],
    Musicas = [s,t,v,w,x,y,z], 
    perm(Musicas, CD),
    regra1(CD),
    regra2(CD),
    regra3(CD),
    regra4(CD),
    regra5(CD).
/*Questão 11. Qual das seguintes alternativas poderia
ser a ordem das músicas no CD, da primeira
para a sétima faixa?
(A) T, W, V, S, Y, X, Z
(B) V, Y, T, S, W, Z, X
(C) X, Y, W, S, T, Z, S
(D) Y, T, W, S, X, Z, V
(E) Z, T, X, W, V, Y, S    
    
 ? - cdindependente([t,w,v,s,y,x,z]).
 ? - cdindependente([v,y,t,s,w,z,x]).
 ? - cdindependente([x,y,w,s,t,z,s]).
 ? - cdindependente([y,t,w,s,x,z,v]).
 ? - cdindependente([z,t,x,w,v,y,s]).
 Correta: Letra D
*/    
