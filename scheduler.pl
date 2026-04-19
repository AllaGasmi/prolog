% ============================================================
% SCHEDULER — Génération récursive du planning
% ============================================================
:- consult(knowledge_base).
:- consult(constraints).

% Génération de tous les tasks
generate_tasks(Tasks) :-
    findall(T, task_amphi(T), AmphiTasks),
    findall(T, task_groupe(T), GroupeTasks),
    append(AmphiTasks, GroupeTasks, Tasks).

task_amphi(task(Course, Session, filiere, FiliereID)) :-
    course(Course, NbSessions, _, FiliereID, _, amphi),
    between(1, NbSessions, Session).

task_groupe(task(Course, Session, groupe, GroupID)) :-
    course(Course, NbSessions, _, FiliereID, _, groupe),
    between(1, NbSessions, Session),
    group(GroupID, FiliereID, _).

% ============================================================
% Tri des salles par capacité croissante (Best Fit)
% ============================================================
sort_rooms_by_capacity(Rooms, SortedRooms) :-
    findall(Cap-R, (member(R, Rooms), room(R, Cap, _, _, _)), CapRooms),
    sort(CapRooms, SortedCapRooms),
    findall(R, member(_-R, SortedCapRooms), SortedRooms).

% Assignation de tous les tasks
assign_all([], Schedule, Schedule).
assign_all([Task|Rest], Acc, Final) :-
    assign_task(Task, Acc, Acc2),
    assign_all(Rest, Acc2, Final).

% ============================================================
% Assignation dun GROUPE (avec optimisation Best Fit)
% Choisir la plus petite salle qui satisfait la capacité
% Les salles sont essayées de la plus petite à la plus grande
% ============================================================
assign_task(task(Course, SessionIdx, groupe, GroupID), Acc, [session(Task, Room, Time)|Acc]) :-
    Task = task(Course, SessionIdx, groupe, GroupID),
    findall(R, (
        room(R, _, _, _, _),
        building_ok(Task, R),
        equipment_ok(Task, R),
        capacity_ok(Task, R)
    ), Rooms),
    sort_rooms_by_capacity(Rooms, SortedRooms),
    findall(T, instructor_ok(Task, T, Acc), Times),
    member(Time, Times),
    member(Room, SortedRooms),
    room_free(Room, Time, Acc),
    group_free(Task, Time, Acc),
    energy_ok(Task, Room, Time, Acc).

% ============================================================
% Assignation dun AMPHI (sans tri, tous les créneaux)
% ============================================================
assign_task(task(Course, SessionIdx, filiere, FiliereID), Acc, [session(Task, Room, Time)|Acc]) :-
    Task = task(Course, SessionIdx, filiere, FiliereID),
    findall(R, (
        room(R, _, _, _, _),
        building_ok(Task, R),
        equipment_ok(Task, R),
        capacity_ok(Task, R)
    ), Rooms),
    findall(T, instructor_ok(Task, T, Acc), Times),
    member(Room, Rooms),
    member(Time, Times),
    room_free(Room, Time, Acc),
    group_free(Task, Time, Acc),
    energy_ok(Task, Room, Time, Acc).

% Point d’entrée (optionnel)
generate_schedule(Schedule) :-
    generate_tasks(Tasks),
    assign_all(Tasks, [], Schedule).