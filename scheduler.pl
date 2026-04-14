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

% Assignation de tous les tasks
assign_all([], Schedule, Schedule).
assign_all([Task|Rest], Acc, Final) :-
    assign_task(Task, Acc, Acc2),
    assign_all(Rest, Acc2, Final).

% Assignation d’un task (contraintes statiques en premier)
assign_task(Task, Acc, [session(Task, Room, Time)|Acc]) :-
    findall(R, (
        room(R, _, _, _, _),
        building_ok(Task, R),
        equipment_ok(Task, R),
        capacity_ok(Task, R)
    ), Rooms),
    findall(T, instructor_ok(Task, T), Times),
    member(Room, Rooms),
    member(Time, Times),
    room_free(Room, Time, Acc),
    group_free(Task, Time, Acc),
    energy_ok(Task, Room, Time, Acc).

% Point d’entrée (optionnel)
generate_schedule(Schedule) :-
    generate_tasks(Tasks),
    assign_all(Tasks, [], Schedule).