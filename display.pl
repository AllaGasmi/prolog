% ============================================================
% DISPLAY — Affichage du planning généré
% Projet Logic Programming — GL3 2026
% Version 2 : support amphi/groupe + filières
% ============================================================
:- consult(knowledge_base).

% ============================================================
% AFFICHAGE COMPLET DU PLANNING (liste brute)
% ============================================================
print_schedule([]) :-
    format("~n=== Fin du planning ===~n").
print_schedule([session(Task, Room, Time)|Rest]) :-
    Task = task(Course, SessionIdx, Mode, TargetID),
    timeslot(Time, Day, Hour),
    room(Room, _, Equip, Building, Cost),
    course(Course, _, Duration, _, _, _),
    format_target(Mode, TargetID, TargetLabel),
    format("~w | Session ~w | ~w | Salle ~w (~w, bat.~w) | ~w ~wh | Duree: ~w slot(s) | Energie/h: ~w~n",
           [Course, SessionIdx, TargetLabel, Room, Equip, Building, Day, Hour, Duration, Cost]),
    print_schedule(Rest).

% Formate l'étiquette cible selon le mode
format_target(filiere, FiliereID, Label) :-
    atomic_list_concat(['Amphi-', FiliereID], Label).
format_target(groupe, GroupID, Label) :-
    atomic_list_concat(['Groupe-', GroupID], Label).

% ============================================================
% AFFICHAGE PAR JOUR
% ============================================================
print_schedule_by_day(Schedule) :-
    format("~n========================================~n"),
    format("         PLANNING HEBDOMADAIRE~n"),
    format("========================================~n"),
    forall(
        member(Day, [monday, tuesday, wednesday, thursday, friday]),
        print_day(Schedule, Day)
    ).

print_day(Schedule, Day) :-
    format("~n--- ~w ---~n", [Day]),
    findall(T, timeslot(T, Day, _), Slots),
    forall(member(Time, Slots), print_slot(Schedule, Day, Time)).

print_slot(Schedule, Day, Time) :-
    timeslot(Time, Day, Hour),
    findall(
        session(Task, Room, Time),
        member(session(Task, Room, Time), Schedule),
        Sessions
    ),
    ( Sessions = []
      -> true
      ;  format("  ~wh:~n", [Hour]),
         forall(member(S, Sessions), print_session_detail(S))
    ).

print_session_detail(session(Task, Room, _)) :-
    Task = task(Course, SessionIdx, Mode, TargetID),
    room(Room, Cap, Equip, Building, _),
    format_target(Mode, TargetID, TargetLabel),
    format("      ~w (session ~w) | ~w | Salle ~w [~w, cap:~w, bat:~w]~n",
           [Course, SessionIdx, TargetLabel, Room, Equip, Cap, Building]).

% ============================================================
% AFFICHAGE PAR FILIÈRE
% ============================================================
print_schedule_by_filiere(Schedule) :-
    format("~n========================================~n"),
    format("         PLANNING PAR FILIERE~n"),
    format("========================================~n"),
    forall(filiere(FID, FName), print_filiere_schedule(Schedule, FID, FName)).

print_filiere_schedule(Schedule, FiliereID, FiliereName) :-
    format("~n>>> Filière : ~w (~w) <<<~n", [FiliereName, FiliereID]),
    % Sessions amphi de cette filière
    findall(
        session(Task, Room, Time),
        (member(session(Task, Room, Time), Schedule),
         Task = task(_, _, filiere, FiliereID)),
        AmphiSessions
    ),
    % Sessions groupe de cette filière
    findall(
        session(Task, Room, Time),
        (member(session(Task, Room, Time), Schedule),
         Task = task(_, _, groupe, GID),
         group(GID, FiliereID, _)),
        GroupSessions
    ),
    append(AmphiSessions, GroupSessions, AllSessions),
    ( AllSessions = []
      -> format("  (aucune session planifiee)~n")
      ;  forall(member(S, AllSessions), print_session_detail(S))
    ).

% ============================================================
% STATISTIQUES DU PLANNING
% ============================================================
print_stats(Schedule) :-
    length(Schedule, TotalSessions),
    % Compter les tasks amphi et groupe
    findall(_, (member(session(task(_, _, filiere, _), _, _), Schedule)), AmphiList),
    length(AmphiList, NbAmphi),
    findall(_, (member(session(task(_, _, groupe, _), _, _), Schedule)), GroupeList),
    length(GroupeList, NbGroupe),
    % Calculer l'énergie totale consommée
    findall(Cost,
        (member(session(_, Room, _), Schedule), room(Room, _, _, _, Cost)),
        Costs),
    sumlist(Costs, TotalEnergy),
    % Nombre de filières couvertes
    findall(F,
        (member(session(Task, _, _), Schedule),
         task_filiere(Task, F)),
        FList),
    sort(FList, UniqFilieres),
    length(UniqFilieres, NbFilieres),
    format("~n=== Statistiques ===~n"),
    format("Sessions totales  : ~w~n", [TotalSessions]),
    format("  dont amphi      : ~w~n", [NbAmphi]),
    format("  dont groupe     : ~w~n", [NbGroupe]),
    format("Filières couvertes: ~w~n", [NbFilieres]),
    format("Energie totale    : ~w unités~n", [TotalEnergy]).