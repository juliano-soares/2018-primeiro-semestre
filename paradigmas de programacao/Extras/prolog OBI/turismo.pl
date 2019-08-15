/*
 https://olimpiada.ic.unicamp.br/static/extras/obi2014/provas/ProvaOBI2014_f2i1.pdf
 
                        Turismo
João ganhou um prêmio e vai poder realizar o sonho de conhecer melhor o Brasil. Ele vai visitar seis capitais –
Aracaju, Belém, Curitiba, Goiânia, Manaus e Salvador – não necessariamente nessa ordem. A ordem da visita
deve seguir as seguintes restrições:
• Ou Salvador é visitada depois de Goiânia ou é visitada antes de Curitiba, mas não ambas.
• João visita Belém depois de Aracaju mas antes de Goiânia.
• Se João visita Salvador depois de Aracaju, então ele visita Curitiba depois de Manaus.
• Belém é visitada depois de Curitiba.
Questão 22. Qual das seguintes poderia ser a ordem
em que as cidades são visitadas, da primeira para a
última?
(A) Salvador, Aracaju, Curitiba, Belém, Manaus,
Goiânia
(B) Manaus, Curitiba, Aracaju, Belém. Salvador,
Goiânia
(C) Curitiba, Aracaju, Manaus, Belém, Goiânia,
Salvador
(D) Salvador, Aracaju, Goiânia, Curitiba, Belém,
Manaus
(E) Salvador, Aracaju, Belém, Goiânia, Curitiba,
Manaus

turismo([salvador,aracaju,curitiba,belem,manaus,goiania]).
turismo([manaus,curitiba,aracaju,belem,salvador,goiania]).
turismo([curitiba,aracaju,manaus,belem,goiania,salvador]).
turismo([salvador,aracaju,goiania,curitiba,belem,manaus]).
turismo([salvador,aracaju,belem,goiania,curitiba,manaus]).
*/

regra1(L) :-
        nth0(A,L,salvador),
        nth0(B,L,goiania),
        nth0(C,L,curitiba),
        A > B, A>C; 
        nth0(A,L,salvador),
        nth0(B,L,goiania),
        nth0(C,L,curitiba),
        A < C, A < B.
        
regra2(L) :-
        nth0(A,L,belem),
        nth0(B,L,aracaju),
        nth0(C,L,goiania),
        A > B, A < C.
        
regra3(L) :-
        nth0(A,L,salvador),
        nth0(B,L,belem),
        A>B,
        nth0(C,L,salvador),
        nth0(D,L,belem),
        C>D;
        nth0(A,L,salvador),
        nth0(B,L,belem),
        A<B.
        
regra4(L) :-
        nth0(A,L,belem),
        nth0(B,L,curitiba),
        A>B.
     
        
turismo(L) :-
        regra1(L),
        regra2(L),
        regra3(L),
        regra4(L).
