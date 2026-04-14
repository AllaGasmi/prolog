% ============================================================
% KNOWLEDGE BASE — Campus universitaire
% Projet Logic Programming — GL3 2026
% ============================================================

% ============================================================
% CRÉNEAUX : timeslot(ID, Jour, Heure)
% Créneaux de 1h30 avec pauses (15 min entre créneaux, déjeuner 13h-14h)
% 5 jours (Lun-Ven) x 5 créneaux + Samedi matin (3 créneaux) = 28 créneaux
% Horaires: 8:00, 9:45, 11:30, 14:00, 15:45
% ============================================================

% ── Lundi ─────────────────────────────────────────────────────
timeslot(t1,  monday,    8.0).
timeslot(t2,  monday,    9.75).
timeslot(t3,  monday,   11.5).
timeslot(t4,  monday,   14.0).
timeslot(t5,  monday,   15.75).

% ── Mardi ─────────────────────────────────────────────────────
timeslot(t6,  tuesday,   8.0).
timeslot(t7,  tuesday,   9.75).
timeslot(t8,  tuesday,  11.5).
timeslot(t9,  tuesday,  14.0).
timeslot(t10, tuesday,  15.75).

% ── Mercredi ──────────────────────────────────────────────────
timeslot(t11, wednesday, 8.0).
timeslot(t12, wednesday, 9.75).
timeslot(t13, wednesday,11.5).
timeslot(t14, wednesday,14.0).
timeslot(t15, wednesday,15.75).

% ── Jeudi ─────────────────────────────────────────────────────
timeslot(t16, thursday,  8.0).
timeslot(t17, thursday,  9.75).
timeslot(t18, thursday, 11.5).
timeslot(t19, thursday, 14.0).
timeslot(t20, thursday, 15.75).

% ── Vendredi ──────────────────────────────────────────────────
timeslot(t21, friday,    8.0).
timeslot(t22, friday,    9.75).
timeslot(t23, friday,   11.5).
timeslot(t24, friday,   14.0).
timeslot(t25, friday,   15.75).

% ── Samedi (matin uniquement, jusqu à 13h) ────────────────────
timeslot(t26, saturday,  8.0).
timeslot(t27, saturday,  9.75).
timeslot(t28, saturday, 11.5).

% ============================================================
% FILIÈRES : filiere(ID, Nom)
% ============================================================
filiere(f_gl, 'Génie Logiciel').
filiere(f_rt, 'Réseaux et Télécommunications').
filiere(f_bio, 'Biologie').
filiere(f_ch, 'Chimie').
filiere(f_iia, 'Informatique et Intelligence Artificielle').
filiere(f_imi, 'Informatique et Mathématiques Informatiques').

% ============================================================
% GROUPES : group(ID, FiliereID, NombreEtudiants)
% ============================================================

% ── Groupes GL ───────────────────────────────────────────────
group(g1, f_gl, 25).   % Groupe A — GL 3/1
group(g2, f_gl, 28).   % Groupe B — GL 3/2
group(g3, f_gl, 26).   % Groupe C — GL 3/3
group(g14, f_gl, 24).  % Groupe N — GL 3/4

% ── Groupes RT ───────────────────────────────────────────────
group(g4, f_rt, 24).   % Groupe D — RT 3/1
group(g5, f_rt, 22).   % Groupe E — RT 3/2
group(g15, f_rt, 23).  % Groupe O — RT 3/3

% ── Groupes BIO ──────────────────────────────────────────────
group(g6, f_bio, 20).  % Groupe F — BIO 3/1
group(g7, f_bio, 19).  % Groupe G — BIO 3/2
group(g16, f_bio, 21). % Groupe P — BIO 3/3

% ── Groupes CH ───────────────────────────────────────────────
group(g8, f_ch, 23).   % Groupe H — CH 3/1
group(g9, f_ch, 21).   % Groupe I — CH 3/2
group(g17, f_ch, 22).  % Groupe Q — CH 3/3

% ── Groupes IIA ──────────────────────────────────────────────
group(g10, f_iia, 25). % Groupe J — IIA 3/1
group(g11, f_iia, 27). % Groupe K — IIA 3/2
group(g18, f_iia, 26). % Groupe R — IIA 3/3

% ── Groupes IMI ──────────────────────────────────────────────
group(g12, f_imi, 24). % Groupe L — IMI 3/1
group(g13, f_imi, 26). % Groupe M — IMI 3/2
group(g19, f_imi, 25). % Groupe S — IMI 3/3

% ============================================================
% BÂTIMENTS : building(ID, SeuilEnergieMaxJournalier)
% ============================================================
building(b1, 150).   
building(b2, 130).   
building(b3,  90).   
building(b4, 220).   % Amphithéâtres et salles spécialisées

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

% Bâtiment polyvalent b4 — Tous les filières
building_filiere(b4, f_gl).
building_filiere(b4, f_rt).
building_filiere(b4, f_bio).
building_filiere(b4, f_ch).
building_filiere(b4, f_iia).
building_filiere(b4, f_imi).

% ============================================================
% SALLES : room(ID, Capacite, Equipement, Batiment, CoutEnergie/h)
% ============================================================

% ── Bâtiment b1 (GL et RT) ───────────────────────────────────
room(r1,  120, projector,    b1,  8).   % Amphithéâtre principal
room(r2,  100, projector,    b1,  7).   % Amphithéâtre secondaire
room(r3,  30, projector, b1,  5).
room(r4,  35, projector, b1,  5).
room(r5,  20, lab,       b1, 10).
room(r6,  40, projector, b1,  6).
room(r7,  25, lab,       b1, 11).
room(r8,  28, projector, b1,  5).
room(r9,  32, lab,       b1, 10).
room(r10, 38, projector, b1,  6).
room(r11, 22, lab,       b1, 11).
room(r12, 30, projector, b1,  5).
room(r13, 26, lab,       b1, 10).
room(r14, 35, lab,       b1,  9).

% ── Bâtiment b2 (BIO et CH) ──────────────────────────────────
room(r15, 110, amphi,    b2,  7).   % Amphithéâtre sciences
room(r16, 100, amphi,    b2,  7).   % Amphithéâtre secondaire
room(r17, 25, projector, b2,  4).
room(r18, 20, lab,       b2,  9).
room(r19, 30, lab,       b2, 11).
room(r20, 32, projector, b2,  4).
room(r21, 22, lab,       b2, 10).
room(r22, 28, projector, b2,  4).
room(r23, 24, lab,       b2, 10).
room(r24, 36, projector, b2,  5).
room(r25, 21, lab,       b2,  9).
room(r26, 29, lab,       b2,  8).

% ── Bâtiment b3 (IIA et IMI) ─────────────────────────────────
room(r27, 130, amphi,    b3,  8).   % Amphithéâtre informatique
room(r28, 120, amphi,    b3,  8).   % Amphithéâtre secondaire
room(r29, 40, projector, b3,  6).
room(r30, 25, lab,       b3,  8).
room(r31, 35, projector, b3,  6).
room(r32, 30, lab,       b3,  9).
room(r33, 28, projector, b3,  5).
room(r34, 32, lab,       b3,  8).
room(r35, 38, projector, b3,  7).
room(r36, 23, lab,       b3,  9).
room(r37, 26, projector, b3,  6).
room(r38, 34, lab,       b3,  8).

% ── Bâtiment b4 (Polyvalent - Amphithéâtres et salles spécialisées) ───────
room(r39, 150, amphi,    b4,  9).   % Grand amphithéâtre principal
room(r40, 100, amphi,    b4,  8).   % Amphithéâtre secondaire
room(r41, 80,  projector, b4,  7).   % Salle multimédia grande
room(r42, 60, projector, b4,  8).   % Amphi interactif
room(r43, 50, projector, b4,  8).   % Salle projection
room(r44, 45, lab,       b4, 12).   % Salle informatique avancée
room(r45, 40, projector, b4,  7).   % Salle multimédia
room(r46, 35, lab,       b4, 10).   % Salle de TP spécialisée
room(r47, 42, projector, b4,  7).
room(r48, 100, projector, b3, 7).
% Salles supplémentaires b3 pour IMI
room(r49, 30, projector, b3, 6).
room(r50, 28, projector, b3, 6).
room(r51, 25, lab,       b3, 8).
room(r52, 30, lab,       b3, 9).
% ── Salles supplémentaires b1 (GL et RT) ─────────────────────
room(r53, 30, projector, b1, 5).
room(r54, 30, lab,       b1, 9).
room(r55, 28, projector, b1, 5).
room(r56, 25, lab,       b1, 9).

% ── Salles supplémentaires b2 (BIO et CH) ────────────────────
room(r57, 30, projector, b2, 4).
room(r58, 25, lab,       b2, 8).
room(r59, 28, projector, b2, 4).
room(r60, 22, lab,       b2, 9).

