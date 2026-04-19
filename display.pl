% ============================================================
% DISPLAY — Affichage et Export du planning
% Projet Logic Programming — GL3 2026
% ============================================================
:- consult(knowledge_base).
:- consult(energy).
:- encoding(utf8).
% ============================================================
% Formatage de la cible (Amphi- ou Groupe-)
% ============================================================
format_target(filiere, FiliereID, Label) :-
    atomic_list_concat(['Amphi-', FiliereID], Label).
format_target(groupe, GroupID, Label) :-
    atomic_list_concat(['Groupe-', GroupID], Label).

% ============================================================
% Récupérer le nom du professeur
% ============================================================
get_instructor_name(Course, ProfName) :-
    instructor(_, ProfName, Course), !.

% ============================================================
% AFFICHAGE PAR FILIÈRE (utilisé dans lexport)
% ============================================================
print_session_detail(session(Task, Room, _)) :-
    Task = task(Course, SessionIdx, Mode, TargetID),
    room(Room, Cap, Equip, Building, _),
    format_target(Mode, TargetID, TargetLabel),
    get_instructor_name(Course, ProfName),
    format("      ~w (session ~w) | ~w | Prof: ~w | Salle ~w [~w, cap:~w, bat:~w]~n",
           [Course, SessionIdx, TargetLabel, ProfName, Room, Equip, Cap, Building]).

% ============================================================
% STATISTIQUES
% ============================================================
% ============================================================
% STATISTIQUES (version simplifiée sans task_filiere)
% ============================================================
print_stats(Schedule) :-
    length(Schedule, TotalSessions),
    findall(_, (member(session(task(_, _, filiere, _), _, _), Schedule)), AmphiList),
    length(AmphiList, NbAmphi),
    findall(_, (member(session(task(_, _, groupe, _), _, _), Schedule)), GroupeList),
    length(GroupeList, NbGroupe),

    findall(Cost, (member(session(_, Room, _), Schedule), room(Room, _, _, _, Cost)), Costs),
    sumlist(Costs, TotalEnergy),

    format("~n=== Statistiques ===~n"),
    format("Sessions totales  : ~w~n", [TotalSessions]),
    format("  dont amphi      : ~w~n", [NbAmphi]),
    format("  dont groupe     : ~w~n", [NbGroupe]),
    format("Filières couvertes: 6~n", []),
    format("Energie totale    : ~w unités~n", [TotalEnergy]).


% ============================================================
% EXPORT DU PLANNING (Version finale corrigée)
% ============================================================
export_schedule(Schedule, Filename) :-
    atomic_list_concat(['C:/Users/MSI/Downloads/prolog-milestone1_correction_alla/prolog-milestone1_correction/', Filename], FullPath),
    open(FullPath, write, Stream, [encoding(utf8)]),

    format(Stream, "========================================~n", []),
    format(Stream, "         PLANNING UNIVERSITAIRE - GL3 2026~n", []),
    format(Stream, "         Planning complet généré~n", []),
    format(Stream, "========================================~n~n", []),

    print_stats_to_stream(Schedule, Stream),
    
    print_energy_to_stream(Schedule, Stream),

    format(Stream, "~n========================================~n", []),
    format(Stream, "         PLANNING DÉTAILLÉ PAR FILIÈRE~n", []),
    format(Stream, "========================================~n", []),

    forall(filiere(FID, FName),
        print_filiere_to_stream(Schedule, FID, FName, Stream)),

    close(Stream),
    format("~n✓ SUCCESS : Planning exporté dans : ~w~n", [FullPath]),
    format("   → Ouvre le fichier avec Notepad ou VS Code.~n").

