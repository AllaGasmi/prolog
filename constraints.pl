============================================================
% CONSTRAINTS — Vérification des contraintes dures
% Projet Logic Programming — GL3 2026
% Version 2 : support amphi/groupe + building_filiere
% ============================================================
:- consult(knowledge_base).

% ============================================================
% HELPERS — Extraction d informations selon le mode
% ============================================================

% Récupère la filière d un task
task_filiere(task(Course, _, filiere, FiliereID), FiliereID) :-
    course(Course, _, _, FiliereID, _, amphi).

task_filiere(task(Course, _, groupe, GroupID), FiliereID) :-
    course(Course, _, _, FiliereID, _, groupe),
    group(GroupID, FiliereID, _).

% Enrollment total d une filière (pour les amphi)
filiere_enrollment(FiliereID, Total) :-
    findall(N, group(_, FiliereID, N), Ns),
    sumlist(Ns, Total).

% Enrollment d un task (amphi = total filière, groupe = taille groupe)
task_enrollment(task(Course, _, filiere, FiliereID), Total) :-
    course(Course, _, _, FiliereID, _, amphi),
    filiere_enrollment(FiliereID, Total).

task_enrollment(task(Course, _, groupe, GroupID), Size) :-
    course(Course, _, _, _, _, groupe),
    group(GroupID, _, Size).

% Equipement requis par un cours
task_equipment(task(Course, _, _, _), Equip) :-
    course(Course, _, _, _, Equip, _).

% ============================================================
% CONTRAINTE 1 : Pas de conflit de salle
% Une salle ne peut accueillir qu une seule session à la fois
% ============================================================

# schedule de toutes les filiéres ici !!!!!

room_free(Room, Time, Schedule) :-
    \+ member(session(_, Room, Time), Schedule).

% ============================================================
% CONTRAINTE 2 : Pas de conflit de groupe/filière
% — Mode groupe : le groupe ne doit pas être occupé à ce créneau
% — Mode amphi  : aucun groupe de la filière ne doit être occupé
%                 + la filière elle-même n a pas déjà un amphi
% ============================================================

% Cas groupe
group_free(task(Course, _, groupe, GroupID), Time, Schedule) :-
    \+ (
        member(session(OtherTask, _, Time), Schedule),
        OtherTask = task(_, _, groupe, GroupID)
    ),
    % verifier qu il n y a pas une sénace commune à tous les groupes de la filière
    group(GroupID, FiliereID, _),
    \+ (
        member(session(OtherTask2, _, Time), Schedule),
        OtherTask2 = task(_, _, filiere, FiliereID)
    ).

% Cas amphi
group_free(task(Course, _, filiere, FiliereID), Time, Schedule) :-
    % Aucun groupe de cette filière ne doit être occupé à ce créneau
    \+ (
        member(session(OtherTask, _, Time), Schedule),
        OtherTask = task(_, _, groupe, OtherGroup),
        group(OtherGroup, FiliereID, _)
    ),
    % La filière n a pas déjà un amphi à ce créneau
    \+ (
        member(session(OtherTask2, _, Time), Schedule),
        OtherTask2 = task(_, _, filiere, FiliereID)
    ).

% ============================================================
% CONTRAINTE 3 : Capacité suffisante
% — Mode groupe : salle >= taille du groupe
% — Mode amphi  : salle >= somme de tous les groupes de la filière
% ============================================================
capacity_ok(Task, Room) :-
    task_enrollment(Task, Required),
    room(Room, Cap, _, _, _),
    Cap >= Required.

% ============================================================
% CONTRAINTE 4 : Équipement compatible
% La salle doit avoir l équipement requis par le cours
% ============================================================
equipment_ok(Task, Room) :-
    task_equipment(Task, Equip),
    room(Room, _, Equip, _, _).

% ============================================================
% CONTRAINTE 5 : Instructeur disponible
% Le créneau doit être dans les disponibilités de l instructeur
% On indexe toujours par CourseID
% ============================================================

