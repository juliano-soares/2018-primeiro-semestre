/*
                    Formatura
A Comissão de Formatura da escola está escolhendo o orador da turma na cerimônia de formatura. Ficou
decidido que neste ano uma menina seria a oradora da turma. Exatamente sete alunas – Fernanda, Guta,
Hortênsia, Iara, Júlia, Kátia e Lia – foram selecionadas para uma entrevista. Cada aluna será entrevistada
exatamente uma vez, de acordo com as seguintes restrições:
• Iara será a primeira ou a última entrevistada.
• Ou Guta ou Júlia deve ser a quarta entrevistada.
• Hortênsia é entrevistada imediatamente antes de Lia.
• Guta é entrevistada em algum momento antes de Kátia.
• Júlia não é entrevistada imediatamente antes ou imediatamente após Kátia.
Questão 24. Qual das seguintes poderia ser uma lista
completa e correta da ordem em que as estudantes são
entrevistadas, da primeira à última?
(A) Hortênsia, Lia, Kátia, Guta, Fernanda, Júlia,
Iara
(B) Iara, Fernanda, Guta, Júlia, Kátia, Hortênsia,
Lia
(C) Iara, Hortênsia, Lia, Guta, Júlia, Fernanda, Ká-
tia
(D) Iara, Hortênsia, Guta, Júlia, Fernanda, Kátia,
Lia
(E) Guta, Hortênsia, Lia, Júlia, Iara, Kátia, Fernanda

formatura([hortencia,lia,katia,guta,fernanda,julia,iara]).
formatura([iara,fernanda,guta,julia,katia,hortensia,lia]).
formatura([iara,hortencia,lia,guta,julia,fernanda,katia]).
formatura([iara,hortencia,guta,julia,fernanda,katia,lia]).
formatura([guta,hortencia,lia,julia,iara,katia,fernanda]).
*/

regra1(L) :-
        nth0(0,L,iara);
        last(L,iara).
        
regra2(L) :-
        nth0(3,L,guta);
        nth0(3,L,julia).
        
regra3(L) :-
        nextto(hortencia,lia,L).
        
regra4(L) :-
        nth0(A,L,guta),
        nth0(B,L,katia),
        A<B.
        
regra5(L) :-
        nextto(julia,katia,L);
        nextto(katia,julia,L).
        
formatura(L) :-
        regra1(L),
        regra2(L),
        regra3(L),
        regra4(L),
        not(regra5(L)).
        