% ── Salles supplémentaires b3 (IIA et IMI) ───────────────────
room(r61, 30, projector, b3, 6).
room(r62, 25, lab,       b3, 8).
room(r63, 28, projector, b3, 6).
room(r64, 26, lab,       b3, 9).

% ============================================================
% COURS : course(ID, NbSessions, Duree, Groupe, Equipement)
% NbSessions = nombre de séances par semaine
% Duree      = durée en nombre de créneaux
% ============================================================

% ══════════════════════════════════════════════════════════════
%  GL — Génie Logiciel  
% course(Matiere, NbSessions, Duree, Filiere, Equipement, Mode)
% ══════════════════════════════════════════════════════════════
course(algorithmique,           1, 1, f_gl, projector, groupe).
course(analyse_numerique,       1, 1, f_gl, projector, groupe).
course(optimisation,            1, 1, f_gl, projector, groupe).
course(francais,                1, 1, f_gl, projector, groupe).
course(complexite_algorithmes,  1, 1, f_gl, projector, groupe).
course(marketing,               1, 1, f_gl, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
course(anglais,                 1, 1, f_gl, projector, groupe).


% ── C → amphi, projector, duree=1 ────────────────────────────
course(analyse_donnees,         1, 1, f_gl, projector, amphi).
course(fondements_syst_repartis,1, 1, f_gl, projector, amphi).
course(co_design,               1, 1, f_gl, projector, amphi).
course(methodologies_conception,1, 1, f_gl, projector, amphi).
course(protocoles_comm_web,     1, 1, f_gl, projector, amphi).
course(bases_donnees_rel_cours, 1, 1, f_gl, projector, amphi).
course(programmation_logique,   1, 1, f_gl, projector, amphi).

% ── TP duree=1 → groupe, lab ──────────────────────────────────
course(tp_programmation_logique,1, 1, f_gl, lab, groupe).
course(tp_fond_syst_repartis,   1, 1, f_gl, lab, groupe).
course(tp_methodologies_conception,      1, 1, f_gl, lab, groupe).
course(tp_co_design,                     1, 1, f_gl, lab, groupe).



% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_analyse_donnees,               1, 2, f_gl, lab, groupe).
course(tp_protocoles_comm_web,           1, 2, f_gl, lab, groupe).
course(projet_personnel_professionnel,   1, 2, f_gl, lab, groupe).


% ══════════════════════════════════════════════════════════════
%  RT — Réseaux & Télécommunications  RT3/1
% ══════════════════════════════════════════════════════════════

% ── CI → groupe, projector, duree=1 ──────────────────────────
course(francais,                1, 1, f_rt, projector, groupe).
course(processus_stochastiques, 1, 1, f_rt, projector, groupe).
course(securite_reseaux,        1, 1, f_rt, projector, groupe).
course(ingenierie_protocoles,   1, 1, f_rt, projector, groupe).
course(marketing,               1, 1, f_rt, projector, groupe).
course(reseaux_radiomobiles,    1, 1, f_rt, projector, groupe).
course(logique,                 1, 1, f_rt, projector, groupe).
course(analyse_numerique,       1, 1, f_rt, projector, groupe).
course(signaux_systemes,        1, 1, f_rt, projector, groupe).
course(admin_bases_donnees,     1, 1, f_rt, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
course(anglais,                 1, 1, f_rt, projector, groupe).

% ── C → amphi, projector, duree=1 ────────────────────────────
course(developpement_javaEE,        1, 1, f_rt, projector, amphi).
course(analyse_donnees,             1, 1, f_rt, projector, amphi).
course(admin_surveillance_reseaux,  1, 1, f_rt, projector, amphi).

% ── TP duree=1 → groupe, lab ──────────────────────────────────
course(tp_admin_surveillance_reseaux, 1, 1, f_rt, lab, groupe).
course(tp_securite_reseaux,           1, 1, f_rt, lab, groupe).

% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_analyse_numerique,          1, 2, f_rt, lab, groupe).
course(tp_signaux_systemes,           1, 2, f_rt, lab, groupe).
course(tp_admin_bases_donnees,        1, 2, f_rt, lab, groupe).
course(tp_developpement_javaEE,       1, 2, f_rt, lab, groupe).
course(projet_personnel_professionnel,1, 2, f_rt, lab, groupe).

% ══════════════════════════════════════════════════════════════
%  IIA — Informatique Industrielle & Automatique  IIA3/1
% ══════════════════════════════════════════════════════════════

% ── CI → groupe, projector, duree=1 ──────────────────────────
course(recherche_operationnelle,       1, 1, f_iia, projector, groupe).
course(automatismes_industriels,       1, 1, f_iia, projector, groupe).
course(conception_syst_mecaniques,     1, 1, f_iia, projector, groupe).
course(bases_donnees,                  1, 1, f_iia, projector, groupe).
course(marketing,                      1, 1, f_iia, projector, groupe).
course(regulation_industrielle,        1, 1, f_iia, projector, groupe).
course(francais,                       1, 1, f_iia, projector, groupe).
course(architecture_avancee_proc,      1, 1, f_iia, projector, groupe).
course(modelisation_identification,    1, 1, f_iia, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
course(anglais,                        1, 1, f_iia, projector, groupe).

% ── C → amphi, projector, duree=1 ────────────────────────────
course(management_qualite_perf_ind,    1, 1, f_iia, projector, amphi).
course(tech_acquisition_commande_if,   1, 1, f_iia, projector, amphi).

% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_recherche_operationnelle,    1, 2, f_iia, lab, groupe).
course(tp_programmation_c_cpp,         1, 2, f_iia, lab, groupe).
course(tp_automatismes_industriels,    1, 2, f_iia, lab, groupe).
course(tp_bases_donnees,               1, 2, f_iia, lab, groupe).
course(tp_conception_syst_mecaniques,  1, 2, f_iia, lab, groupe).
course(tp_architecture_avancee,        1, 2, f_iia, lab, groupe).
course(tp_modelisation_ident_estim,    1, 2, f_iia, lab, groupe).
course(tp_tech_acquisition_commande,   1, 2, f_iia, lab, groupe).

% ══════════════════════════════════════════════════════════════
%  IMI — Instrumentation & Maintenance Industrielle  IMI3/1
% ══════════════════════════════════════════════════════════════

% ── CI → groupe, projector, duree=1 ──────────────────────────
course(thermodynamique_appliquee,      1, 1, f_imi, projector, groupe).
course(instrumentations_optiques,      1, 1, f_imi, projector, groupe).
course(gmao,                           1, 1, f_imi, projector, groupe).
% course(tableau_bord_maintenance,       1, 1, f_imi, projector, groupe).
course(mecanique_fluides_thermique,    1, 1, f_imi, projector, groupe).
course(traitement_numerique_signal,    1, 1, f_imi, projector, groupe).
course(thermique_industrielle,         1, 1, f_imi, projector, groupe).
course(micro_controleurs_dsp,          1, 1, f_imi, projector, groupe).
% course(gpao,                           1, 1, f_imi, projector, groupe)
course(marketing,                      1, 1, f_imi, projector, groupe).
course(francais,                       1, 1, f_imi, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
% course(anglais,                        1, 1, f_imi, projector, groupe).
% course(arabe,                          1, 1, f_imi, projector, groupe).

% ── C → amphi, projector, duree=1 ────────────────────────────
course(reseaux_informatiques,          1, 1, f_imi, projector, amphi).

% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_thermodynamique,             1, 2, f_imi, lab, groupe).
course(tp_instrumentations_optiques,   1, 2, f_imi, lab, groupe).
course(tp_traitement_signal,           1, 2, f_imi, lab, groupe).
course(tp_gmao,                        1, 2, f_imi, lab, groupe).
course(tp_thermique_industrielle,      1, 2, f_imi, lab, groupe).
course(tp_mecanique_fluides,           1, 2, f_imi, lab, groupe).
course(tp_micro_controleurs_dsp,       1, 2, f_imi, lab, groupe).
course(tp_gpao,                        1, 2, f_imi, lab, groupe).

% ══════════════════════════════════════════════════════════════
%  BIO — Biologie Industrielle  BIO3/1
% ══════════════════════════════════════════════════════════════

