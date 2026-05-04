# Review pédagogique — 2026-05-04 (vague 2, post-fix)

> Reviewer : agent reviewer (pédagogue, 2ᵉ vague). Branche : `claude/quarto-book-skeleton-qeDNI`. Dernier commit : `34e8d0f`.
> Méthode : re-lecture intégrale du périmètre + render `quarto render` (8/8 OK, 0 warning Pandoc) + greps ciblés sur les 3 risques de la review du matin.

## Verdict général

**CD a presque raison.** Sur les 3 risques pédagogiques que la review du matin avait flaggés, deux ont été traités proprement (transition Exo 1 → Exo 2 explicitement annoncée comme autonome, charge cognitive Exo 2 atténuée par le découpage 2a/2b et le modèle `_quarto.yml` complet copiable) ; **un seul est encore là, intact** : le **wrap-up de fin de Bloc 2** (et plus généralement la clôture du tutoriel) n'existe toujours pas. Les deux decks se terminent sur la pépite « Saviez-vous que… » qui est explicitement positionnée comme « premier fusible à couper » dans les notes presenter — donc dans le pire cas, le tutoriel se termine sur **rien**. C'est un P1, pas un P0 : le contenu est solide, l'arc narratif tient, mais la rétention 48h après est à risque sans clôture explicite. Le reste du matériel est pédagogiquement prêt.

## 🔴 P0 — bloquant pour le 16 juin

_Aucun._

## 🟠 P1 — à corriger avant le 16 juin

### Wrap-up absent en fin de Bloc 2 (et donc en fin de tutoriel)

- `2-projets/2-projets.qmd:122-138` — la dernière slide du deck Bloc 2 est « Saviez-vous que… » (pépite Template partials). Aucun « En résumé » / « Et maintenant ? » / « Questions ? ».
- `1-quarto-typst/1-quarto-typst.qmd:182-198` — idem fin Bloc 1, mais c'est moins grave : la pause de 10 min sert d'ancre rythmique implicite.
- Les notes presenter `2-projets/2-projets.qmd:137` désignent explicitement cette slide comme « le deuxième fusible à couper si on manque de temps ». Si elle saute, le tutoriel se termine littéralement sur l'expiration du chronomètre Your turn (`2-projets/2-projets.qmd:112`). Pas d'ancrage, pas de récap, pas de Q&A signalée.
- Recommandation minimale (5 min, marge programme dispo) : ajouter en fin de `2-projets/2-projets.qmd` 2-3 slides terminales :
  - « En résumé » : `format: typst` + `_brand.yml` + `type: book` → un PDF pro brandé.
  - « Et maintenant ? » : 2-3 prochaines étapes concrètes (un PDF custom cette semaine, lire la pépite partials, regarder `quarto-ext/typst-templates`) + lien vers `4-ressources.qmd`.
  - « Questions ? » avec contacts CD + Maëlle.
- Note : le matériel narratif de la slide « En résumé » existe déjà — c'est l'arc `index.qmd:17-20` (les 4 questions du tutoriel). Le travail est essentiellement de la mise en slide.

### Objectifs implicites — toujours présents, mais moins critiques

- `1-quarto-typst/index.qmd:24-29` et `2-projets/index.qmd:24-29` listent des « Concepts clés » (= contenu enseigné) mais pas ce que **le participant saura faire** à la fin. C'est le risque #1 de la review du matin, non traité.
- `index.qmd:17-20` pose 4 questions, mais ce sont des questions du formateur, pas des objectifs participant.
- Recommandation lite (peut tenir en 1 commit, sans ajouter de slides) : reformuler la section « Points couverts » des deux pages bloc en « À la fin de ce bloc, vous saurez : (1) …, (2) …, (3) … ». C'est aussi le matériel qui alimente la slide « En résumé » du wrap-up — donc les deux fixes se complètent.

## 🟡 P2 — nice-to-have

### Asymétrie My turn Bloc 1 (7 min) vs Bloc 2 (5 min) — toujours là

- `1-quarto-typst/index.qmd:24` annonce « ~7 min » pour le My turn Bloc 1 (4 concepts : `format: typst`, options, `keep-typ`, `_brand.yml`).
- `2-projets/index.qmd:24` annonce « ~5 min » pour le My turn Bloc 2 (3 concepts plus denses : `_quarto.yml`, `type: book`, orange-book auto-activation).
- Le Bloc 2 introduit deux concepts structurels (projet + book) plus denses que le Bloc 1 en 5 min seulement. La review du matin avait recommandé 7-8 min. La marge de 30 min totale du programme le permet largement.
- Pas bloquant : CD peut équilibrer à l'oral, et le découpage `code-line-numbers="1-2|4-9|10-11|13"` sur la slide `2-projets/2-projets.qmd:34` aide beaucoup à étaler le récit.

