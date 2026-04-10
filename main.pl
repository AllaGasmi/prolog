% ============================================================
% MAIN — Point d'entrée et tests — Milestone 1
% Projet Logic Programming — GL3 2026
% Version 2 : support amphi/groupe + filières + instructors
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
    format("========================================~n~n"),
    format("Génération des tasks...~n"),
    generate_tasks(Tasks),
    length(Tasks, NbTasks),
    format("~w tasks à planifier.~n", [NbTasks]),
    format("Recherche d'un planning valide...~n~n"),
    ( generate_schedule(Schedule)
      -> format("Planning trouvé !~n"),
         print_schedule_by_day(Schedule),
         print_schedule_by_filiere(Schedule),
         print_stats(Schedule)
      ;  format("Aucun planning possible avec ces contraintes.~n")
    ).

% ============================================================
% TESTS UNITAIRES
% ?- run_tests.
% ============================================================
run_tests :-
    format("~n=== TESTS UNITAIRES ===~n~n"),
    test_building,
    test_equipment,
    test_capacity_groupe,
    test_capacity_amphi,
    test_instructor,
    test_room_conflict,
    test_group_conflict_groupe,
    test_group_conflict_amphi,
    format("~nTous les tests terminés.~n").

% ── Test 1 : bâtiment affilié ────────────────────────────────
test_building :-
    format("Test bâtiment affilié...~n"),
    TaskGL  = task(c_gl_algo, 1, filiere, f_gl),
    TaskRT  = task(c_rt_arch, 1, filiere, f_rt),
    TaskIIA = task(c_iia_ml,  1, filiere, f_iia),
    % r1 est dans b1 affilié à f_gl → doit passer
    ( building_ok(TaskGL, r1)
      -> format("  OK: r1 valide pour f_gl~n")
      ;  format("  ECHEC: r1 devrait être valide pour f_gl~n") ),
    % r7 est dans b3 affilié à f_iia, pas f_gl → doit échouer
    ( \+ building_ok(TaskGL, r7)
      -> format("  OK: r7 rejeté pour f_gl~n")
      ;  format("  ECHEC: r7 ne devrait pas être valide pour f_gl~n") ),
    % r1 est dans b1 affilié à f_rt → doit passer
    ( building_ok(TaskRT, r1)
      -> format("  OK: r1 valide pour f_rt~n")
      ;  format("  ECHEC: r1 devrait être valide pour f_rt~n") ),
    % r7 est dans b3 affilié à f_iia → doit passer
    ( building_ok(TaskIIA, r7)
      -> format("  OK: r7 valide pour f_iia~n")
      ;  format("  ECHEC: r7 devrait être valide pour f_iia~n") ).

% ── Test 2 : équipement ──────────────────────────────────────
test_equipment :-
    format("Test équipement...~n"),
    TaskProj = task(c_gl_algo, 1, filiere, f_gl),   % requiert projector
    TaskLab  = task(c_gl_tp,   1, groupe,  g_gl1),  % requiert lab
    ( equipment_ok(TaskProj, r1)   % r1 a projector
      -> format("  OK: r1 compatible avec c_gl_algo~n")
      ;  format("  ECHEC: r1 devrait être compatible~n") ),
    ( \+ equipment_ok(TaskProj, r3) % r3 a lab
      -> format("  OK: r3 rejeté pour c_gl_algo~n")
      ;  format("  ECHEC: r3 ne devrait pas être compatible~n") ),
    ( equipment_ok(TaskLab, r3)    % r3 a lab
      -> format("  OK: r3 compatible avec c_gl_tp~n")
      ;  format("  ECHEC: r3 devrait être compatible~n") ).

% ── Test 3 : capacité groupe ─────────────────────────────────
test_capacity_groupe :-
    format("Test capacité (groupe)...~n"),
    % g_gl1 = 28 étudiants, r2 capacité 35 → OK
    Task = task(c_gl_tp, 1, groupe, g_gl1),
    ( capacity_ok(Task, r2)
      -> format("  OK: r2 assez grande pour g_gl1~n")
      ;  format("  ECHEC: r2 devrait suffire pour g_gl1~n") ),
    % g_gl3 = 30 étudiants, r3 capacité 20 → doit échouer
    Task2 = task(c_gl_tp, 1, groupe, g_gl3),
    ( \+ capacity_ok(Task2, r3)
      -> format("  OK: r3 trop petite pour g_gl3~n")
      ;  format("  ECHEC: r3 ne devrait pas suffire~n") ).