% ── CI → groupe, projector, duree=1 ──────────────────────────
course(genie_fermentaire,              1, 1, f_bio, projector, groupe).
course(mecanique_fluides_thermique,    1, 1, f_bio, projector, groupe).
course(analyse_sociologique_org,       1, 1, f_bio, projector, groupe).
course(transfert_matiere,              1, 1, f_bio, projector, groupe).
course(chimie_organique_industrielle,  1, 1, f_bio, projector, groupe).
course(analyse_numerique,              1, 1, f_bio, projector, groupe).
course(analyses_chimiques,             1, 1, f_bio, projector, groupe).
course(operations_unitaires,           1, 1, f_bio, projector, groupe).
course(analyses_physiques_spectro,     1, 1, f_bio, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
course(anglais,                        1, 1, f_bi, projector, groupe).

% ── C → amphi, projector, duree=1 ────────────────────────────
course(biotechnologie_vegetale,        1, 1, f_bio, projector, amphi).
course(genie_enzymatique,              1, 1, f_bio, projector, amphi).
course(commerce_international,         1, 1, f_bio, projector, amphi).
course(securite_hygiene,               1, 1, f_bio, projector, amphi).

% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_biotechnologie_vegetale,     1, 2, f_bio, lab, groupe).
course(tp_mecanique_fluides,           1, 2, f_bio, lab, groupe).
course(tp_analyses_chimiques,          1, 2, f_bio, lab, groupe).
course(tp_genie_enzymatique,           1, 2, f_bio, lab, groupe).
course(tp_analyses_spectroscopie,      1, 2, f_bio, lab, groupe).

% ══════════════════════════════════════════════════════════════
%  CH — Chimie Industrielle  CH3/1
% ══════════════════════════════════════════════════════════════

% ── CI → groupe, projector, duree=1 ──────────────────────────
course(francais,                       1, 1, f_ch, projector, groupe).
course(strategie_synthese,             1, 1, f_ch, projector, groupe).
course(electrochimie,                  1, 1, f_ch, projector, groupe).
course(gestion_traitement_dechets,     1, 1, f_ch, projector, groupe).
course(methodes_numeriques,            1, 1, f_ch, projector, groupe).
course(etats_matiere,                  1, 1, f_ch, projector, groupe).
course(optimisation,                   1, 1, f_ch, projector, groupe).
course(traitement_eaux,                1, 1, f_ch, projector, groupe).
course(autom_regul_capteurs,           1, 1, f_ch, projector, groupe).

% ── TD → groupe, projector, duree=1 ──────────────────────────
course(anglais,                        1, 1, f_ch, projector, groupe).
course(arabe,                          1, 1, f_ch, projector, groupe).
course(methodes_separation,            1, 1, f_ch, projector, groupe).

% ── C → amphi, projector, duree=1 ────────────────────────────
course(marketing,                      1, 1, f_ch, projector, amphi).

% ── TP duree=2 → groupe, lab ──────────────────────────────────
course(tp_autom_regul_capteurs,        1, 2, f_ch, lab, groupe).
course(tp_methodes_numeriques,         1, 2, f_ch, lab, groupe).
course(tp_methodes_separation,         1, 2, f_ch, lab, groupe).
course(tp_etats_matiere,               1, 2, f_ch, lab, groupe).
course(tp_strategie_synthese,          1, 2, f_ch, lab, groupe).
course(tp_traitement_eaux,             1, 2, f_ch, lab, groupe).



% ============================================================
% INSTRUCTEURS
% instructor(ID, Nom, MatiereEnseignee)
% ============================================================

% ── GL ───────────────────────────────────────────────────────
instructor(p_gasmi_g,     gasmi_ghada,          algorithmique).
instructor(p_gasmi_g,     gasmi_ghada,          methodologies_conception).
instructor(p_arbi,        arbi_adnen,           analyse_numerique).
instructor(p_sfaxi,       sfaxi_mourad,         optimisation).
instructor(p_khalgui,     khalgui_mohamed,      programmation_logique).
instructor(p_baklouti,    baklouti_fatma,       bases_donnees_rel).
instructor(p_baklouti,    baklouti_fatma,       bases_donnees_rel_cours).
instructor(p_ouni,        ouni_sofiane,         fondements_syst_repartis).
instructor(p_ben_gamra,   ben_gamra_imene,      marketing).
instructor(p_damergi,     damergi_emir,         co_design).
instructor(p_mliki,       mliki_hazar,          complexite_algorithmes).
instructor(p_sellaouti,   sellaouti_aymen,      protocoles_comm_web).
instructor(p_bichiou,     bichiou_imene,        anglais).
instructor(p_zanina,      zanina_wiem,          francais).
instructor(p_taktak,      taktak_hajer,         projet_personnel_professionnel).
instructor(p_arbi,        arbi_adnen,           analyse_donnees).

% ── RT ───────────────────────────────────────────────────────
instructor(p_toumi,       toumi_salwa,          processus_stochastiques).
instructor(p_toumi,       toumi_salwa,          analyse_donnees).
instructor(p_loukil,      loukil_adlene,        securite_reseaux).
instructor(p_karoui,      karoui_kamel,         ingenierie_protocoles).
instructor(p_afif,        afif_meryem,          reseaux_radiomobiles).
instructor(p_mosbahi,     mosbahi_olfa,         logique).
instructor(p_ben_yahia,   ben_yahia_saloua,     developpement_javaEE).
instructor(p_dhouib,      dhouib_monia,         anglais).
instructor(p_ouni,        ouni_sofiane,         admin_surveillance_reseaux).
instructor(p_khayat,      khayat_feten,         analyse_numerique).
instructor(p_amara,       amara_boujemaa_rim,   signaux_systemes).
instructor(p_mami,        mami_imen,            admin_bases_donnees).
instructor(p_miled,       miled_wided,          projet_personnel_professionnel).

% ── IIA ──────────────────────────────────────────────────────
instructor(p_harbaoui,    harbaoui_imen,        recherche_operationnelle).
instructor(p_ghezail,     ghezail_feiza,        automatismes_industriels).
instructor(p_skander,     skander_achref,       conception_syst_mecaniques).
instructor(p_ben_said,    ben_said_salma,       bases_donnees).
instructor(p_ben_romdhane,ben_romdhane_taib,    management_qualite_perf_ind).
instructor(p_braham,      braham_ahmed,         tech_acquisition_commande_if).
instructor(p_gasmi_m,     gasmi_moncef,         regulation_industrielle).
instructor(p_bellamine,   bellamine_med_sahbi,  architecture_avancee_proc).
instructor(p_aloui,       aloui_ridha,          modelisation_identification).
instructor(p_sakhraoui,   sakhraoui_amir,       tp_conception_syst_mecaniques).
instructor(p_taktak,      taktak_hajer,         tp_programmation_c_cpp).

% ── IMI ──────────────────────────────────────────────────────
instructor(p_zaghdoudi,   zaghdoudi_med_chaker, thermodynamique_appliquee).
instructor(p_zaghdoudi,   zaghdoudi_med_chaker, thermique_industrielle).
instructor(p_hfaidh,      hfaidh_imen,          instrumentations_optiques).
instructor(p_ben_romdhane,ben_romdhane_taib,    gmao).
instructor(p_jaafer,      jaafer_imen,          tableau_bord_maintenance).
instructor(p_kaddech,     kaddech_slim,         mecanique_fluides_thermique).
instructor(p_yacoub,      yacoub_slim,          traitement_numerique_signal).
instructor(p_yacoub,      yacoub_slim,          micro_controleurs_dsp).
instructor(p_basti,       basti_ilhem,          arabe).
instructor(p_bohli,       bohli_nadra,          gpao).
instructor(p_saadallah,   saadallah_wecim,      marketing).
instructor(p_yaich,       yaich_sameh,          francais).
instructor(p_kammoun,     kammoun_najeh,        reseaux_informatiques).

% ── BIO ──────────────────────────────────────────────────────
instructor(p_hamdi_m,     hamdi_mokhtar,        genie_fermentaire).
instructor(p_kaddech,     kaddech_slim,         transfert_matiere).
instructor(p_zaouali,     zaouali_yosr,         biotechnologie_vegetale).
instructor(p_gargouri,    gargouri_mohamed,     genie_enzymatique).
instructor(p_jouini,      jouini_maher,         analyse_sociologique_org).
instructor(p_taib,        taib_saied,           chimie_organique_industrielle).
instructor(p_belaid,      belaid_hend,          commerce_international).
instructor(p_hellal,      hellal_faysal,        analyses_chimiques).
instructor(p_abdimoumen,  abdimoumen_souhir,    operations_unitaires).
instructor(p_abidi,       abidi_ferid,          analyses_physiques_spectro).
instructor(p_abderabba,   abderabba_nadia,      securite_hygiene).
instructor(p_zaouali,    zaouali_yosr,     tp_biotechnologie_vegetale).
instructor(p_kaddech,    kaddech_slim,     tp_mecanique_fluides).
instructor(p_hellal,     hellal_faysal,    tp_analyses_chimiques).
instructor(p_gargouri,   gargouri_mohamed, tp_genie_enzymatique).
instructor(p_abidi,      abidi_ferid,      tp_analyses_spectroscopie).

