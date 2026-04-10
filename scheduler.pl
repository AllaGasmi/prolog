% ============================================================
% SCHEDULER — Génération récursive du planning
% Projet Logic Programming — GL3 2026
% ============================================================

:- consult(knowledge_base).
:- consult(constraints).

% ============================================================
% POINT D'ENTRÉE PRINCIPAL
% generate_schedule(-Schedule)
% Schedule = liste de session(Cours, IndexSession, Salle, Créneau)
% ============================================================
generate_schedule(Schedule) :-
    findall(C, course(C, _, _, _, _), Courses),
    assign_all(Courses, [], Schedule).

% ============================================================
% ASSIGNATION DE TOUS LES COURS
% assign_all(+Courses, +Acc, -FinalSchedule)
% ============================================================

% Cas de base : plus aucun cours à placer
assign_all([], Schedule, Schedule).

% Cas récursif : placer le cours C puis les suivants
assign_all([C|Rest], Acc, Final) :-
    course(C, NbSessions, _, _, _),
    assign_sessions(C, NbSessions, Acc, Acc2),
    assign_all(Rest, Acc2, Final).

% ============================================================
% ASSIGNATION DES SESSIONS D'UN COURS
% assign_sessions(+Course, +K, +Acc, -NewAcc)
% K = nombre de sessions restantes à placer
% ============================================================

% Cas de base : toutes les sessions sont placées
assign_sessions(_, 0, Acc, Acc).

% Cas récursif : placer la K-ième session
assign_sessions(Course, K, Acc, Final) :-
    K > 0,

    % Chercher une salle et un créneau candidats
    room(Room, _, _, _, _),
    timeslot(Time, _, _),

    % Vérifier TOUTES les contraintes AVANT de continuer
    % (pruning précoce = efficacité maximale)
    all_constraints_ok(Course, Room, Time, Acc),

    % Ajouter la session au planning partiel
    K1 is K - 1,
    assign_sessions(Course, K1,
                    [session(Course, K, Room, Time)|Acc],
                    Final).