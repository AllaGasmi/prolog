# 📚 BASE DE CONNAISSANCES — Système de Planification Universitaire


---

## 🏫 1. CRÉNEAUX (28 créneaux total)

Créneaux de **1h30** avec pauses intégrées et emploi du temps structuré.

### Structure horaire:
- **Durée par créneaux:** 1h30
- **Pauses entre créneaux:** 15 minutes
- **Pause déjeuner:** 13h00 - 14h00
- **Horaires:**
  - Créneaux matin: 8:00, 9:45, 11:30
  - Créneaux après-midi: 14:00, 15:45

### Distribution:

| Jour | Créneaux | Horaires |
|------|----------|----------|
| **Lundi** | t1-t5 | 8:00, 9:45, 11:30, 14:00, 15:45 |
| **Mardi** | t6-t10 | 8:00, 9:45, 11:30, 14:00, 15:45 |
| **Mercredi** | t11-t15 | 8:00, 9:45, 11:30, 14:00, 15:45 |
| **Jeudi** | t16-t20 | 8:00, 9:45, 11:30, 14:00, 15:45 |
| **Vendredi** | t21-t25 | 8:00, 9:45, 11:30, 14:00, 15:45 |
| **Samedi** | t26-t28 | 8:00, 9:45, 11:30 *(jusqu'à 13h)* |

**Total:** 5 jours × 5 créneaux + 3 créneaux samedi = **28 créneaux**

---

## 📋 2. FILIÈRES (6 filières)

Organisation en 6 filières d'études:

1. **f_gl** - Génie Logiciel
2. **f_rt** - Réseaux et Télécommunications
3. **f_bio** - Biologie
4. **f_ch** - Chimie
5. **f_iia** -  Informatique Industrielle et Automatique
6. **f_imi** - Instrumentation et Maintenance Informatiques

Chaque filière possède un bâtiment principal et une ou plusieurs salles dédiées.

---

## 👥 3. GROUPES D'ÉTUDIANTS (19 groupes)

**Total:** 451 étudiants répartis en 19 groupes

### Répartition par filière:

| Filière | Groupes | ID | Effectifs | Total |
|---------|---------|---------|-----------|-------|
| **GL** | 4 | g1, g2, g3, g14 | 25, 28, 26, 24 | 103 |
| **RT** | 3 | g4, g5, g15 | 24, 22, 23 | 69 |
| **BIO** | 3 | g6, g7, g16 | 20, 19, 21 | 60 |
| **CH** | 3 | g8, g9, g17 | 23, 21, 22 | 66 |
| **IIA** | 3 | g10, g11, g18 | 25, 27, 26 | 78 |
| **IMI** | 3 | g12, g13, g19 | 24, 26, 25 | 75 |

**Format:** `group(ID, FiliereID, NombreEtudiants)`

---

## 🏢 4. BÂTIMENTS (4 bâtiments)

Infrastructure organisée par filière avec **contraintes énergétiques quotidiennes**.

### Bâtiments:

| ID | Filières | Seuil Énergétique | Salles |
|----|-----------|--------------------|--------|
| **b1** | GL, RT | 120 kWh/jour | 14 salles |
| **b2** | BIO, CH | 100 kWh/jour | 12 salles |
| **b3** | IIA, IMI | 80 kWh/jour | 12 salles |
| **b4** | Tous (Polyvalent) | 150 kWh/jour | 9 salles |

**Capacité énergétique totale:** 450 kWh/jour

### Affiliation filière-bâtiment:
- **b1**: GL, RT (Bâtiment principal)
- **b2**: BIO, CH (Bâtiment sciences)
- **b3**: IIA, IMI (Bâtiment informatique - budget réduit)
- **b4**: Tous les filières (Polyvalent - ressources mutualisées)

---

## 🏫 5. SALLES DE COURS (47 total)

**Répartition:** 14 salles b1 + 12 salles b2 + 12 salles b3 + 9 salles b4

### Types d'équipements:

| Équipement | Quantité | Usage |
|------------|----------|-------|
| **Amphi** | 8 | Cours magistraux (120-150 places) |
| **Projector** | 23 | Cours théoriques avec support (20-80 places) |
| **Lab** | 16 | Travaux pratiques & informatique (20-50 places) |

### Amphithéâtres (2 par bâtiment):

| Salle | Capacité | Équipement | Bâtiment | Coût/h |
|-------|----------|-----------|----------|--------|
| **r1** | 120 | Amphi | b1 | 8€ |
| **r2** | 100 | Amphi | b1 | 7€ |
| **r15** | 110 | Amphi | b2 | 7€ |
| **r16** | 100 | Amphi | b2 | 7€ |
| **r27** | 130 | Amphi | b3 | 8€ |
| **r28** | 120 | Amphi | b3 | 8€ |
| **r39** | 150 | Amphi | b4 | 9€ |
| **r40** | 100 | Amphi | b4 | 8€ |

### Distribution par bâtiment:

#### **Bâtiment b1** (GL & RT) — 14 salles
- r1-r2: Amphithéâtres (120, 100 places)
- r3-r4, r6, r8, r10, r12: 6 salles Projector (28-40 places)
- r5, r7, r9, r11, r13, r14: 6 salles Lab (20-35 places)

#### **Bâtiment b2** (BIO & CH) — 12 salles
- r15-r16: Amphithéâtres (110, 100 places)
- r17, r20, r22, r24: 4 salles Projector (25-36 places)
- r18-r19, r21, r23, r25, r26: 6 salles Lab (20-32 places)

#### **Bâtiment b3** (IIA & IMI) — 12 salles
- r27-r28: Amphithéâtres (130, 120 places)
- r29, r31, r33, r35, r37: 5 salles Projector (26-40 places)
- r30, r32, r34, r36, r38: 5 salles Lab (23-34 places)

#### **Bâtiment b4** (Polyvalent) — 9 salles
- r39-r40: Amphithéâtres (150, 100 places)
- r41-r43, r45: 4 salles Projector (40-80 places)
- r44, r46: 2 salles Lab avancées (35-45 places)

### Capacité totale: ~2,630 places

### Coûts énergétiques:
- Amphithéâtres: 7-9€/h
- Projector: 4-8€/h
- Lab: 8-12€/h

---

## 📊 Résumé statistique

| Métrique | Valeur |
|----------|--------|
| Créneaux | 28 |
| Filières | 6 |
| Groupes d'étudiants | 19 |
| Total d'étudiants | 451 |
| Bâtiments | 4 |
| Salles de cours | 47 |
| Amphithéâtres | 8 |
| Projector rooms | 23 |
| Labs | 16 |
| Capacité énergétique | 450 kWh/jour |

---
