% ============================================================
% MAIN — Point d’entrée optimisé
% ============================================================
:- consult(knowledge_base).
:- consult(constraints).
:- consult(scheduler).
:- consult(display).
:- consult(analysis).
:- consult(energy).
:- consult(optimization).
:- encoding(utf8).

% ============================================================
% LANCER LE SYSTÈME
% ?- run.
% ============================================================

run :-
    format("~n========================================~n"),
    format("  Système de planification — Milestone 1~n"),
    format("========================================~n~n"),

    % 1. Placer tous les amphis
    findall(T, task_amphi(T), Amphis),
    assign_all(Amphis, [], S1),
    format("Amphis OK~n"),

    % 2. Ordre optimisé des groupes (très important)
    Gimi = [g12, g13, g19],
    Giia = [g18, g10, g11],
    Grt  = [g15, g4, g5],
    Ggl  = [g14, g1, g2, g3],
    Gbio = [g16, g6, g7],
    Gch  = [g17, g8, g9],

    append(Gimi, Giia, Temp1),
    append(Temp1, Grt,  Temp2),
    append(Temp2, Ggl,  Temp3),
    append(Temp3, Gbio, Temp4),
    append(Temp4, Gch,  Groupes),

    % Placement avec récupération meme en cas d échec
    (   plan_groupes_interleaved(Groupes, S1, Final)
    ->  format("~n=== PLANNING COMPLET TROUVÉ ===~n~n")
    ;   format("~n=== PLANNING INCOMPLET (bloqué) ===~n~n"),
        nb_current(schedule, Final)
    ),

    nb_setval(final_schedule, Final),

    print_stats(Final),

    print_energy_report(Final),

    export_schedule(Final, 'planning.txt'),

    % Affichage d analyse
    print_building_energy_analysis(Final),

    % Export d analyse détaillée
    export_analysis(Final, 'analysis.txt'),
    % ── MILESTONE 3 : Optimisation sur filière GL ────────────
    format("~n=== PHASE OPTIMISATION (Milestone 3) ===~n"),
    format("Démonstration sur filière GL (4 groupes)~n~n"),
    MaxCandidates = 5,
    generate_candidates(MaxCandidates, Candidates),
    include([S]>>(S \= []), Candidates, ValidCandidates),
    ( ValidCandidates \= []
    -> print_comparison_report(ValidCandidates),
       best_schedule(ValidCandidates, BestGL),
       format("~nMeilleur schedule GL sélectionné.~n"),
       print_optimization_report(BestGL),
       export_optimization_report(BestGL, 'optimization_report.txt')
    ;  format("Aucun candidat GL valide — évaluation du planning principal.~n"),
       print_optimization_report(Final),
       export_optimization_report(Final, 'optimization_report.txt')
    ),

    format("~nFichier 'planning.txt' créé dans le dossier du projet.~n"),
    format("Fichier 'analysis.txt' créé pour la compréhension des contraintes.~n"),
    format("Ouvre-les avec Notepad ou VS Code pour tout lire tranquillement.~n").

% ============================================================
% PLANIFICATION GROUPE PAR GROUPE
% ============================================================
plan_groupes_interleaved([], Acc, Acc).
plan_groupes_interleaved([G|Rest], Acc, Final) :-
    format("Groupe ~w...~n", [G]),
    findall(T, (task_groupe(T), T = task(_, _, groupe, G)), Tasks),
    (   assign_all(Tasks, Acc, Acc2)
    ->  length(Acc, Old),
        length(Acc2, New),
        NbNew is New - Old,
        format("  OK — +~w sessions~n", [NbNew]),
        plan_groupes_interleaved(Rest, Acc2, Final)
    ;   format("  ECHEC sur groupe ~w~n", [G]),
        nb_setval(schedule, Acc),
        diagnose,
        fail
    ).

% ============================================================
% DIAGNOSTIC
% ============================================================
diagnose :-
    format("~n=== DIAGNOSTIC ===~n"),
    nb_current(schedule, Schedule),
    length(Schedule, Placed),
    format("Sessions déjà placées : ~w~n", [Placed]),

    % Tester le premier groupe qui pose problème (g17 actuellement)
    findall(Task, (task_groupe(Task), Task = task(_,_,groupe,g17)), TasksG17),
    length(TasksG17, Nb),
    format("Sessions restantes pour g17 : ~w~n", [Nb]),

    ( TasksG17 = [ProblematicTask|_] ->
        format("Tâche testée : ~w~n", [ProblematicTask]),
        findall((R,T), (room(R,_,_,_,_), all_constraints_ok(ProblematicTask, R, T, [])), Static),
        length(Static, SN),
        format("Possibilités statiques : ~w~n", [SN]),

        findall((R,T), all_constraints_ok(ProblematicTask, R, T, Schedule), Real),
        length(Real, RN),
        format("Possibilités restantes avec planning actuel : ~w~n", [RN])
    ;   true
    ).

% ============================================================
% Helper
current_schedule(S) :- nb_current(schedule, S), !.
current_schedule([]).