% ── CH ───────────────────────────────────────────────────────
instructor(p_belgaied,    belgaied_jameleddine, methodes_separation).
instructor(p_gatri,       gatri_rafik,          strategie_synthese).
instructor(p_bellakhal,   bellakhal_nizar,      electrochimie).
instructor(p_bouallegui,  bouallegui_hassib,    gestion_traitement_dechets).
instructor(p_khayat,      khayat_feten,         methodes_numeriques).
instructor(p_alma,        alma_mejri,           etats_matiere).
instructor(p_hellal,      hellal_faysal,        optimisation).
instructor(p_monser,      monser_lotfi,         traitement_eaux).
instructor(p_chatti,      chatti_abderrazak,    autom_regul_capteurs).
instructor(p_touj,        touj_nedra,           tp_methodes_separation).
% ── TPs CH — instructeurs ────────────────────────────────────
instructor(p_chatti,    chatti_abderrazak, tp_autom_regul_capteurs).
instructor(p_khayat,    khayat_feten,      tp_methodes_numeriques).
instructor(p_touj,      touj_nedra,        tp_methodes_separation).
instructor(p_alma,      alma_mejri,        tp_etats_matiere).
instructor(p_gatri,     gatri_rafik,       tp_strategie_synthese).
instructor(p_monser,    monser_lotfi,      tp_traitement_eaux).

% ── TPs GL ───────────────────────────────────────────────────
instructor(p_khalgui,   khalgui_mohamed,  tp_programmation_logique).
instructor(p_ouni,      ouni_sofiane,     tp_fond_syst_repartis).
instructor(p_gasmi_g,   gasmi_ghada,      tp_methodologies_conception).
instructor(p_damergi,   damergi_emir,     tp_co_design).
instructor(p_arbi,      arbi_adnen,       tp_analyse_donnees).
instructor(p_sellaouti, sellaouti_aymen,  tp_protocoles_comm_web).
instructor(p_baklouti,  baklouti_fatma,   td_bases_donnees_non_rel).

% ── TPs RT ───────────────────────────────────────────────────
instructor(p_ouni,    ouni_sofiane,   tp_admin_surveillance_reseaux).
instructor(p_loukil,  loukil_adlene,  tp_securite_reseaux).
instructor(p_khayat,  khayat_feten,   tp_analyse_numerique).
instructor(p_amara,   amara_boujemaa_rim, tp_signaux_systemes).
instructor(p_mami,    mami_imen,      tp_admin_bases_donnees).
instructor(p_ben_yahia, ben_yahia_saloua, tp_developpement_javaEE).
instructor(p_miled,   miled_wided,    projet_personnel_professionnel).

% ── TPs IIA ──────────────────────────────────────────────────
instructor(p_harbaoui, harbaoui_imen,  tp_recherche_operationnelle).
instructor(p_taktak,   taktak_hajer,   tp_programmation_c_cpp).
instructor(p_ghezail,  ghezail_feiza,  tp_automatismes_industriels).
instructor(p_ben_said, ben_said_salma, tp_bases_donnees).
instructor(p_sakhraoui,sakhraoui_amir, tp_conception_syst_mecaniques).
instructor(p_bellamine,bellamine_med_sahbi, tp_architecture_avancee).
instructor(p_aloui,    aloui_ridha,    tp_modelisation_ident_estim).
instructor(p_braham,   braham_ahmed,   tp_tech_acquisition_commande).

% ── TPs IMI ──────────────────────────────────────────────────
instructor(p_zaghdoudi, zaghdoudi_med_chaker, tp_thermodynamique).
instructor(p_hfaidh,    hfaidh_imen,          tp_instrumentations_optiques).
instructor(p_yacoub,    yacoub_slim,          tp_traitement_signal).
instructor(p_ben_romdhane, ben_romdhane_taib, tp_gmao).
instructor(p_hfaidh, hfaidh_imen, tp_thermique_industrielle).
instructor(p_kammoun, kammoun_najeh, tp_micro_controleurs_dsp).
instructor(p_jaafer, jaafer_imen, tp_traitement_signal).
instructor(p_bohli, bohli_nadra, tp_gpao).
instructor(p_zaghdoudi, zaghdoudi_med_chaker, tp_gmao).
% ============================================================
% DISPONIBILITÉS DÉCLARÉES PAR LES PROFS
% available(IDProf, CreneauID)
% Le prof déclare TOUS les créneaux où il est libre
% Prolog choisira parmi ces créneaux
% ============================================================

% ── Gasmi Ghada ──────────────────────────────────────────────
available(p_gasmi_g, t1).  available(p_gasmi_g, t2).  available(p_gasmi_g, t3).
available(p_gasmi_g, t18). available(p_gasmi_g, t19). available(p_gasmi_g, t20).
available(p_gasmi_g, t26). available(p_gasmi_g, t27).

% ── Arbi Adnen ───────────────────────────────────────────────
available(p_arbi, t1).  available(p_arbi, t2).  available(p_arbi, t3).
available(p_arbi, t4).  available(p_arbi, t5).
available(p_arbi, t13). available(p_arbi, t14). available(p_arbi, t23).
available(p_arbi, t24).
available(p_arbi, t26). available(p_arbi, t27). available(p_arbi, t28).

% ── Sfaxi Mourad ─────────────────────────────────────────────
available(p_sfaxi, t1).  available(p_sfaxi, t2).  available(p_sfaxi, t3).
available(p_sfaxi, t6).  available(p_sfaxi, t7).  available(p_sfaxi, t8).
available(p_sfaxi, t26). available(p_sfaxi, t27).

% ── Khalgui Mohamed ──────────────────────────────────────────
available(p_khalgui, t6).  available(p_khalgui, t7).  available(p_khalgui, t8).
available(p_khalgui, t9).  available(p_khalgui, t10).
available(p_khalgui, t26). available(p_khalgui, t27). available(p_khalgui, t28).

% ── Baklouti Fatma ──────────────────────────────────────────
available(p_baklouti, t11). available(p_baklouti, t12). available(p_baklouti, t13).
available(p_baklouti, t14). available(p_baklouti, t15).
available(p_baklouti, t26). available(p_baklouti, t27).

% ── Ouni Sofiane ────────────────────────────────────────────
available(p_ouni, t1).  available(p_ouni, t2).  available(p_ouni, t3).
available(p_ouni, t16). available(p_ouni, t17). available(p_ouni, t18).
available(p_ouni, t26). available(p_ouni, t27). available(p_ouni, t28).

% ── Ben Gamra Imene ─────────────────────────────────────────
available(p_ben_gamra, t4).  available(p_ben_gamra, t5).  available(p_ben_gamra, t9).
available(p_ben_gamra, t10). available(p_ben_gamra, t14). available(p_ben_gamra, t15).
available(p_ben_gamra, t26). available(p_ben_gamra, t27).

% ── Damergi Emir ────────────────────────────────────────────
available(p_damergi, t1).  available(p_damergi, t2).  available(p_damergi, t6).
available(p_damergi, t7).  available(p_damergi, t21). available(p_damergi, t22).
available(p_damergi, t26). available(p_damergi, t27). available(p_damergi, t28).

% ── Mliki Hazar ─────────────────────────────────────────────
available(p_mliki, t3).  available(p_mliki, t8).  available(p_mliki, t13).
available(p_mliki, t14). available(p_mliki, t23). available(p_mliki, t24).
available(p_mliki, t26). available(p_mliki, t27).

% ── Sellaouti Aymen ─────────────────────────────────────────
available(p_sellaouti, t21). available(p_sellaouti, t22). available(p_sellaouti, t23).
available(p_sellaouti, t24). available(p_sellaouti, t25).
available(p_sellaouti, t26). available(p_sellaouti, t27). available(p_sellaouti, t28).

% ── Bichiou Imene ───────────────────────────────────────────
available(p_bichiou, t1).  available(p_bichiou, t2).  available(p_bichiou, t6).
available(p_bichiou, t7).  available(p_bichiou, t11). available(p_bichiou, t12).
available(p_bichiou, t26). available(p_bichiou, t27). available(p_bichiou, t28).

% ── Zanina Wiem ─────────────────────────────────────────────
available(p_zanina, t2).  available(p_zanina, t3).  available(p_zanina, t8).
available(p_zanina, t9).  available(p_zanina, t12). available(p_zanina, t13).
available(p_zanina, t26). available(p_zanina, t27).

% ── Taktak Hajer ────────────────────────────────────────────
available(p_taktak, t4).  available(p_taktak, t5).  available(p_taktak, t9).
available(p_taktak, t10). available(p_taktak, t14). available(p_taktak, t15).
available(p_taktak, t26). available(p_taktak, t27). available(p_taktak, t28).

% ── Toumi Salwa ─────────────────────────────────────────────
available(p_toumi, t6).  available(p_toumi, t7).  available(p_toumi, t8).
available(p_toumi, t11). available(p_toumi, t12). available(p_toumi, t13).
available(p_toumi, t26). available(p_toumi, t27).

