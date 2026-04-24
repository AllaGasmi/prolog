% ============================================================
% OPTIMIZATION — Milestone 3
% Multi-critères : E_total, Imbalance, Variance salles
% ============================================================
:- consult(knowledge_base).
:- consult(energy).

% ============================================================
% MÉTRIQUE 3 : Variance d utilisation des salles
% Var(R) = " (1/m) * Σ (Usage(rj) - μ)² "
% ============================================================
room_usage(Room, Schedule, Usage) :-
    findall(_, member(session(_, Room, _), Schedule), Sessions),
    length(Sessions, Usage).

all_room_usages(Schedule, Usages) :-
    findall(U, (
        room(R, _, _, _, _),
        room_usage(R, Schedule, U)
    ), Usages).

mean(List, Mean) :-
    length(List, N), N > 0,
    sumlist(List, Sum),
    Mean is Sum / N.

room_variance(Schedule, Variance) :-
    all_room_usages(Schedule, Usages),
    mean(Usages, Mu),
    findall(Sq, (
        member(U, Usages),
        Sq is (U - Mu) * (U - Mu)
    ), Squares),
    sumlist(Squares, SumSq),
    length(Usages, M), M > 0,
    Variance is SumSq / M.

% ============================================================
% ÉVALUATION COMPLÈTE D UN SCHEDULE
% evaluate_schedule(+Schedule, -ETotal, -Imbalance, -Variance)
% ============================================================
evaluate_schedule(Schedule, ETotal, Imbalance, Variance) :-
    energy_total_campus(Schedule, ETotal),
    energy_imbalance(Schedule, Imbalance),
    room_variance(Schedule, Variance).

% ============================================================
% SCORE AGRÉGÉ
% Score = 0.5*ETotal + 0.3*Imbalance + 0.2*Variance
% Plus le score est bas, meilleur est le schedule
% ============================================================
schedule_score(Schedule, Score) :-
    evaluate_schedule(Schedule, ETotal, Imbalance, Variance),
    Score is 0.5 * ETotal + 0.3 * Imbalance + 0.2 * Variance.

% ============================================================
% COMPARAISON DE DEUX SCHEDULES
% ============================================================
better_schedule(S1, S2) :-
    schedule_score(S1, Score1),
    schedule_score(S2, Score2),
    Score1 < Score2.

% ============================================================
% SÉLECTION DU MEILLEUR SCHEDULE (fold récursif)
% ============================================================
best_schedule([S], S).
best_schedule([S1, S2 | Rest], Best) :-
    (   better_schedule(S1, S2)
    ->  best_schedule([S1 | Rest], Best)
    ;   best_schedule([S2 | Rest], Best)
    ).

% ============================================================
% GÉNÉRATION DE CANDIDATS — filière GL uniquement
% Utilise le backtracking natif pour obtenir des solutions différentes
% ============================================================

% Récupère la Nème solution via backtracking natif
nth_solution(Goal, N, Solution) :-
    nb_setval(sol_counter, 0),
    call(Goal, Solution),
    nb_getval(sol_counter, C),
    C1 is C + 1,
    nb_setval(sol_counter, C1),
    C1 =:= N,
    !.

% Base de génération d un schedule GL
generate_gl_candidate_base(Schedule) :-
    findall(T, (
        task_amphi(T),
        T = task(_, _, filiere, f_gl)
    ), Amphis),
    assign_all(Amphis, [], S1),
    build_group_tasks([g1, g2, g3, g14], Tasks),
    assign_all(Tasks, S1, Schedule).

% Génère le Nème schedule GL différent via backtracking
generate_gl_candidate(N, Schedule) :-
    nth_solution(generate_gl_candidate_base, N, Schedule).

% Construit la liste des tâches pour une liste de groupes
build_group_tasks([], []).
build_group_tasks([G|Rest], Tasks) :-
    findall(T, (
        task_groupe(T),
        T = task(_, _, groupe, G)
    ), GTasks),
    build_group_tasks(Rest, RestTasks),
    append(GTasks, RestTasks, Tasks).