print_stats_to_stream(Schedule, Stream) :-
    length(Schedule, Total),
    findall(_, member(session(task(_,_,filiere,_),_,_), Schedule), AmphiL),
    length(AmphiL, NbAmphi),
    findall(_, member(session(task(_,_,groupe,_),_,_), Schedule), GroupeL),
    length(GroupeL, NbGroupe),

    format(Stream, "=== STATISTIQUES GLOBALES ===~n", []),
    format(Stream, "Sessions totales   : ~w~n", [Total]),
    format(Stream, "  - Amphithéâtres  : ~w~n", [NbAmphi]),
    format(Stream, "  - Groupes        : ~w~n", [NbGroupe]),
    format(Stream, "Filières couvertes : 6~n", []),
    format(Stream, "========================================~n~n", []).


% ============================================================
% EXPORT RAPPORT ÉNERGÉTIQUE
% ============================================================
print_energy_to_stream(Schedule, Stream) :-
    energy_total_campus(Schedule, ETotal),
    format(Stream, "~n=== RAPPORT ÉNERGÉTIQUE ===~n", []),
    format(Stream, "Consommation totale campus : ~w unités~n", [ETotal]),
    format(Stream, "~n  Détail par bâtiment :~n", []),
    forall(building(BID, MaxE), (
        energy_building_total(BID, Schedule, BTotal),
        format(Stream, "  Bat. ~w : ~w unités (seuil/jour : ~w)~n",
               [BID, BTotal, MaxE]),
        forall(member(Day, [monday, tuesday, wednesday, thursday, friday, saturday]), (
            energy_building_day(BID, Day, Schedule, DE),
            ( DE > 0 ->
                P is round(DE * 100 / MaxE),
                format(Stream, "    ~w : ~w (~w%)~n", [Day, DE, P])
            ; true )
        ))
    )),
    energy_imbalance(Schedule, Imbalance),
    format(Stream, "~nImbalance journalière max : ~w unités~n", [Imbalance]).


print_filiere_to_stream(Schedule, FiliereID, FiliereName, Stream) :-
    format(Stream, "~n>>> Filière : ~w (~w) <<<~n", [FiliereName, FiliereID]),

    findall(S, (member(S, Schedule), S = session(task(_,_,filiere,FiliereID),_,_)), AmphiS),
    findall(S, (member(S, Schedule), S = session(task(_,_,groupe,G),_,_), group(G, FiliereID, _)), GroupS),

    append(AmphiS, GroupS, All),

    ( All = [] 
      -> format(Stream, "  Aucune session pour cette filière.~n", [])
      ;  forall(member(Session, All), print_session_to_stream(Session, Stream))
    ).

print_session_to_stream(session(Task, Room, Time), Stream) :-
    Task = task(Course, SessionIdx, Mode, TargetID),
    timeslot(Time, Day, Hour),
    room(Room, Cap, Equip, Building, Cost),
    format_target(Mode, TargetID, TargetLabel),
    get_instructor_name(Course, ProfName),

    format(Stream, "  ~w ~2f h  |  ~w (session ~w)  |  ~w  |  Prof: ~w  |  Salle ~w (~w, bat.~w)  |  Cap: ~w  |  ~w/h~n",
           [Day, Hour, Course, SessionIdx, TargetLabel, ProfName, Room, Equip, Building, Cap, Cost]).

% ============================================================
% (Optionnel) Affichage console par filière
% ============================================================
print_schedule_by_filiere(Schedule) :-
    format("~n========================================~n"),
    format("         PLANNING PAR FILIERE~n"),
    format("========================================~n"),
    forall(filiere(FID, FName), print_filiere_schedule(Schedule, FID, FName)).

print_filiere_schedule(Schedule, FiliereID, FiliereName) :-
    format("~n>>> Filière : ~w (~w) <<<~n", [FiliereName, FiliereID]),
    findall(S, (member(S, Schedule), S = session(task(_,_,filiere,FiliereID),_,_)), AmphiS),
    findall(S, (member(S, Schedule), S = session(task(_,_,groupe,G),_,_), group(G, FiliereID, _)), GroupS),
    append(AmphiS, GroupS, All),
    ( All = [] -> format("  (aucune session)~n")
    ; forall(member(S, All), print_session_detail(S))
    ).


