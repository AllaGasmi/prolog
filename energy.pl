% ============================================================
% ENERGY — Métriques énergétiques globales
% Projet Logic Programming — GL3 2026
% ============================================================
:- consult(knowledge_base).

% ============================================================
% CONSOMMATION D'UN BÂTIMENT UN JOUR DONNÉ
% E(bl, d) = somme des coûts des sessions dans bl ce jour-là
% ============================================================
energy_building_day(BuildingID, Day, Schedule, Energy) :-
    findall(Cost, (
        member(session(_, Room, Time), Schedule),
        room(Room, _, _, BuildingID, Cost),
        timeslot(Time, Day, _)
    ), Costs),
    sumlist(Costs, Energy).

% ============================================================
% CONSOMMATION TOTALE D'UN BÂTIMENT SUR LA SEMAINE
% ============================================================
energy_building_total(BuildingID, Schedule, Total) :-
    findall(E, (
        member(Day, [monday, tuesday, wednesday, thursday, friday, saturday]),
        energy_building_day(BuildingID, Day, Schedule, E)
    ), Energies),
    sumlist(Energies, Total).

% ============================================================
% CONSOMMATION TOTALE DU CAMPUS (toute la semaine)
% E_total = somme sur tous les bâtiments de energy_building_total
% ============================================================
energy_total_campus(Schedule, Total) :-
    findall(E, (
        building(BuildingID, _),
        energy_building_total(BuildingID, Schedule, E)
    ), Energies),
    sumlist(Energies, Total).

% ============================================================
% IMBALANCE JOURNALIÈRE (Milestone 3, préparation)
% Imbalance = somme sur les jours de (Emax_day - Emin_day)
% ============================================================
daily_energies(Schedule, DayEnergies) :-
    findall(Day-E, (
        member(Day, [monday, tuesday, wednesday, thursday, friday, saturday]),
        findall(Cost, (
            member(session(_, Room, Time), Schedule),
            timeslot(Time, Day, _),
            room(Room, _, _, _, Cost)
        ), Costs),
        sumlist(Costs, E)
    ), DayEnergies).

energy_imbalance(Schedule, Imbalance) :-
    daily_energies(Schedule, DayEnergies),
    pairs_values(DayEnergies, Values),
    max_list(Values, MaxDay),
    min_list(Values, MinDay),
    Imbalance is MaxDay - MinDay.

% ============================================================
% TAUX DE REMPLISSAGE DU SEUIL PAR BÂTIMENT ET PAR JOUR
% Retourne une liste de tuples bâtiment/jour/used/max/pct
% ============================================================
energy_fill_rate(Schedule, Rates) :-
    findall(b(BID, Day, Used, Max, Pct), (
        building(BID, Max),
        member(Day, [monday, tuesday, wednesday, thursday, friday, saturday]),
        energy_building_day(BID, Day, Schedule, Used),
        ( Max > 0 -> Pct is round(Used * 100 / Max) ; Pct = 0 )
    ), Rates).

% ============================================================
% RAPPORT TEXTUEL COMPLET
% ============================================================
print_energy_report(Schedule) :-
    format("~n========================================~n"),
    format("         RAPPORT ÉNERGÉTIQUE~n"),
    format("========================================~n~n"),

    % Total campus
    energy_total_campus(Schedule, ETotal),
    format("Consommation totale campus : ~w unités~n~n", [ETotal]),

    % Par bâtiment
    format("--- Détail par bâtiment ---~n"),
    forall(building(BID, MaxEnergy), (
        energy_building_total(BID, Schedule, BTotal),
        format("  Bâtiment ~w : ~w / semaine  (seuil/jour : ~w)~n",
               [BID, BTotal, MaxEnergy]),
        forall(member(Day, [monday, tuesday, wednesday, thursday, friday, saturday]), (
            energy_building_day(BID, Day, Schedule, DayE),
            ( DayE > 0 ->
                Pct is round(DayE * 100 / MaxEnergy),
                format("    ~w : ~w unités (~w% du seuil)~n", [Day, DayE, Pct])
            ; true )
        ))
    )),

    % Imbalance
    energy_imbalance(Schedule, Imbalance),
    format("~nImbalance journalière max : ~w unités~n", [Imbalance]).