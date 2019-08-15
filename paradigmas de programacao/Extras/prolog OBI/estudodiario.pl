/*                
                Estudo diário
Bia decidiu que na semana que vem vai estudar todas as noites, iniciando no domingo e terminando no sábado.
Ela quer fazer a programação do que estudar em cada um dos dias, entre matemática, física, química, artes,
música, história e geografia, obedecendo às seguintes restrições:
• Ela deve estudar matemática ou na noite anterior ou na noite seguinte em que ela estudar música.
• Ela deve estudar física ou na noite anterior ou na noite seguinte em que ela estudar ou artes ou história.
• Ela não pode estudar geografia na noite anterior ou na noite seguinte em que ela estudar química.
• Ela deve estudar química na segunda-feira.

Questão 19. Qual das seguintes alternativas é uma
sequência de matérias, de domingo até sábado?
(A) Matemática, música, física, história, geografia,
artes, química
(B) Física, artes, matemática, música, química, história,
geografia
(C) Música, química, matemática, geografia, artes,
física, história
(D) História, química, física, artes, geografia, matemática,
música
(E) História, química, geografia, artes, física, matemática,
música

estudodiario([matematica,musica,fisica,historia,geografia,artes,quimica]).
estudodiario([fisica,artes,matematica,musica,quimica,historia,geografia]).
estudodiario([musica,quimica,matematica,geografia,artes,fisica,historia]).
estudodiario([historia,quimica,fisica,artes,geografia,matematica,musica]).
estudodiario([historia,quimica,geografia,artes,fisica,matematica,musica]).

*/

regra1(L) :-
       nextto(matematica,musica,L);
       nextto(musica,matematica,L).
       
regra2(L) :-
       nextto(fisica,historia,L);
       nextto(historia,fisica,L);
       nextto(fisica,artes,L);
       nextto(artes,fisica,L).
       
regra3(L) :-
       nextto(geografia,quimica,L);
       nextto(quimica,geografia,L).
       
regra4(L) :-
        nth0(1,L,quimica).

estudodiario(L):-
        regra1(L),
        regra2(L),
        not(regra3(L)),
        regra4(L).