% ── Loukil Adlene ───────────────────────────────────────────
available(p_loukil, t16). available(p_loukil, t17). available(p_loukil, t18).
available(p_loukil, t21). available(p_loukil, t22). available(p_loukil, t23).
available(p_loukil, t26). available(p_loukil, t27). available(p_loukil, t28).

% ── Karoui Kamel ────────────────────────────────────────────
available(p_karoui, t1).  available(p_karoui, t2).  available(p_karoui, t16).
available(p_karoui, t17). available(p_karoui, t21). available(p_karoui, t22).
available(p_karoui, t26). available(p_karoui, t27).

% ── Afif Meryem ─────────────────────────────────────────────
available(p_afif, t6).  available(p_afif, t7).  available(p_afif, t11).
available(p_afif, t12). available(p_afif, t16). available(p_afif, t17).
available(p_afif, t26). available(p_afif, t27). available(p_afif, t28).

% ── Mosbahi Olfa ────────────────────────────────────────────
available(p_mosbahi, t1).  available(p_mosbahi, t2).  available(p_mosbahi, t3).
available(p_mosbahi, t6).  available(p_mosbahi, t7).
available(p_mosbahi, t26). available(p_mosbahi, t27).

% ── Ben Yahia Saloua ────────────────────────────────────────
available(p_ben_yahia, t21). available(p_ben_yahia, t22). available(p_ben_yahia, t23).
available(p_ben_yahia, t4).  available(p_ben_yahia, t5).
available(p_ben_yahia, t26). available(p_ben_yahia, t27). available(p_ben_yahia, t28).

% ── Dhouib Monia ────────────────────────────────────────────
available(p_dhouib, t11). available(p_dhouib, t12). available(p_dhouib, t13).
available(p_dhouib, t16). available(p_dhouib, t17). available(p_dhouib, t18).
available(p_dhouib, t24).
available(p_dhouib, t26). available(p_dhouib, t27).

% ── Khayat Feten ────────────────────────────────────────────
available(p_khayat, t6).  available(p_khayat, t7).  available(p_khayat, t8).
available(p_khayat, t16). available(p_khayat, t17). available(p_khayat, t18).
available(p_khayat, t24). available(p_khayat, t25).
available(p_khayat, t26). available(p_khayat, t27). available(p_khayat, t28).

% ── Amara Boujemaa Rim ──────────────────────────────────────
available(p_amara, t1).  available(p_amara, t2).  available(p_amara, t11).
available(p_amara, t12). available(p_amara, t21). available(p_amara, t22).
available(p_amara, t24). available(p_amara, t25).
available(p_amara, t26). available(p_amara, t27).

% ── Mami Imen ───────────────────────────────────────────────
available(p_mami, t3).  available(p_mami, t4).  available(p_mami, t8).
available(p_mami, t9).  available(p_mami, t13). available(p_mami, t14).
available(p_mami, t26). available(p_mami, t27). available(p_mami, t28).

% ── Miled Wided ─────────────────────────────────────────────
available(p_miled, t4).  available(p_miled, t5).  available(p_miled, t9).
available(p_miled, t10). available(p_miled, t19). available(p_miled, t20).
available(p_miled, t26). available(p_miled, t27).

% ── Harbaoui Imen ───────────────────────────────────────────
available(p_harbaoui, t11). available(p_harbaoui, t12). available(p_harbaoui, t13).
available(p_harbaoui, t16). available(p_harbaoui, t17). available(p_harbaoui, t18).
available(p_harbaoui, t26). available(p_harbaoui, t27). available(p_harbaoui, t28).

% ── Ghezail Feiza ───────────────────────────────────────────
available(p_ghezail, t1).  available(p_ghezail, t2).  available(p_ghezail, t6).
available(p_ghezail, t7).  available(p_ghezail, t11). available(p_ghezail, t12).
available(p_ghezail, t26). available(p_ghezail, t27).

% ── Skander Achref ──────────────────────────────────────────
available(p_skander, t3).  available(p_skander, t4).  available(p_skander, t8).
available(p_skander, t9).  available(p_skander, t18). available(p_skander, t19).
available(p_skander, t26). available(p_skander, t27). available(p_skander, t28).

% ── Ben Said Salma ──────────────────────────────────────────
available(p_ben_said, t1).  available(p_ben_said, t2).  available(p_ben_said, t16).
available(p_ben_said, t17). available(p_ben_said, t21). available(p_ben_said, t22).
available(p_ben_said, t26). available(p_ben_said, t27).

% ── Ben Romdhane Taib ───────────────────────────────────────
available(p_ben_romdhane, t2).  available(p_ben_romdhane, t3).  available(p_ben_romdhane, t7).
available(p_ben_romdhane, t8).  available(p_ben_romdhane, t12). available(p_ben_romdhane, t13).
available(p_ben_romdhane, t26). available(p_ben_romdhane, t27). available(p_ben_romdhane, t28).
available(p_ben_romdhane, t4). available(p_ben_romdhane, t5).
available(p_ben_romdhane, t9). available(p_ben_romdhane, t14).
available(p_ben_romdhane, t16).

% ── Braham Ahmed ────────────────────────────────────────────
available(p_braham, t4).  available(p_braham, t5).  available(p_braham, t9).
available(p_braham, t10). available(p_braham, t14). available(p_braham, t15).
available(p_braham, t26). available(p_braham, t27).

% ── Bellamine Med Sahbi ─────────────────────────────────────
available(p_bellamine, t6).  available(p_bellamine, t7).  available(p_bellamine, t8).
available(p_bellamine, t16). available(p_bellamine, t17). available(p_bellamine, t18).
available(p_bellamine, t26). available(p_bellamine, t27). available(p_bellamine, t28).

% ── Aloui Ridha ─────────────────────────────────────────────
available(p_aloui, t11). available(p_aloui, t12). available(p_aloui, t13).
available(p_aloui, t21). available(p_aloui, t22). available(p_aloui, t23).
available(p_aloui, t26). available(p_aloui, t27).

% ── Sakhraoui Amir ──────────────────────────────────────────
available(p_sakhraoui, t3).  available(p_sakhraoui, t4).  available(p_sakhraoui, t8).
available(p_sakhraoui, t9).  available(p_sakhraoui, t13). available(p_sakhraoui, t14).
available(p_sakhraoui, t26). available(p_sakhraoui, t27). available(p_sakhraoui, t28).

% ── Zaghdoudi Med Chaker ────────────────────────────────────
available(p_zaghdoudi, t1).  available(p_zaghdoudi, t2).  available(p_zaghdoudi, t11).
available(p_zaghdoudi, t12). available(p_zaghdoudi, t21). available(p_zaghdoudi, t22).
available(p_zaghdoudi, t26). available(p_zaghdoudi, t27).
available(p_zaghdoudi, t3).  available(p_zaghdoudi, t4).
available(p_zaghdoudi, t6).  available(p_zaghdoudi, t7).
available(p_zaghdoudi, t13). available(p_zaghdoudi, t14).
% ── Hfaidh Imen ─────────────────────────────────────────────
available(p_hfaidh, t6).  available(p_hfaidh, t7).  available(p_hfaidh, t11).
available(p_hfaidh, t12). available(p_hfaidh, t16). available(p_hfaidh, t17).
available(p_hfaidh, t26). available(p_hfaidh, t27). available(p_hfaidh, t28).
available(p_hfaidh, t1).  available(p_hfaidh, t4).
available(p_hfaidh, t8).  available(p_hfaidh, t9).
available(p_hfaidh, t13). available(p_hfaidh, t18).

% ── Jaafer Imen ─────────────────────────────────────────────
available(p_jaafer, t4).  available(p_jaafer, t5).  available(p_jaafer, t9).
available(p_jaafer, t10). available(p_jaafer, t14). available(p_jaafer, t15).
available(p_jaafer, t26). available(p_jaafer, t27).
available(p_jaafer, t1).  available(p_jaafer, t2).
available(p_jaafer, t3).  available(p_jaafer, t11).
available(p_jaafer, t16). available(p_jaafer, t21).
% ── Kaddech Slim ────────────────────────────────────────────
available(p_kaddech, t1).  available(p_kaddech, t2).  available(p_kaddech, t16).
available(p_kaddech, t17). available(p_kaddech, t21). available(p_kaddech, t22).
available(p_kaddech, t26). available(p_kaddech, t27). available(p_kaddech, t28).

% ── Yacoub Slim ─────────────────────────────────────────────
available(p_yacoub, t11). available(p_yacoub, t12). available(p_yacoub, t13).
available(p_yacoub, t16). available(p_yacoub, t17). available(p_yacoub, t18).
available(p_yacoub, t26). available(p_yacoub, t27).

% ── Basti Ilhem ─────────────────────────────────────────────
available(p_basti, t3).  available(p_basti, t4).  available(p_basti, t8).
available(p_basti, t9).  available(p_basti, t18). available(p_basti, t19).
available(p_basti, t26). available(p_basti, t27). available(p_basti, t28).