% Génère Max candidats un par un
generate_candidates(Max, Candidates) :-
    NbToTry is min(Max, 7),
    format("  Génération de ~w candidats sur filière GL...~n", [NbToTry]),
    generate_candidates_loop(1, NbToTry, Candidates).

generate_candidates_loop(I, Max, []) :- I > Max, !.
generate_candidates_loop(I, Max, [S|Rest]) :-
    I =< Max,
    format("  Tentative ~w...~n", [I]),
    (   generate_gl_candidate(I, S)
    ->  format("  OK~n")
    ;   format("  Pas de solution ~w~n", [I]),
        S = []
    ),
    Next is I + 1,
    generate_candidates_loop(Next, Max, Rest).

% ============================================================
% RAPPORT DE COMPARAISON PAR SCHEDULES
% ============================================================
print_comparison_report(Candidates) :-
    include([S]>>(S \= []), Candidates, ValidCandidates),
    format("~n========================================~n"),
    format("   COMPARAISON DES SCHEDULES CANDIDATS~n"),
    format("     (filière GL — 4 groupes)~n"),
    format("========================================~n~n"),
    ( ValidCandidates = []
    ->  format("Aucun schedule valide à comparer.~n")
    ;   findall(Score-S, (
            member(S, ValidCandidates),
            schedule_score(S, Score)
        ), Pairs),
        sort(Pairs, Sorted),
        format("Rang | E_total  | Imbalance | Var(R) | Score~n"),
        format("-----+----------+-----------+--------+---------~n"),
        print_ranked(Sorted, 1)
    ).

print_ranked([], _).
print_ranked([Score-S | Rest], Rank) :-
    evaluate_schedule(S, E, I, V),
    format("~w    | ~4f   | ~4f    | ~4f | ~4f~n",
           [Rank, E, I, V, Score]),
    Next is Rank + 1,
    print_ranked(Rest, Next).

% ============================================================
% COMPARAISON PAR STRATÉGIE DE POIDS
% Démontre que le classement change selon les priorités
% ============================================================
print_weight_comparison(Schedule) :-
    format("~n========================================~n"),
    format("   COMPARAISON PAR STRATÉGIE DE POIDS~n"),
    format("========================================~n~n"),
    format("Même schedule évalué avec 3 fonctions objectif différentes~n~n"),
    format("Stratégie          | Score~n"),
    format("-------------------+--------~n"),

    evaluate_schedule(Schedule, E, I, V),

    % Stratégie 1 : priorité énergie (notre choix)
    S1 is 0.5*E + 0.3*I + 0.2*V,
    format("Priorité énergie   | ~4f  (w=0.5/0.3/0.2)~n", [S1]),

    % Stratégie 2 : priorité équilibre journalier
    S2 is 0.2*E + 0.5*I + 0.3*V,
    format("Priorité équilibre | ~4f  (w=0.2/0.5/0.3)~n", [S2]),

    % Stratégie 3 : priorité fairness salles
    S3 is 0.2*E + 0.2*I + 0.6*V,
    format("Priorité fairness  | ~4f  (w=0.2/0.2/0.6)~n", [S3]),

    format("~nConclusion : le choix des poids reflète~n"),
    format("les priorités institutionnelles du campus.~n"),
    format("Notre choix w1=0.5 priorise l efficacité énergétique.~n").

