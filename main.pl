% ============================================================
% MAIN — Point d'entrée et tests — Milestone 1
% Projet Logic Programming — GL3 2026
% ============================================================

:- consult(knowledge_base).
:- consult(constraints).
:- consult(scheduler).
:- consult(display).

% ============================================================
% LANCER LE SYSTÈME COMPLET
% ?- run.
% ============================================================
run :-
    format("~n========================================~n"),
    format("  Système de planification — Milestone 1~n"),
    format("========================================~n"),
    format("~nRecherche d'un planning valide...~n"),
    ( generate_schedule(Schedule)
      -> format("Planning trouvé !~n"),
         print_schedule_by_day(Schedule),
         print_stats(Schedule)
      ;  format("Aucun planning possible avec ces contraintes.~n")
    ).

% ============================================================
% TESTS UNITAIRES
% Lancer avec : ?- run_tests.
% ============================================================
run_tests :-
    format("~n=== TESTS UNITAIRES ===~n~n"),
    test_equipment,
    test_capacity,
    test_instructor,
    test_room_conflict,
    test_group_conflict,
    format("~nTous les tests terminés.~n").

% Test 1 : équipement
test_equipment :-
    format("Test équipement...~n"),
    ( equipment_ok(c1, r1)   % c1 veut projector, r1 a projector
      -> format("  OK: c1 compatible avec r1~n")
      ;  format("  ECHEC: c1 devrait être compatible avec r1~n") ),
    ( \+ equipment_ok(c1, r3)  % c1 veut projector, r3 a lab
      -> format("  OK: c1 incompatible avec r3~n")
      ;  format("  ECHEC: c1 ne devrait pas être compatible avec r3~n") ).

% Test 2 : capacité
test_capacity :-
    format("Test capacité...~n"),
    ( capacity_ok(c1, r1)   % g1=25 étudiants, r1 capacité 30
      -> format("  OK: r1 assez grande pour c1~n")
      ;  format("  ECHEC: r1 devrait suffire pour c1~n") ),
    ( \+ capacity_ok(c3, r3)  % g3=30 étudiants, r3 capacité 20
      -> format("  OK: r3 trop petite pour c3~n")
      ;  format("  ECHEC: r3 ne devrait pas suffire pour c3~n") ).

% Test 3 : disponibilité instructeur
test_instructor :-
    format("Test instructeur...~n"),
    ( instructor_ok(c1, t1)
      -> format("  OK: instructeur c1 disponible à t1~n")
      ;  format("  ECHEC: instructeur c1 devrait être dispo à t1~n") ),
    ( \+ instructor_ok(c1, t2)
      -> format("  OK: instructeur c1 indisponible à t2~n")
      ;  format("  ECHEC: instructeur c1 ne devrait pas être dispo à t2~n") ).

% Test 4 : conflit de salle
test_room_conflict :-
    format("Test conflit salle...~n"),
    Schedule = [session(c2, 1, r1, t1)],
    ( \+ room_free(r1, t1, Schedule)
      -> format("  OK: r1 détectée occupée à t1~n")
      ;  format("  ECHEC: r1 devrait être occupée à t1~n") ),
    ( room_free(r1, t2, Schedule)
      -> format("  OK: r1 libre à t2~n")
      ;  format("  ECHEC: r1 devrait être libre à t2~n") ).

% Test 5 : conflit de groupe
test_group_conflict :-
    format("Test conflit groupe...~n"),
    % c1 et c2 sont tous les deux du groupe g1
    Schedule = [session(c1, 1, r1, t1)],
    ( \+ group_free(c2, t1, Schedule)
      -> format("  OK: g1 détecté occupé à t1~n")
      ;  format("  ECHEC: g1 devrait être occupé à t1~n") ),
    ( group_free(c2, t2, Schedule)
      -> format("  OK: g1 libre à t2~n")
      ;  format("  ECHEC: g1 devrait être libre à t2~n") ).

% ============================================================
% TEST DE DIAGNOSTIC
% Voir pourquoi une assignation précise échoue
% ?- diagnose.
% ============================================================
diagnose :-
    format("~n=== Diagnostic d'une assignation invalide ===~n"),
    Schedule = [session(c1, 1, r1, t1)],
    check_violations(c1, r3, t1, Schedule).
    % c1 dans r3 : mauvais équipement (projector vs lab)
    % c1 à t1 avec Schedule déjà occupé : conflit de groupe

% ============================================================
% TROUVER TOUS LES PLANNINGS VALIDES (attention : peut être lent)
% ?- find_all_schedules.
% ============================================================
find_all_schedules :-
    findall(S, generate_schedule(S), All),
    length(All, N),
    format("Nombre total de plannings valides : ~w~n", [N]).