% ── Bohli Nadra ─────────────────────────────────────────────
available(p_bohli, t4).  available(p_bohli, t5).  available(p_bohli, t9).
available(p_bohli, t10). available(p_bohli, t19). available(p_bohli, t20).
available(p_bohli, t26). available(p_bohli, t27).

% ── Saadallah Wecim ─────────────────────────────────────────
available(p_saadallah, t1).  available(p_saadallah, t2).  available(p_saadallah, t11).
available(p_saadallah, t12). available(p_saadallah, t21). available(p_saadallah, t22).
available(p_saadallah, t26). available(p_saadallah, t27). available(p_saadallah, t28).

% ── Yaich Sameh ─────────────────────────────────────────────
available(p_yaich, t2).  available(p_yaich, t3).  available(p_yaich, t7).
available(p_yaich, t8).  available(p_yaich, t12). available(p_yaich, t13).
available(p_yaich, t26). available(p_yaich, t27).

% ── Kammoun Najeh ───────────────────────────────────────────
available(p_kammoun, t6).  available(p_kammoun, t7).  available(p_kammoun, t8).
available(p_kammoun, t16). available(p_kammoun, t17). available(p_kammoun, t18).
available(p_kammoun, t26). available(p_kammoun, t27). available(p_kammoun, t28).
available(p_kammoun, t1).  available(p_kammoun, t2).
available(p_kammoun, t3).  available(p_kammoun, t13).
available(p_kammoun, t14). available(p_kammoun, t19).

% ── Hamdi Mokhtar ───────────────────────────────────────────
available(p_hamdi_m, t11). available(p_hamdi_m, t12). available(p_hamdi_m, t13).
available(p_hamdi_m, t21). available(p_hamdi_m, t22). available(p_hamdi_m, t23).
available(p_hamdi_m, t26). available(p_hamdi_m, t27).

% ── Zaouali Yosr ────────────────────────────────────────────
available(p_zaouali, t1).  available(p_zaouali, t2).  available(p_zaouali, t6).
available(p_zaouali, t7).  available(p_zaouali, t21). available(p_zaouali, t22).
available(p_zaouali, t26). available(p_zaouali, t27). available(p_zaouali, t28).

% ── Gargouri Mohamed ────────────────────────────────────────
available(p_gargouri, t3).  available(p_gargouri, t4).  available(p_gargouri, t8).
available(p_gargouri, t9).  available(p_gargouri, t13). available(p_gargouri, t14).
available(p_gargouri, t26). available(p_gargouri, t27).

% ── Jouini Maher ────────────────────────────────────────────
available(p_jouini, t4).  available(p_jouini, t5).  available(p_jouini, t9).
available(p_jouini, t10). available(p_jouini, t14). available(p_jouini, t15).
available(p_jouini, t26). available(p_jouini, t27). available(p_jouini, t28).

% ── Taib Saied ──────────────────────────────────────────────
available(p_taib, t1).  available(p_taib, t2).  available(p_taib, t11).
available(p_taib, t12). available(p_taib, t21). available(p_taib, t22).
available(p_taib, t26). available(p_taib, t27).

% ── Belaid Hend ─────────────────────────────────────────────
available(p_belaid, t6).  available(p_belaid, t7).  available(p_belaid, t11).
available(p_belaid, t12). available(p_belaid, t16). available(p_belaid, t17).
available(p_belaid, t26). available(p_belaid, t27). available(p_belaid, t28).

% ── Hellal Faysal ───────────────────────────────────────────
available(p_hellal, t3).  available(p_hellal, t4).  available(p_hellal, t8).
available(p_hellal, t9).  available(p_hellal, t18). available(p_hellal, t19).
available(p_hellal, t26). available(p_hellal, t27).

% ── Abdimoumen Souhir ───────────────────────────────────────
available(p_abdimoumen, t4).  available(p_abdimoumen, t5).  available(p_abdimoumen, t9).
available(p_abdimoumen, t10). available(p_abdimoumen, t19). available(p_abdimoumen, t20).
available(p_abdimoumen, t26). available(p_abdimoumen, t27). available(p_abdimoumen, t28).

% ── Abidi Ferid ─────────────────────────────────────────────
available(p_abidi, t1).  available(p_abidi, t2).  available(p_abidi, t11).
available(p_abidi, t12). available(p_abidi, t21). available(p_abidi, t22).
available(p_abidi, t26). available(p_abidi, t27).

% ── Abderabba Nadia ────────────────────────────────────────
available(p_abderabba, t6).  available(p_abderabba, t7).  available(p_abderabba, t8).
available(p_abderabba, t16). available(p_abderabba, t17). available(p_abderabba, t18).
available(p_abderabba, t26). available(p_abderabba, t27). available(p_abderabba, t28).

% ── Belgaied Jameleddine ───────────────────────────────────
available(p_belgaied, t11). available(p_belgaied, t12). available(p_belgaied, t13).
available(p_belgaied, t21). available(p_belgaied, t22). available(p_belgaied, t23).
available(p_belgaied, t26). available(p_belgaied, t27).

% ── Gatri Rafik ────────────────────────────────────────────
available(p_gatri, t3).  available(p_gatri, t4).  available(p_gatri, t8).
available(p_gatri, t9).  available(p_gatri, t18). available(p_gatri, t19).
available(p_gatri, t26). available(p_gatri, t27). available(p_gatri, t28).

% ── Bellakhal Nizar ────────────────────────────────────────
available(p_bellakhal, t4).  available(p_bellakhal, t5).  available(p_bellakhal, t9).
available(p_bellakhal, t10). available(p_bellakhal, t14). available(p_bellakhal, t15).
available(p_bellakhal, t26). available(p_bellakhal, t27).

% ── Bouallegui Hassib ──────────────────────────────────────
available(p_bouallegui, t1).  available(p_bouallegui, t2).  available(p_bouallegui, t16).
available(p_bouallegui, t17). available(p_bouallegui, t21). available(p_bouallegui, t22).
available(p_bouallegui, t26). available(p_bouallegui, t27). available(p_bouallegui, t28).

% ── Alma Mejri ──────────────────────────────────────────────
available(p_alma, t2).  available(p_alma, t3).  available(p_alma, t7).
available(p_alma, t8).  available(p_alma, t12). available(p_alma, t13).
available(p_alma, t26). available(p_alma, t27).

% ── Monser Lotfi ────────────────────────────────────────────
available(p_monser, t6).  available(p_monser, t7).  available(p_monser, t8).
available(p_monser, t16). available(p_monser, t17). available(p_monser, t18).
available(p_monser, t26). available(p_monser, t27). available(p_monser, t28).

% ── Chatti Abderrazak ───────────────────────────────────────
available(p_chatti, t11). available(p_chatti, t12). available(p_chatti, t13).
available(p_chatti, t21). available(p_chatti, t22). available(p_chatti, t23).
available(p_chatti, t26). available(p_chatti, t27).

% ── Touj Nedra ──────────────────────────────────────────────
available(p_touj, t3).  available(p_touj, t4).  available(p_touj, t8).
available(p_touj, t9).  available(p_touj, t18). available(p_touj, t19).
available(p_touj, t26). available(p_touj, t27). available(p_touj, t28).
available(p_khalgui, t7).
available(p_khalgui, t8).
available(p_khalgui, t9).
available(p_khalgui, t13).

% ── Baklouti Fatma ───────────────────────────────────────────
available(p_baklouti, t6).
available(p_baklouti, t7).
available(p_baklouti, t8).
available(p_baklouti, t9).
available(p_baklouti, t10).

% ── Ouni Sofiane ─────────────────────────────────────────────
available(p_ouni, t10).
available(p_ouni, t11).
available(p_ouni, t12).
available(p_ouni, t13).
available(p_ouni, t14).
available(p_ouni, t15).

% ── Ben Gamra Imene ──────────────────────────────────────────
available(p_ben_gamra, t6).
available(p_ben_gamra, t7).
available(p_ben_gamra, t8).
available(p_ben_gamra, t10).
available(p_ben_gamra, t13).
available(p_ben_gamra, t15).

% ── Damergi Emir ─────────────────────────────────────────────
available(p_damergi, t13).
available(p_damergi, t14).
available(p_damergi, t15).
available(p_damergi, t16).
available(p_damergi, t17).

% ── Mliki Hazar ──────────────────────────────────────────────
available(p_mliki, t13).
available(p_mliki, t14).
available(p_mliki, t16).
available(p_mliki, t18).
available(p_mliki, t19).

% ── Sellaouti Aymen ──────────────────────────────────────────
available(p_sellaouti, t1).
available(p_sellaouti, t2).
available(p_sellaouti, t18).
available(p_sellaouti, t19).
available(p_sellaouti, t22).

