% ============================================================
% CONSTRAINTS — Vérification des contraintes dures
% Projet Logic Programming — GL3 2026
% ============================================================

:- consult(knowledge_base).

% ============================================================
% CONTRAINTE 1 : Pas de conflit de salle
% Une salle ne peut accueillir qu'une seule session à la fois
% ============================================================
room_free(Room, Time, Schedule) :-
    \+ member(session(_, _, Room, Time), Schedule).

% ============================================================
% CONTRAINTE 2 : Pas de conflit de groupe
% Un groupe ne peut assister qu'à une seule session à la fois
% ============================================================
group_free(Course, Time, Schedule) :-
    course(Course, _, _, Group, _),
    \+ (
        member(session(C2, _, _, Time), Schedule),
        course(C2, _, _, Group, _),
        C2 \= Course
    ).

% ============================================================
% CONTRAINTE 3 : Capacité suffisante
% La salle doit pouvoir accueillir tous les étudiants du groupe
% ============================================================
capacity_ok(Course, Room) :-
    course(Course, _, _, Group, _),
    group(Group, Size),
    room(Room, Cap, _, _, _),
    Cap >= Size.

% ============================================================
% CONTRAINTE 4 : Équipement compatible
% La salle doit avoir l'équipement requis par le cours
% ============================================================
equipment_ok(Course, Room) :-
    course(Course, _, _, _, Equip),
    room(Room, _, Equip, _, _).

% ============================================================
% CONTRAINTE 5 : Instructeur disponible
% Le créneau doit être dans les disponibilités de l'instructeur
% ============================================================
instructor_ok(Course, Time) :-
    available(Course, Time).

% ============================================================
% VÉRIFICATION GLOBALE : toutes les contraintes en une fois
% Ordre optimisé : les plus restrictives d'abord (pruning max)
% ============================================================
all_constraints_ok(Course, Room, Time, Schedule) :-
    equipment_ok(Course, Room),    % élimine le plus de cas
    capacity_ok(Course, Room),     % élimine selon taille
    instructor_ok(Course, Time),   % élimine selon dispo
    room_free(Room, Time, Schedule),
    group_free(Course, Time, Schedule).

% ============================================================
% DIAGNOSTIC : explique pourquoi une assignation échoue
% Utile pour le débogage et la défense orale
% ============================================================
check_violations(Course, Room, Time, Schedule) :-
    format("~n=== Diagnostic session ~w -> salle ~w, créneau ~w ===~n",
           [Course, Room, Time]),
    ( \+ equipment_ok(Course, Room)
      -> format("  VIOLATION: équipement incompatible~n")
      ;  format("  OK: équipement compatible~n") ),
    ( \+ capacity_ok(Course, Room)
      -> format("  VIOLATION: salle trop petite~n")
      ;  format("  OK: capacité suffisante~n") ),
    ( \+ instructor_ok(Course, Time)
      -> format("  VIOLATION: instructeur indisponible~n")
      ;  format("  OK: instructeur disponible~n") ),
    ( \+ room_free(Room, Time, Schedule)
      -> format("  VIOLATION: salle déjà occupée~n")
      ;  format("  OK: salle libre~n") ),
    ( \+ group_free(Course, Time, Schedule)
      -> format("  VIOLATION: groupe déjà en cours~n")
      ;  format("  OK: groupe libre~n") ).