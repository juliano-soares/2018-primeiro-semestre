/*
https://olimpiada.ic.unicamp.br/static/extras/obi2014/provas/ProvaOBI2014_f1i1.pdf

                    Revezamento
Oito alunos – Beto, Dulce, Guto, Júlia, Kelly, Neto, Silvia e Vivian decidiram tentar quebrar o recorde
da tradicional prova de revezamento e resistência de natação que acontece todos os anos na escola.
Nessa prova, cada um dos oito competidores da equipe deve nadar mil metros, em estilo livre, na
forma de revezamento: cada nadador cai na piscina para nadar apenas uma vez, um de cada vez. O
objetivo é que todos nadem no menor tempo possível. Depois de muita discussão, os competidores
decidiram que a ordem em que cairão na piscina deve obedecer às seguintes condições:
• Silvia não nada por último.
• Vivian nada após Júlia e Neto nadarem.
• O primeiro a nadar é ou Beto ou Dulce.
• Guto nada antes de Júlia, com exatamente uma pessoa nadando entre eles.
• Kelly nada antes de Neto, com exatamente duas pessoas nadando entre eles.

revezamento([dulce,kelly,silvia,guto,neto,beto,julia,vivian]).
revezamento([dulce,silvia,kelly,guto,neto,julia,beto,vivian]).
revezamento([beto,kelly,silvia,guto,neto,julia,vivian,dulce]).
revezamento([beto,guto,kelly,julia,dulce,neto,vivian,silvia]).
revezamento([beto,silvia,dulce,kelly,vivian,guto,neto,julia]).
*/

regra1(L) :-
    last(L,silvia).
    
regra2(L) :-
    nth0(A,L,vivian),
    nth0(B,L,julia),
    nth0(C,L,neto),
    A > B, A > C.
    
regra3(L) :- 
    nth0(0,L,beto); nth0(0,L,dulce). 
   
    
regra4(L) :-
    nth0(A,L,guto),
    nth0(B,L,julia),
    A < B, B-A =:= 2.
    
regra5(L) :-
    nth0(A,L,kelly),
    nth0(B,L,neto),
    A < B, B-A =:= 3.
    
revezamento(L) :-
    not(regra1(L)),
    regra2(L),
    regra3(L),
    regra4(L),
    regra5(L).