% ── Bichiou Imene ────────────────────────────────────────────
available(p_bichiou, t13).
available(p_bichiou, t14).
available(p_bichiou, t15).
available(p_bichiou, t19).
available(p_bichiou, t20).

% ── Zanina Wiem ──────────────────────────────────────────────
available(p_zanina, t1).
available(p_zanina, t6).
available(p_zanina, t10).
available(p_zanina, t13).
available(p_zanina, t18).

% ── Taktak Hajer ─────────────────────────────────────────────
available(p_taktak, t4).
available(p_taktak, t5).
available(p_taktak, t9).
available(p_taktak, t16).
available(p_taktak, t21).

% ── Toumi Salwa ──────────────────────────────────────────────
available(p_toumi, t1).
available(p_toumi, t2).
available(p_toumi, t3).
available(p_toumi, t10).
available(p_toumi, t11).
available(p_toumi, t12).

% ── Loukil Adlene ────────────────────────────────────────────
available(p_loukil, t1).
available(p_loukil, t3).
available(p_loukil, t6).
available(p_loukil, t13).
available(p_loukil, t15).

% ── Karoui Kamel ─────────────────────────────────────────────
available(p_karoui, t1).
available(p_karoui, t4).
available(p_karoui, t9).
available(p_karoui, t16).
available(p_karoui, t21).

% ── Afif Meryem ──────────────────────────────────────────────
available(p_afif, t6).
available(p_afif, t7).
available(p_afif, t8).
available(p_afif, t13).
available(p_afif, t14).

% ── Mosbahi Olfa ─────────────────────────────────────────────
available(p_mosbahi, t6).
available(p_mosbahi, t7).
available(p_mosbahi, t8).
available(p_mosbahi, t15).
available(p_mosbahi, t20).

% ── Ben Yahia Saloua ─────────────────────────────────────────
available(p_ben_yahia, t7).
available(p_ben_yahia, t8).
available(p_ben_yahia, t9).
available(p_ben_yahia, t12).
available(p_ben_yahia, t16).

% ── Dhouib Monia ─────────────────────────────────────────────
available(p_dhouib, t7).
available(p_dhouib, t8).
available(p_dhouib, t10).
available(p_dhouib, t14).
available(p_dhouib, t19).

% ── Khayat Feten ─────────────────────────────────────────────
available(p_khayat, t1).
available(p_khayat, t6).
available(p_khayat, t9).
available(p_khayat, t13).
available(p_khayat, t18).
available(p_khayat, t20).

% ── Amara Boujemaa Rim ───────────────────────────────────────
available(p_amara, t14).
available(p_amara, t15).
available(p_amara, t17).
available(p_amara, t18).
available(p_amara, t19).

% ── Mami Imen ────────────────────────────────────────────────
available(p_mami, t15).
available(p_mami, t17).
available(p_mami, t19).
available(p_mami, t20).
available(p_mami, t21).

% ── Miled Wided ──────────────────────────────────────────────
available(p_miled, t4).
available(p_miled, t5).
available(p_miled, t16).
available(p_miled, t21).

% ── Harbaoui Imen ────────────────────────────────────────────
available(p_harbaoui, t1).
available(p_harbaoui, t2).
available(p_harbaoui, t4).
available(p_harbaoui, t5).
available(p_harbaoui, t18).

% ── Ghezail Feiza ────────────────────────────────────────────
available(p_ghezail, t1).
available(p_ghezail, t2).
available(p_ghezail, t6).
available(p_ghezail, t7).
available(p_ghezail, t9).

% ── Skander Achref ───────────────────────────────────────────
available(p_skander, t3).
available(p_skander, t4).
available(p_skander, t5).
available(p_skander, t8).
available(p_skander, t16).

% ── Ben Said Salma ───────────────────────────────────────────
available(p_ben_said, t6).
available(p_ben_said, t7).
available(p_ben_said, t8).
available(p_ben_said, t9).
available(p_ben_said, t15).

% ── Ben Romdhane Taib ────────────────────────────────────────
available(p_ben_romdhane, t1).
available(p_ben_romdhane, t3).
available(p_ben_romdhane, t6).
available(p_ben_romdhane, t10).
available(p_ben_romdhane, t11).

% ── Braham Ahmed ─────────────────────────────────────────────
available(p_braham, t10).
available(p_braham, t11).
available(p_braham, t12).
available(p_braham, t16).
available(p_braham, t17).

% ── Gasmi Moncef ─────────────────────────────────────────────
available(p_gasmi_m, t13).
available(p_gasmi_m, t14).
available(p_gasmi_m, t6).
available(p_gasmi_m, t7).
available(p_gasmi_m, t19).

% ── Bellamine Med Sahbi ──────────────────────────────────────
available(p_bellamine, t13).
available(p_bellamine, t14).
available(p_bellamine, t15).
available(p_bellamine, t17).
available(p_bellamine, t18).

% ── Aloui Ridha ──────────────────────────────────────────────
available(p_aloui, t18).
available(p_aloui, t19).
available(p_aloui, t20).
available(p_aloui, t21).
available(p_aloui, t22).

% ── Zaghdoudi Med Chaker ─────────────────────────────────────
available(p_zaghdoudi, t1).
available(p_zaghdoudi, t2).
available(p_zaghdoudi, t5).
available(p_zaghdoudi, t10).
available(p_zaghdoudi, t11).

% ── Hfaidh Imen ──────────────────────────────────────────────
available(p_hfaidh, t2).
available(p_hfaidh, t3).
available(p_hfaidh, t5).
available(p_hfaidh, t14).
available(p_hfaidh, t19).

% ── Jaafer Imen ──────────────────────────────────────────────
available(p_jaafer, t6).
available(p_jaafer, t7).
available(p_jaafer, t8).
available(p_jaafer, t13).
available(p_jaafer, t14).

% ── Kaddech Slim ─────────────────────────────────────────────
available(p_kaddech, t6).
available(p_kaddech, t7).
available(p_kaddech, t10).
available(p_kaddech, t11).
available(p_kaddech, t18).
available(p_kaddech, t19).

% ── Yacoub Slim ──────────────────────────────────────────────
available(p_yacoub, t10).
available(p_yacoub, t11).
available(p_yacoub, t13).
available(p_yacoub, t14).
available(p_yacoub, t22).

% ── Basti Ilhem ──────────────────────────────────────────────
available(p_basti, t8).
available(p_basti, t11).
available(p_basti, t12).
available(p_basti, t15).
available(p_basti, t20).

% ── Bohli Nadra ──────────────────────────────────────────────
available(p_bohli, t13).
available(p_bohli, t14).
available(p_bohli, t16).
available(p_bohli, t17).
available(p_bohli, t19).
available(p_bohli, t1).  available(p_bohli, t2).
available(p_bohli, t3).  available(p_bohli, t6).
available(p_bohli, t7).  available(p_bohli, t11).

% ── Saadallah Wecim ──────────────────────────────────────────
available(p_saadallah, t13).
available(p_saadallah, t14).
available(p_saadallah, t15).
available(p_saadallah, t16).
available(p_saadallah, t20).

% ── Yaich Sameh ──────────────────────────────────────────────
available(p_yaich, t1).
available(p_yaich, t2).
available(p_yaich, t18).
available(p_yaich, t19).
available(p_yaich, t20).

% ── Kammoun Najeh ────────────────────────────────────────────
available(p_kammoun, t7).
available(p_kammoun, t9).
available(p_kammoun, t11).
available(p_kammoun, t12).
available(p_kammoun, t16).

% ── Hamdi Mokhtar ────────────────────────────────────────────
available(p_hamdi_m, t10).
available(p_hamdi_m, t11).
available(p_hamdi_m, t13).
available(p_hamdi_m, t14).
available(p_hamdi_m, t18).

% ── Zaouali Yosr ─────────────────────────────────────────────
available(p_zaouali, t1).
available(p_zaouali, t2).
available(p_zaouali, t6).
available(p_zaouali, t7).
available(p_zaouali, t10).

% ── Gargouri Mohamed ─────────────────────────────────────────
available(p_gargouri, t4).
available(p_gargouri, t5).
available(p_gargouri, t13).
available(p_gargouri, t14).
available(p_gargouri, t16).

% ── Jouini Maher ─────────────────────────────────────────────
available(p_jouini, t4).
available(p_jouini, t5).
available(p_jouini, t16).
available(p_jouini, t20).
available(p_jouini, t21).

% ── Taib Saied ───────────────────────────────────────────────
available(p_taib, t18).
available(p_taib, t19).
available(p_taib, t20).
available(p_taib, t21).

% ── Belaid Hend ──────────────────────────────────────────────
available(p_belaid, t13).
available(p_belaid, t14).
available(p_belaid, t15).
available(p_belaid, t16).

