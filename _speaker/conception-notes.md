# Notes de conception — décisions d'animation & questions ouvertes

Notes internes sorties du `README.md` (devenu vitrine publique). Décisions d'animation, arbitrages de contenu et questions encore ouvertes. Le déroulé minuté est dans [`pilotage.qmd`](pilotage.qmd) ; les pas-à-pas démo dans [`demo-bloc1-our-turn.qmd`](demo-bloc1-our-turn.qmd) et [`demo-bloc2-our-turn.qmd`](demo-bloc2-our-turn.qmd).

## Décisions déjà tranchées

- **Qui anime ?** CD pilote tout le programme et l'animation au tableau. Maëlle aide en salle (1:1 dans les rangs), pas d'animation au tableau. → plus de « à décider » dans le programme.
- **Créneau & timing** : 10h–12h, ~87 min animé + 10 min pause + 12 min buffer, Q&A au fil. Your turn = countdown **12:00** (figé, fichiers font foi ; `PLAN.md` mentionne 15:00 = obsolète).
- **Exercice 1 — point de départ** : le starter est `format: html` (état « avant »), converti en `format: typst` (pas `format: pdf`). Bien le dire à l'oral.

## Questions ouvertes (à arbitrer avant le jour J)

- **Démo bloc 1 — sens de lecture** : démo côte à côte (`.qmd` vs `.typ` généré) ou montrer d'abord le PDF puis remonter au source ? (À caler avec Maëlle.)
- **`theorem-appearance`** : montrer les 4 styles en screenshot ou en live ? Les screenshots sont plus fiables en temps limité.
- **Contenu conditionnel** : ajouter un exemple concret (ex. saut de page en PDF mais pas en HTML) ?
- **Marginalia** : la présenter comme format article séparé ou comme fonctionnalité du book ? Ce sont deux choses différentes — être clair.

## Points logistiques à valider

- [ ] **Démos live vs screenshots** — pour `theorem-appearance`, orange-book : quels filets de secours en captures ?
- [ ] **Dry-run chronométré** — valider que ~87 min animé tient dans le créneau (cf. `pilotage.qmd`).
- [ ] **Contenu Quarto 1.9/1.10** — vérifier que les features citées sont stables dans la release utilisée le jour J (pré-release `v1.10.4+` recommandée).
- [ ] **Transition RR 2025 → RR 2026** — combien de rappels sur `_brand.yml` ? Les participants n'ont pas forcément vu la présentation 2025.
- [ ] **Matériel salle** — voir la checklist dans [`pilotage.qmd`](pilotage.qmd) (annexe).