instructor_ok(task(Course, _, _, _), Time, instructor(id, nomProf, coursEnseigne)) :-
    coursEnseigne = Course,
    available(id, Time).

% ============================================================
% CONTRAINTE 6 : Bâtiment affilié à la filière du cours
% La salle choisie doit être dans un bâtiment de la filière
% C est la contrainte la plus rapide à vérifier → placée en 1er
% ============================================================
building_ok(Task, Room) :-
    task_filiere(Task, FiliereID),
    room(Room, _, _, BuildingID, _),
    building_filiere(BuildingID, FiliereID).

% ============================================================
% CONTRAINTE 7 : Budget énergétique du bâtiment
% La consommation journalière du bâtiment ne doit pas dépasser
% son seuil maximal après ajout de la nouvelle session
% ============================================================
energy_ok(Task, Room, Time, Schedule) :-
    room(Room, _, _, BuildingID, EnergyCost),
    timeslot(Time, Day, _),
    building(BuildingID, MaxEnergy),
    energy_used(BuildingID, Day, Schedule, UsedSoFar),
    UsedSoFar + EnergyCost =< MaxEnergy.

% Calcule l énergie déjà consommée par un bâtiment un jour donné
energy_used(_, _, [], 0).
energy_used(BuildingID, Day, [session(_, Room, Time) | Rest], Total) :-
    room(Room, _, _, BuildingID, Cost),
    timeslot(Time, Day, _),
    !,
    energy_used(BuildingID, Day, Rest, SubTotal),
    Total is SubTotal + Cost.
energy_used(BuildingID, Day, [_ | Rest], Total) :-
    energy_used(BuildingID, Day, Rest, Total).

% ============================================================
% VÉRIFICATION GLOBALE
% Ordre optimisé : contraintes statiques d abord (pas de liste),
% puis contraintes dynamiques (parcours de Schedule)
% ============================================================
all_constraints_ok(Task, Room, Time, Schedule) :-
    building_ok(Task, Room),           % lookup pur, élimine par filière
    equipment_ok(Task, Room),          % lookup pur, élimine par équipement
    capacity_ok(Task, Room),           % lookup pur, élimine par taille
    instructor_ok(Task, Time),         % lookup pur, élimine par dispo
    room_free(Room, Time, Schedule),   % parcours Schedule
    group_free(Task, Time, Schedule),  % parcours Schedule
    energy_ok(Task, Room, Time, Schedule). % parcours + calcul

% ============================================================
% DIAGNOSTIC — explique pourquoi une assignation échoue
% Utile pour le débogage et la défense orale
% ============================================================
check_violations(Task, Room, Time, Schedule) :-
    Task = task(Course, Session, Mode, TargetID),
    format("~n=== Diagnostic ~w (session ~w, mode ~w, cible ~w) -> salle ~w, créneau ~w ===~n",
           [Course, Session, Mode, TargetID, Room, Time]),
    ( \+ building_ok(Task, Room)
      -> format("  VIOLATION: bâtiment non affilié à la filière~n")
      ;  format("  OK: bâtiment affilié~n") ),
    ( \+ equipment_ok(Task, Room)
      -> format("  VIOLATION: équipement incompatible~n")
      ;  format("  OK: équipement compatible~n") ),
    ( \+ capacity_ok(Task, Room)
      -> format("  VIOLATION: salle trop petite~n")
      ;  format("  OK: capacité suffisante~n") ),
    ( \+ instructor_ok(Task, Time)
      -> format("  VIOLATION: instructeur indisponible~n")
      ;  format("  OK: instructeur disponible~n") ),
    ( \+ room_free(Room, Time, Schedule)
      -> format("  VIOLATION: salle déjà occupée~n")
      ;  format("  OK: salle libre~n") ),
    ( \+ group_free(Task, Time, Schedule)
      -> format("  VIOLATION: groupe/filière déjà en cours~n")
      ;  format("  OK: groupe/filière libre~n") ),
    ( \+ energy_ok(Task, Room, Time, Schedule)
      -> format("  VIOLATION: budget énergétique dépassé~n")
      ;  format("  OK: énergie dans les limites~n") ).