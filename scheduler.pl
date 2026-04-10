% ============================================================
% SCHEDULER — Génération récursive du planning
% Projet Logic Programming — GL3 2026
% Version 2 : support amphi/groupe + instructors
% ============================================================
:- consult(knowledge_base).
:- consult(constraints).

% ============================================================
% POINT D'ENTRÉE PRINCIPAL
% generate_schedule(-Schedule)
% Schedule = liste de session(Task, Room, Time)
% ============================================================
generate_schedule(Schedule) :-
    generate_tasks(Tasks),
    assign_all(Tasks, [], Schedule).

% ============================================================
% GÉNÉRATION DE TOUS LES TASKS
% — cours amphi  : NbSessions tasks, cible = filière
% — cours groupe : NbSessions x NbGroupes tasks, cible = groupe
% ============================================================
generate_tasks(Tasks) :-
    findall(T, task_for_course(T), Tasks).

% Cas amphi : une séance pour toute la filière
task_for_course(task(Course, Session, filiere, FiliereID)) :-
    course(Course, NbSessions, _, FiliereID, _, amphi),
    between(1, NbSessions, Session).

% Cas groupe : une séance par groupe de la filière
task_for_course(task(Course, Session, groupe, GroupID)) :-
    course(Course, NbSessions, _, FiliereID, _, groupe),
    between(1, NbSessions, Session),
    group(GroupID, FiliereID, _).

% ============================================================
% ASSIGNATION DE TOUS LES TASKS
% assign_all(+Tasks, +Acc, -FinalSchedule)
% ============================================================
assign_all([], Schedule, Schedule).
assign_all([Task|Rest], Acc, Final) :-
    assign_task(Task, Acc, Acc2),
    assign_all(Rest, Acc2, Final).

% ============================================================
% ASSIGNATION D'UN TASK
% Cherche une salle + créneau valides pour ce task
% ============================================================
assign_task(Task, Acc, [session(Task, Room, Time)|Acc]) :-
    room(Room, _, _, _, _),
    timeslot(Time, _, _),
    all_constraints_ok(Task, Room, Time, Acc).