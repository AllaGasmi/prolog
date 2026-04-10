% ============================================================
% CONSTRAINTS — Vérification des contraintes dures
% Projet Logic Programming — GL3 2026
% Version 2 : support amphi/groupe + building_filiere
% ============================================================
:- consult(knowledge_base).

% ============================================================
% HELPERS — Extraction d'informations selon le mode
% ============================================================

% Récupère la filière d'un task
task_filiere(task(Course, _, filiere, FiliereID), FiliereID) :-
    course(Course, _, _, FiliereID, _, amphi).

task_filiere(task(Course, _, groupe, GroupID), FiliereID) :-
    course(Course, _, _, FiliereID, _, groupe),
    group(GroupID, FiliereID, _).

% Enrollment total d'une filière (pour les amphi)
filiere_enrollment(FiliereID, Total) :-
    findall(N, group(_, FiliereID, N), Ns),
    sumlist(Ns, Total).

% Enrollment d'un task (amphi = total filière, groupe = taille groupe)
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
% Une salle ne peut accueillir qu'une seule session à la fois
% ============================================================
room_free(Room, Time, Schedule) :-
    \+ member(session(_, Room, Time), Schedule).

% ============================================================
% CONTRAINTE 2 : Pas de conflit de groupe/filière
% — Mode groupe : le groupe ne doit pas être occupé à ce créneau
% — Mode amphi  : aucun groupe de la filière ne doit être occupé
%                 + la filière elle-même n'a pas déjà un amphi
% ============================================================

% Cas groupe
group_free(task(Course, _, groupe, GroupID), Time, Schedule) :-
    \+ (
        member(session(OtherTask, _, Time), Schedule),
        OtherTask = task(_, _, groupe, GroupID)
    ),
    % Vérifier aussi qu'aucun amphi de sa filière n'occupe ce créneau
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
    % La filière n'a pas déjà un amphi à ce créneau
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
% La salle doit avoir l'équipement requis par le cours
% ============================================================
equipment_ok(Task, Room) :-
    task_equipment(Task, Equip),
    room(Room, _, Equip, _, _).

% ============================================================
% CONTRAINTE 5 : Instructeur disponible
% Le créneau doit être dans les disponibilités de l'instructeur
% On indexe toujours par CourseID
% ============================================================
instructor_ok(task(Course, _, _, _),
wqt-iqhk-dhj