% ── Test 4 : capacité amphi ──────────────────────────────────
test_capacity_amphi :-
    format("Test capacité (amphi)...~n"),
    % f_gl a 4 groupes : 28+25+30+22 = 105 étudiants
    % r2 capacité 35 → doit échouer
    Task = task(c_gl_algo, 1, filiere, f_gl),
    ( \+ capacity_ok(Task, r2)
      -> format("  OK: r2 trop petite pour amphi f_gl~n")
      ;  format("  ECHEC: r2 ne devrait pas suffire pour amphi~n") ).

% ── Test 5 : instructeur ─────────────────────────────────────
test_instructor :-
    format("Test instructeur...~n"),
    Task1 = task(c_gl_algo, 1, filiere, f_gl),
    Task2 = task(c_rt_arch, 1, filiere, f_rt),
    ( instructor_ok(Task1, t1)
      -> format("  OK: instructeur c_gl_algo dispo à t1~n")
      ;  format("  ECHEC: devrait être dispo à t1~n") ),
    ( \+ instructor_ok(Task1, t2)
      -> format("  OK: instructeur c_gl_algo indispo à t2~n")
      ;  format("  ECHEC: ne devrait pas être dispo à t2~n") ),
    ( instructor_ok(Task2, t3)
      -> format("  OK: instructeur c_rt_arch dispo à t3~n")
      ;  format("  ECHEC: devrait être dispo à t3~n") ).

% ── Test 6 : conflit de salle ────────────────────────────────
test_room_conflict :-
    format("Test conflit salle...~n"),
    OtherTask = task(c_rt_arch, 1, filiere, f_rt),
    Schedule = [session(OtherTask, r1, t1)],
    ( \+ room_free(r1, t1, Schedule)
      -> format("  OK: r1 détectée occupée à t1~n")
      ;  format("  ECHEC: r1 devrait être occupée à t1~n") ),
    ( room_free(r1, t2, Schedule)
      -> format("  OK: r1 libre à t2~n")
      ;  format("  ECHEC: r1 devrait être libre à t2~n") ).

% ── Test 7 : conflit de groupe (mode groupe) ─────────────────
test_group_conflict_groupe :-
    format("Test conflit groupe (mode groupe)...~n"),
    Task1 = task(c_gl_tp, 1, groupe, g_gl1),
    Task2 = task(c_gl_tp, 2, groupe, g_gl1),
    Schedule = [session(Task1, r3, t2)],
    % même groupe g_gl1 à t2 → conflit
    ( \+ group_free(Task2, t2, Schedule)
      -> format("  OK: g_gl1 détecté occupé à t2~n")
      ;  format("  ECHEC: g_gl1 devrait être occupé à t2~n") ),
    % même groupe à t6 → libre
    ( group_free(Task2, t6, Schedule)
      -> format("  OK: g_gl1 libre à t6~n")
      ;  format("  ECHEC: g_gl1 devrait être libre à t6~n") ).

% ── Test 8 : conflit amphi bloque tous les groupes ───────────
test_group_conflict_amphi :-
    format("Test conflit amphi → groupes bloqués...~n"),
    AmphiTask  = task(c_gl_algo, 1, filiere, f_gl),
    GroupTask  = task(c_gl_tp,   1, groupe,  g_gl2),
    Schedule   = [session(AmphiTask, r1, t1)],
    % g_gl2 appartient à f_gl, amphi f_gl est à t1 → groupe bloqué
    ( \+ group_free(GroupTask, t1, Schedule)
      -> format("  OK: g_gl2 bloqué par amphi f_gl à t1~n")
      ;  format("  ECHEC: g_gl2 devrait être bloqué à t1~n") ),
    ( group_free(GroupTask, t5, Schedule)
      -> format("  OK: g_gl2 libre à t5~n")
      ;  format("  ECHEC: g_gl2 devrait être libre à t5~n") ).

% ============================================================
% DIAGNOSTIC MANUEL
% ?- diagnose.
% ============================================================
diagnose :-
    format("~n=== Diagnostic d'une assignation invalide ===~n"),
    % c_gl_algo (amphi f_gl) dans r3 (lab, b1) à t2
    % Attendu : violation équipement (projector vs lab)
    %           + violation instructeur (t2 non dispo)
    Task = task(c_gl_algo, 1, filiere, f_gl),
    Schedule = [session(task(c_rt_arch, 1, filiere, f_rt), r1, t1)],
    check_violations(Task, r3, t2, Schedule).

% ============================================================
% COMPTER TOUS LES PLANNINGS VALIDES (peut être très lent)
% ?- find_all_schedules.
% ============================================================
find_all_schedules :-
    format("Enumération de tous les plannings valides...~n"),
    findall(S, generate_schedule(S), All),
    length(All, N),
    format("Nombre total de plannings valides : ~w~n", [N]).