/*
https://olimpiada.ic.unicamp.br/static/extras/obi2014/provas/ProvaOBI2014_f1i1.pdf

                    Programas de Computador
Um computador é utilizado para executar cinco programas: planilha eletrônica, navegador internet,
editor de texto, tocador de MP3 e gravador de CD. Devido a como os recursos do computador
(processador, memória, discos) são usados por cada programa, o computador somente pode executar
os programas obedecendo às seguintes restrições:
• O computador não pode executar a planilha e o editor ao mesmo tempo.
• O computador não pode executar a planilha e o gravador ao mesmo tempo.
• Quando o computador executa o tocador MP3, não pode executar qualquer dos seguintes
programas ao mesmo tempo: a planilha, o editor ou o gravador.
*/

regra1(L) :-
    member(planilha, L), 
    member(editor, L).
    
regra2(L) :-
    member(planilha, L), 
    member(gravador, L).

regra3(L) :-
    member(tocador, L), 
    member(gravador, L);
    member(tocador, L),
    member(editor, L);
    member(tocador, L),
    member(planilha, L).
    
progcomputador(L) :-
    not(regra1(L)),
    not(regra2(L)),
    not(regra3(L)).

/*
Questão 16. Qual das seguintes alternativas é
um par de programas que o computador pode
executar ao mesmo tempo?
(A) planilha e editor
(B) planilha e gravador
(C) editor e gravador
(D) editor e tocador MP3
(E) gravador e tocador MP3
progcomputador([planilha, editor]).
progcomputador([planilha, gravador]).
progcomputador([editor, gravador]).
progcomputador([editor, tocador]).
progcomputador([gravador, tocador]).
*/
