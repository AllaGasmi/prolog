% ============================================================
% DISPLAY — Affichage du planning généré
% Projet Logic Programming — GL3 2026
% ============================================================

:- consult(knowledge_base).

% ============================================================
% AFFICHAGE COMPLET DU PLANNING
% ============================================================
print_schedule([]) :-
    format("~n=== Fin du planning ===~n").
print_schedule([session(C, K, R, T)|Rest]) :-
    timeslot(T, Day, Hour),
    room(R, _, Equip, Building, Cost),
    course(C, _, Duration, Group, _),
    format("Cours ~w | Session ~w | Salle ~w (~w, ~w) | ~w à ~wh | Durée: ~w slot(s) | Énergie: ~w~n",
           [C, K, R, Building, Equip, Day, Hour, Duration, Cost]),
    print_schedule(Rest).

% ============================================================
% AFFICHAGE PAR JOUR (plus lisible)
% ============================================================
print_schedule_by_day(Schedule) :-
    findall(Day, timeslot(_, Day, _), Days),
    sort(Days, UniqDays),
    maplist(print_day(Schedule), UniqDays).

print_day(Schedule, Day) :-
    format("~n--- ~w ---~n", [Day]),
    findall(T, timeslot(T, Day, _), Slots),
    maplist(print_slot(Schedule, Day), Slots).

print_slot(Schedule, Day, Time) :-
    timeslot(Time, Day, Hour),
    findall(
        session(C, K, R, Time),
        member(session(C, K, R, Time), Schedule),
        Sessions
    ),
    ( Sessions = []
      -> true
      ;  format("  ~wh: ", [Hour]),
         maplist(print_session_inline, Sessions),
         nl
    ).

print_session_inline(session(C, _, R, _)) :-
    format("~w@~w  ", [C, R]).

% ============================================================
% STATISTIQUES DU PLANNING
% ============================================================
print_stats(Schedule) :-
    length(Schedule, Total),
    findall(C, course(C, _, _, _, _), Courses),
    length(Courses, NbCours),
    format("~n=== Statistiques ===~n"),
    format("Cours planifiés : ~w~n", [NbCours]),
    format("Sessions totales: ~w~n", [Total]).