% ============================================================
% KNOWLEDGE BASE — Campus universitaire
% Projet Logic Programming — GL3 2026
% ============================================================

% ============================================================
% CRÉNEAUX : timeslot(ID, Jour, Heure)
% 5 jours x 4 créneaux = 20 créneaux disponibles
% ============================================================
timeslot(t1,  monday,    8).
timeslot(t2,  monday,   10).
timeslot(t3,  monday,   14).
timeslot(t4,  monday,   16).
timeslot(t5,  tuesday,   8).
timeslot(t6,  tuesday,  10).
timeslot(t7,  tuesday,  14).
timeslot(t8,  tuesday,  16).
timeslot(t9,  wednesday, 8).
timeslot(t10, wednesday,10).
timeslot(t11, wednesday,14).
timeslot(t12, wednesday,16).
timeslot(t13, thursday,  8).
timeslot(t14, thursday, 10).
timeslot(t15, thursday, 14).
timeslot(t16, thursday, 16).
timeslot(t17, friday,    8).
timeslot(t18, friday,   10).
timeslot(t19, friday,   14).
timeslot(t20, friday,   16).

% ============================================================
% GROUPES : group(ID, NombreEtudiants)
% ============================================================
group(g1, 25).   % Groupe A — Génie Logiciel
group(g2, 18).   % Groupe B — Réseaux
group(g3, 30).   % Groupe C — Systèmes embarqués
group(g4, 22).   % Groupe D — Intelligence Artificielle

% ============================================================
% BÂTIMENTS : building(ID, SeuilEnergieMaxJournalier)
% ============================================================
building(b1, 120).   % Bâtiment principal
building(b2, 100).   % Bâtiment sciences
building(b3,  80).   % Bâtiment informatique

% ============================================================
% SALLES : room(ID, Capacite, Equipement, Batiment, CoutEnergie/h)
% ============================================================
room(r1, 30, projector, b1,  5).
room(r2, 35, projector, b1,  5).
room(r3, 20, lab,       b1, 10).
room(r4, 25, projector, b2,  4).
room(r5, 20, lab,       b2,  9).
room(r6, 30, lab,       b2, 11).
room(r7, 40, projector, b3,  6).
room(r8, 25, lab,       b3,  8).

% ============================================================
% COURS : course(ID, NbSessions, Duree, Groupe, Equipement)
% NbSessions = nombre de séances par semaine
% Duree      = durée en nombre de créneaux
% ============================================================
course(c1, 2, 2, g1, projector).  % Algo avancée
course(c2, 3, 1, g1, lab).        % TP Programmation
course(c3, 2, 2, g2, projector).  % Architecture réseau
course(c4, 2, 1, g2, lab).        % TP Réseaux
course(c5, 2, 2, g3, projector).  % Systèmes temps réel
course(c6, 3, 1, g3, lab).        % TP Embarqué
course(c7, 2, 2, g4, projector).  % Machine Learning
course(c8, 2, 1, g4, lab).        % TP IA

% ============================================================
% DISPONIBILITÉ INSTRUCTEUR : available(CoursID, CreneauID)
% Chaque cours a un instructeur avec des disponibilités limitées
% ============================================================
% Instructeur cours c1 (Algo avancée)
available(c1, t1).  available(c1, t5).  available(c1, t9).
available(c1, t13). available(c1, t17).

% Instructeur cours c2 (TP Prog)
available(c2, t2).  available(c2, t6).  available(c2, t10).
available(c2, t14). available(c2, t18).

% Instructeur cours c3 (Architecture réseau)
available(c3, t3).  available(c3, t7).  available(c3, t11).
available(c3, t15). available(c3, t19).

% Instructeur cours c4 (TP Réseaux)
available(c4, t4).  available(c4, t8).  available(c4, t12).
available(c4, t16). available(c4, t20).

% Instructeur cours c5 (Systèmes temps réel)
available(c5, t1).  available(c5, t3).  available(c5, t9).
available(c5, t11). available(c5, t17).

% Instructeur cours c6 (TP Embarqué)
available(c6, t2).  available(c6, t6).  available(c6, t10).
available(c6, t14). available(c6, t18).

% Instructeur cours c7 (Machine Learning)
available(c7, t5).  available(c7, t7).  available(c7, t13).
available(c7, t15). available(c7, t19).

% Instructeur cours c8 (TP IA)
available(c8, t4).  available(c8, t8).  available(c8, t12).
available(c8, t16). available(c8, t20).