% ── Hellal Faysal ────────────────────────────────────────────
available(p_hellal, t13).
available(p_hellal, t14).
available(p_hellal, t16).
available(p_hellal, t18).
available(p_hellal, t19).
available(p_hellal, t20).

% ── Abdimoumen Souhir ────────────────────────────────────────
available(p_abdimoumen, t18).
available(p_abdimoumen, t19).
available(p_abdimoumen, t20).
available(p_abdimoumen, t21).

% ── Abidi Ferid ──────────────────────────────────────────────
available(p_abidi, t4).
available(p_abidi, t5).
available(p_abidi, t16).
available(p_abidi, t17).
available(p_abidi, t21).

% ── Abderabba Nadia ──────────────────────────────────────────
available(p_abderabba, t7).
available(p_abderabba, t8).
available(p_abderabba, t9).
available(p_abderabba, t14).
available(p_abderabba, t15).

% ── Belgaied Jameleddine ─────────────────────────────────────
available(p_belgaied, t6).
available(p_belgaied, t7).
available(p_belgaied, t8).
available(p_belgaied, t13).
available(p_belgaied, t18).

% ── Gatri Rafik ──────────────────────────────────────────────
available(p_gatri, t1).
available(p_gatri, t3).
available(p_gatri, t8).
available(p_gatri, t15).
available(p_gatri, t16).

% ── Bellakhal Nizar ──────────────────────────────────────────
available(p_bellakhal, t1).
available(p_bellakhal, t4).
available(p_bellakhal, t5).
available(p_bellakhal, t7).
available(p_bellakhal, t16).

% ── Bouallegui Hassib ────────────────────────────────────────
available(p_bouallegui, t1).
available(p_bouallegui, t4).
available(p_bouallegui, t5).
available(p_bouallegui, t9).
available(p_bouallegui, t16).

% ── Alma Mejri ───────────────────────────────────────────────
available(p_alma, t10).
available(p_alma, t11).
available(p_alma, t12).
available(p_alma, t19).
available(p_alma, t20).

% ── Monser Lotfi ─────────────────────────────────────────────
available(p_monser, t14).
available(p_monser, t15).
available(p_monser, t17).
available(p_monser, t18).
available(p_monser, t19).

% ── Chatti Abderrazak ────────────────────────────────────────
available(p_chatti, t7).
available(p_chatti, t8).
available(p_chatti, t13).
available(p_chatti, t15).
available(p_chatti, t20).

% ── Touj Nedra ───────────────────────────────────────────────
available(p_touj, t6).
available(p_touj, t7).
available(p_touj, t13).
available(p_touj, t14).
available(p_touj, t16).

% ── Ben Salah Samia ──────────────────────────────────────────
available(p_ben_salah, t6).
available(p_ben_salah, t7).
available(p_ben_salah, t13).
available(p_ben_salah, t14).
available(p_ben_salah, t16).
available(p_ben_salah, t19).

% ── Sakhraoui Amir ───────────────────────────────────────────
available(p_sakhraoui, t4).
available(p_sakhraoui, t5).
available(p_sakhraoui, t16).
available(p_sakhraoui, t17).
available(p_sakhraoui, t21).
% ── Disponibilités élargies tous profs IMI ───────────────────
available(p_zaghdoudi, t8).  available(p_zaghdoudi, t9).
available(p_zaghdoudi, t15). available(p_zaghdoudi, t16).
available(p_zaghdoudi, t19). available(p_zaghdoudi, t20).

available(p_hfaidh, t10). available(p_hfaidh, t11).
available(p_hfaidh, t15). available(p_hfaidh, t20).
available(p_hfaidh, t21). available(p_hfaidh, t22).

available(p_jaafer, t10). available(p_jaafer, t15).
available(p_jaafer, t17). available(p_jaafer, t19).
available(p_jaafer, t20). available(p_jaafer, t22).

available(p_kaddech, t3).  available(p_kaddech, t4).
available(p_kaddech, t8).  available(p_kaddech, t9).
available(p_kaddech, t13). available(p_kaddech, t14).

available(p_yacoub, t1).  available(p_yacoub, t2).
available(p_yacoub, t3).  available(p_yacoub, t6).
available(p_yacoub, t7).  available(p_yacoub, t8).

available(p_bohli, t8).  available(p_bohli, t9).
available(p_bohli, t12). available(p_bohli, t13).
available(p_bohli, t18). available(p_bohli, t20).

available(p_kammoun, t4).  available(p_kammoun, t5).
available(p_kammoun, t10). available(p_kammoun, t15).
available(p_kammoun, t20). available(p_kammoun, t21).

available(p_ben_romdhane, t15). available(p_ben_romdhane, t16).
available(p_ben_romdhane, t19). available(p_ben_romdhane, t20).
available(p_ben_romdhane, t21). available(p_ben_romdhane, t22).

available(p_jaafer, t18). available(p_jaafer, t21).
available(p_basti,  t13). available(p_basti,  t14).
available(p_basti,  t16). available(p_basti,  t17).
available(p_yaich,  t4).  available(p_yaich,  t5).
available(p_yaich,  t9).  available(p_yaich,  t14).
available(p_saadallah, t6). available(p_saadallah, t7).
available(p_saadallah, t8). available(p_saadallah, t9).% ── Disponibilités supplémentaires profs RT ──────────────────
available(p_toumi,    t14). available(p_toumi,    t15).
available(p_toumi,    t16). available(p_toumi,    t19).
available(p_loukil,   t4).  available(p_loukil,   t5).
available(p_loukil,   t9).  available(p_loukil,   t14).
available(p_karoui,   t6).  available(p_karoui,   t7).
available(p_karoui,   t11). available(p_karoui,   t12).
available(p_afif,     t1).  available(p_afif,     t2).
available(p_afif,     t18). available(p_afif,     t19).
available(p_mosbahi,  t11). available(p_mosbahi,  t12).
available(p_mosbahi,  t16). available(p_mosbahi,  t17).
available(p_amara,    t3).  available(p_amara,    t4).
available(p_amara,    t6).  available(p_amara,    t7).
available(p_mami,     t1).  available(p_mami,     t2).
available(p_mami,     t6).  available(p_mami,     t7).
available(p_khayat,   t2).  available(p_khayat,   t3).
available(p_khayat,   t11). available(p_khayat,   t12).
available(p_dhouib,   t1).  available(p_dhouib,   t2).
available(p_dhouib,   t3).  available(p_dhouib,   t6).
available(p_miled,    t1).  available(p_miled,    t6).
available(p_miled,    t11). available(p_miled,    t12).
available(p_ben_yahia,t1).  available(p_ben_yahia,t2).
available(p_ben_yahia,t3).  available(p_ben_yahia,t6).
available(p_ouni,     t4).  available(p_ouni,     t5).
available(p_ouni,     t6).  available(p_ouni,     t7).
available(p_zaghdoudi, t23). available(p_zaghdoudi, t24).
available(p_zaghdoudi, t25).
available(p_hfaidh,    t23). available(p_hfaidh,    t24).
available(p_hfaidh,    t25).
available(p_jaafer,    t23). available(p_jaafer,    t24).
available(p_jaafer,    t25).
available(p_kammoun,   t23). available(p_kammoun,   t24).
available(p_kammoun,   t25).
available(p_bohli,     t23). available(p_bohli,     t24).
available(p_bohli,     t25).
available(p_yacoub,    t23). available(p_yacoub,    t24).
available(p_yacoub,    t25).
available(p_ben_romdhane, t23). available(p_ben_romdhane, t24).
available(p_ben_romdhane, t25).
available(p_kaddech,   t23). available(p_kaddech,   t24).
available(p_kaddech,   t25).
% ── Créneaux supplémentaires pour g19 ────────────────────────
available(p_zaghdoudi, t15). available(p_zaghdoudi, t17).
available(p_zaghdoudi, t18). available(p_zaghdoudi, t20).
available(p_hfaidh,    t20). available(p_hfaidh,    t21).
available(p_hfaidh,    t22). available(p_hfaidh,    t23).
available(p_jaafer,    t20). available(p_jaafer,    t21).
available(p_jaafer,    t22). available(p_jaafer,    t23).
available(p_kammoun,   t6).  available(p_kammoun,   t7).
available(p_kammoun,   t8).  available(p_kammoun,   t9).
available(p_bohli,     t15). available(p_bohli,     t16).
available(p_bohli,     t21). available(p_bohli,     t22).
available(p_yacoub,    t4).  available(p_yacoub,    t5).
available(p_yacoub,    t9).  available(p_yacoub,    t20).
available(p_ben_romdhane, t17). available(p_ben_romdhane, t18).
available(p_ben_romdhane, t19). available(p_ben_romdhane, t20).
available(p_kaddech,   t15). available(p_kaddech,   t16).
available(p_kaddech,   t20). available(p_kaddech,   t21).