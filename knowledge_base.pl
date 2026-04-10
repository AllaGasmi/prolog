% ============================================================
% KNOWLEDGE BASE — Campus universitaire
% Projet Logic Programming — GL3 2026
% ============================================================

% ============================================================
% CRÉNEAUX : timeslot(ID, Jour, Heure)
% 5 jours x 4 créneaux = 20 créneaux disponibles
% ============================================================
# prendre en compte les pauses !!!!
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
# Ajouter prédicat filiére et chaque groupe appartient à une filière !!!!!
group(g1, 25).   % Groupe A — GL 3/1
group(g2, 18).   % Groupe B — GL 3/2
group(g3, 30).   % Groupe C — GL 3/3
group(g4, 22).   % Groupe D — GL 3/4

% ============================================================
% BÂTIMENTS : building(ID, SeuilEnergieMaxJournalier)
% ============================================================
# Ajouter prédicat filiére et chaque bâtiment appartient à une filière !!!!!
building(b1, 120).   
building(b2, 100).   
building(b3,  80).   

% building_filiere(BatimentID, FiliereID)
% Indique que un bâtiment est affecté à une filière donnée

% Bâtiment principal b1 — GL et RT
building_filiere(b1, f_gl).
building_filiere(b1, f_rt).

% Bâtiment sciences b2 — BIO et CH
building_filiere(b2, f_bio).
building_filiere(b2, f_ch).

% Bâtiment informatique b3 — IIA et IMI
building_filiere(b3, f_iia).
building_filiere(b3, f_imi).

% ============================================================
% SALLES : room(ID, Capacite, Equipement, Batiment, CoutEnergie/h)
% ============================================================

#ajoute plus de classes !!!

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


% ── Cours GL ─────────────────────────────────────────────────
course(c_gl_algo,   2, 2, f_gl, projector, amphi).   % Algorithmique — amphi filière
course(c_gl_tp,     3, 1, f_gl, lab,       groupe).  % TP Programmation — par groupe

% ── Cours RT ─────────────────────────────────────────────────
course(c_rt_arch,   2, 2, f_rt, projector, amphi).   % Architecture réseau — amphi
course(c_rt_tp,     2, 1, f_rt, lab,       groupe).  % TP Réseaux — par groupe

% ── Cours IIA ────────────────────────────────────────────────
course(c_iia_ml,    2, 2, f_iia, projector, amphi).  % Machine Learning — amphi
course(c_iia_tp,    2, 1, f_iia, lab,       groupe). % TP IA — par groupe

% ── Cours IMI ────────────────────────────────────────────────
course(c_imi_math,  2, 2, f_imi, projector, amphi).  % Mathématiques — amphi
course(c_imi_tp,    3, 1, f_imi, lab,       groupe). % TP Numérique — par groupe

% ── Cours BIO ────────────────────────────────────────────────
course(c_bio_cell,  2, 2, f_bio, projector, amphi).  % Biologie cellulaire — amphi
course(c_bio_tp,    3, 1, f_bio, lab,       groupe). % TP Bio — par groupe

% ── Cours CH ─────────────────────────────────────────────────
course(c_ch_orga,   2, 2, f_ch, projector, amphi).   % Chimie organique — amphi
course(c_ch_tp,     2, 1, f_ch, lab,       groupe).  % TP Chimie — par groupe
wqt-iqhk-dhj

% ============================================================
% DISPONIBILITÉ INSTRUCTEUR : available(CoursID, CreneauID)
% Chaque cours a un instructeur avec des disponibilités limitées
% ============================================================

instructor(id, nomProf, coursEnseigne).
available(idprof,timeslot)


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