### Slide « Saviez-vous que… » Bloc 1 toujours dense

- `1-quarto-typst/1-quarto-typst.qmd:182-198` condense 3 pépites (raw blocks + tableaux gt + `pdf-standard: ua-1`). La review du matin avait noté la densité — toujours d'actualité. Pas critique : les notes presenter `1-quarto-typst/1-quarto-typst.qmd:197` cadrent bien (« 2-3 minutes max, planter des graines »).

### Fragment « Exercice 1 » duplique « Faisons ensemble » — à oraliser

- `1-quarto-typst/1-quarto-typst.qmd:147-160` (Faisons ensemble) puis `1-quarto-typst/1-quarto-typst.qmd:165-176` (Exercice 1) : consigne quasi identique en 4 points. C'est voulu (consigne stable entre démo et exo) mais à l'oral, prévoir un « même consigne, mais cette fois c'est à vous, en autonomie ». Pas dans les notes presenter — à ajouter en 1 ligne pour mémoire CD/Maëlle.

### `linkcolor`, `codefont`, `mathfont` mentionnés mais jamais montrés

- `1-quarto-typst/1-quarto-typst.qmd:160` (notes presenter) : « Mentionner linkcolor, codefont, mathfont en passant. » Mais ces options n'apparaissent ni dans `1-quarto-typst/1-quarto-typst.qmd:65-80` (slide options essentielles) ni dans la correction `exercises/01-document-typst/correction/rapport-starwars.qmd:4-14`. Si CD les cite à l'oral pendant la démo, prévoir 30 sec pour ne pas frustrer les curieux.

## ✅ Forces pédagogiques confirmées