% ============================================================
% RAPPORT DU MEILLEUR SCHEDULE
% ============================================================
print_optimization_report(Schedule) :-
    evaluate_schedule(Schedule, ETotal, Imbalance, Variance),
    schedule_score(Schedule, Score),

    format("~n========================================~n"),
    format("     RAPPORT D'OPTIMISATION~n"),
    format("========================================~n~n"),

    format("=== Métriques du meilleur schedule ===~n"),
    format("  E_total   (énergie totale)    : ~4f~n", [ETotal]),
    format("  Imbalance (déséquilibre/jour) : ~4f~n", [Imbalance]),
    format("  Var(R)    (variance salles)   : ~4f~n", [Variance]),
    format("  Score agrégé (w=0.5/0.3/0.2) : ~4f~n~n", [Score]),

    format("=== Justification des poids ===~n"),
    format("  w1=0.5 : priorité à l'efficacité énergétique~n"),
    format("  w2=0.3 : équilibre de charge journalière~n"),
    format("  w3=0.2 : fairness dans l usage des salles~n~n"),

    format("=== Analyse des trade-offs ===~n"),
    ( Variance < 2.0
    ->  format("  Fairness OK : bonne répartition des salles (Var=~4f)~n", [Variance])
    ;   format("  Fairness dégradée (Var=~4f)~n", [Variance]),
        format("    → salles économiques concentrent les sessions~n")
    ),
    ( Imbalance < 50
    ->  format("  Équilibre journalier satisfaisant (Imbalance=~4f)~n", [Imbalance])
    ;   format("  Déséquilibre journalier (Imbalance=~4f)~n", [Imbalance]),
        format("    → contraintes de disponibilité profs concentrent certains jours~n")
    ),
    format("~n  E_total=~4f → schedule énergétiquement efficace~n", [ETotal]).

% ============================================================
% EXPORT DU RAPPORT
% ============================================================
export_optimization_report(Schedule, Filename) :-
    open(Filename, write, Stream, [encoding(utf8)]),
    evaluate_schedule(Schedule, ETotal, Imbalance, Variance),
    schedule_score(Schedule, Score),

    format(Stream, "========================================~n", []),
    format(Stream, "   RAPPORT OPTIMISATION — MILESTONE 3~n", []),
    format(Stream, "========================================~n~n", []),

    format(Stream, "FONCTION OBJECTIF~n", []),
    format(Stream, "  Score = 0.5*E_total + 0.3*Imbalance + 0.2*Var(R)~n~n", []),

    format(Stream, "MÉTRIQUES DU MEILLEUR SCHEDULE (filière GL)~n", []),
    format(Stream, "  E_total   : ~4f unités~n",  [ETotal]),
    format(Stream, "  Imbalance : ~4f unités~n",  [Imbalance]),
    format(Stream, "  Var(R)    : ~4f~n",          [Variance]),
    format(Stream, "  Score     : ~4f~n~n",        [Score]),

    format(Stream, "COMPARAISON PAR STRATÉGIE DE POIDS~n", []),
    evaluate_schedule(Schedule, E, I, V),
    S1 is 0.5*E + 0.3*I + 0.2*V,
    S2 is 0.2*E + 0.5*I + 0.3*V,
    S3 is 0.2*E + 0.2*I + 0.6*V,
    format(Stream, "  Priorité énergie   (w=0.5/0.3/0.2) : ~4f~n", [S1]),
    format(Stream, "  Priorité équilibre (w=0.2/0.5/0.3) : ~4f~n", [S2]),
    format(Stream, "  Priorité fairness  (w=0.2/0.2/0.6) : ~4f~n~n", [S3]),

    format(Stream, "JUSTIFICATION DES POIDS CHOISIS~n", []),
    format(Stream, "  w1=0.5 : critère principal — réduction consommation~n", []),
    format(Stream, "  w2=0.3 : éviter surcharge journalière~n", []),
    format(Stream, "  w3=0.2 : équité usage des salles~n~n", []),

    format(Stream, "TRADE-OFFS OBSERVÉS~n", []),
    format(Stream, "  Minimiser E_total concentre les sessions dans~n", []),
    format(Stream, "  les salles les moins coûteuses → augmente Var(R).~n", []),
    format(Stream, "  w3=0.2 limite cet effet sans sacrifier l'énergie.~n", []),
    format(Stream, "  Le déséquilibre journalier est lié aux contraintes~n", []),
    format(Stream, "  de disponibilité des professeurs.~n", []),

    close(Stream),
    format("~n✓ Rapport optimisation exporté : ~w~n", [Filename]).