- **Transition Exo 1 → Exo 2 explicitement préparée et exécutée**. Trois canaux concordants :
  - Cliffhanger narratif : `exercises/01-document-typst/starter/rapport-starwars.qmd:82-85` (« il faudrait étendre ce rapport en livre — c'est l'objet du Bloc 2 »).
  - Réutilisation matérielle : starter Exo 2 reprend les mêmes labels (`fig-anatomie-mass`, `tbl-anatomie-mass`, cf. `exercises/02-projet-book/starter/01-anatomie.qmd:18,49`) et étend l'analyse vers `02-origines.qmd` + `conclusion.qmd`.
  - Filet de sécurité explicite : `2-projets/index.qmd:40-42` (« autonome vis-à-vis de l'Exercice 1 ») + fallback `_brand-fallback.yml` documenté `2-projets/index.qmd:109-111`.
- **Charge cognitive Exo 2 réellement maîtrisée**. Le découpage 3 core (12 min) + 2 bonus (3 min) (`2-projets/index.qmd:49-72`) est explicitement positionné « bonus = pour les rapides ». Étape 2 elle-même découpée en 2a/2b (`2-projets/index.qmd:54-55` et `exercises/02-projet-book/README.md:23-24`) — l'apparition de « Annexe A » devient un wow visible plutôt qu'un détail noyé. Slide `2-projets/2-projets.qmd:34` exploite `code-line-numbers="1-2|4-9|10-11|13"` pour étaler la lecture du YAML en 4 beats (cf. notes presenter `:66`).
- **Modèle `_quarto.yml` participant complet** (`2-projets/index.qmd:78-99` et `exercises/02-projet-book/README.md:31-52`). Inclut désormais `execute: { echo: false, warning: false, message: false }` (P2 résolu lors du commit `34e8d0f`) — donc un participant qui copie-colle obtient un rendu visuellement proche de la correction (= condition nécessaire pour la boucle de feedback : « est-ce que mon résultat ressemble à la correction ? »).
- **Boucle de feedback bug `gt` documentée par tous les canaux**. Un participant Windows/macOS qui voit « 1 7 5 » sait quoi faire sans appeler le formateur :
  - Notes presenter slide Bloc 1 (`1-quarto-typst/1-quarto-typst.qmd:162`) et slide Bloc 2 (`2-projets/2-projets.qmd:86`).
  - Notes presenter exo `1-quarto-typst/1-quarto-typst.qmd:179`.
  - Callout participant `2-projets/index.qmd:103-107` et `exercises/02-projet-book/README.md:59-64`.
  - Workaround visible dans la correction Exo 1 `exercises/01-document-typst/correction/rapport-starwars.qmd:61-63` (avec commentaire inline).
- **Rythme M/O/Y respecté dans les deux blocs.** Slide ouverture `1-quarto-typst/1-quarto-typst.qmd:11-37` installe le contrat. Conventions backgrounds confirmées : `#27ae60` Our turn, `#FDC538` Your turn, callouts différenciés. Cohérent entre les 2 decks.
- **Pépites bien dosées et alignées avec le narratif.** Une par bloc, courte, en fin de séquence. Les notes presenter (`1-quarto-typst/1-quarto-typst.qmd:197` et `2-projets/2-projets.qmd:137`) explicitent leur rôle de « fusible » — discipline rare. Pépite « Template partials » reformulée (`2-projets/2-projets.qmd:127`) admet honnêtement que `typst-show.typ` suffit souvent — pas survendu.
- **Arc narratif `.qmd → PDF pro → livre → personnalisé / pérennisé` lisible**. `index.qmd:17-20` pose les 4 questions ; Bloc 1 traite les 2 premières, Bloc 2 traite la 3ᵉ + amorce de la 4ᵉ via les pépites. Star Wars est cohérent bout-à-bout (Jabba/droïdes/Naboo/R2-D2-C-3PO se renvoient les uns aux autres entre Exo 1 et Exo 2 chapitres).
- **Co-animation CD + Maëlle**. Notes presenter denses, riches en heads-up (bug `gt`, problèmes fréquents indentation YAML, repérage participants en peine, gestion des bonus). Maëlle a tout ce qu'il faut pour passer en main si besoin. `1-quarto-typst/1-quarto-typst.qmd` : 8 blocs `::: notes`, `2-projets/2-projets.qmd` : 5 blocs — couverture systématique des moments à enjeu.

## 📝 Évolution depuis la review du matin

**Ce qui s'est amélioré :**

- **Risque #3 (transition Exo 1 → Exo 2 fragile) — résolu.** La review du matin pointait : « un participant qui n'a pas réussi à rendre le PDF Typst de l'Exo 1 ne sait pas s'il peut quand même suivre l'Exo 2 ». Le commit du callout autonomie (`2-projets/index.qmd:40-42`) + le `_brand-fallback.yml` opérationnel (`exercises/02-projet-book/_brand-fallback.yml`) + le starter Exo 2 standalone (`exercises/02-projet-book/starter/`) règlent le sujet. La narration du cliffhanger (`exercises/01-document-typst/starter/rapport-starwars.qmd:85`) renforce sans fragiliser.
- **Charge cognitive Exo 2 — fortement atténuée.** La review du matin signalait « charge cognitive Exo 2 en 15 min ». Le découpage 2a/2b + le modèle `_quarto.yml` complet copiable + le bug `gt` documenté par 4 canaux = la difficulté est désormais bien lissée. Le participant a un patron littéral à recopier en cas de blocage (`2-projets/index.qmd:78-99`).
- **Cohérence FR / vocabulaire / vouvoiement** (sweep matin) : 0 hit résiduel sur tutoiement, brand→charte appliqué, anglicismes prose éliminés (vérifié à grep ciblé).

**Ce qui était déjà bon (et l'est resté) :**

- Scaffolding R figé (`echo: false`) pour maintenir la charge sur Quarto+Typst.
- Star Wars cohérent bout-à-bout, pas de résidu manchots.
- Conventions visuelles M/O/Y systématiques.
- `fig-alt` présent partout.

**Ce qui n'a pas été traité — et reste donc le seul vrai trou pédagogique :**

- **Wrap-up absent** (risque #2 review du matin) : intact. Toujours pas de slide récap fin Bloc 2, pas de slide « Et maintenant ? », pas de slide « Questions ? ». C'est devenu **l'unique** P1 pédagogique restant pour le 16 juin.
- **Objectifs implicites** (risque #1 review du matin) : intact aussi, mais moins critique parce que les pages bloc listent des « concepts couverts » qui font partiellement le job.

**Ce qui aurait pu être pire :**

- Si CD avait reformulé l'Exo 2 comme « 5 étapes obligatoires », au lieu du « 3 core + 2 bonus » actuel, la charge cognitive aurait été insoutenable pour les débutants Quarto en 15 min.
- Si le `_brand-fallback.yml` n'avait pas été ajouté côté `exercises/02-projet-book/`, un participant Bloc 1 raté aurait été coincé à l'étape 3 du Bloc 2 (la charte = le wow visuel le plus fort).
- Si le bug `gt` n'avait pas été documenté côté participant : ~30 % d'utilisateurs Windows/macOS coincés dans une ambiance « ça marche pas, j'appelle le formateur ». La couverture actuelle (4 canaux) est exemplaire.

---

**Conclusion** : matériel pédagogiquement à 95 % prêt. Les 5 % restants tiennent à un wrap-up de 5 min en fin de Bloc 2 — coût faible (1-2 commits), gain de rétention élevé (le moment où le participant se rappelle ce qu'il a appris la semaine d'après). Si CD veut ne traiter qu'une chose avant le 16 juin, c'est ça.
