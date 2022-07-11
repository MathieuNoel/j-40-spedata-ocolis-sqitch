# La migration de la muerte :cactus:

La tâche que nous vous confions n'est pas petite : il va falloir mettre en place un vrai système de traçabilité pour O'colis :muscle:

Bon, la bonne nouvelle, c'est que d'ici 15 minutes, le lead dev aura fini son travail et il a accepté de vous filer un petit coup de main pour pas que vous finissiez à 23h endormi sur votre clavier :heart_eyes:

Ça vous laisse le temps de retoucher le MCD, c'est nickel !

Rendez-vous sur Mocodo, c/c le contenu du fichier `ocolis.mcd` et enrichissez-le pour représenter le nouveau système d'information. N'oubliez de représenter les dates qui se sont ajoutées entre temps :wink:

Voilà le brief de ce qu'il faut rajouter :
- On va maintenant garder une trace de toutes les expéditions effectuées par les livreurs de l'entreprise
- Pour chaque expédition, on doit recenser le nom du livreur, la plaque d'immatriculation du véhicule utilisé, date et heure de départ de l'entrepôt, date et heure de retour à l'entrepôt
- Pour les expéditions d'avant cette mise à jour, on va réimporter le peu de données qu'on a dans le listing des colis, c'est-à-dire la date d'expédition (qui correspond donc à la date de départ de l'entrepôt)

## Ah, le lead dev arrive

Bon, il a déjà sa veste sur le dos et on entend qu'il a déjà démarré sa moto pour la faire chauffer sur le parking. Il nous tend un post-it rempli à ras bord d'infos, il va falloir le décrypter :sweat_smile:

```
deploy : crée ta table, pense à la col idtt, nomme les champs driver_name,
vehicle_plate, starting_time et ending_time, le start est NN Dft now() + 
clé étg dans package (nulle si pas dans un camion). Importe les 
expéditions avec un INSERT SELECT DISTINCT de package, ça te permettra de 
faire correspondre les PK-FK avec les dates. Et oublie pas de dropper 
l'expedition_time après
revert : tu reprends le deploy et tu fais à l'envers, +expedition_time tz 
dans package, tu rebalances les dates d'expedition > package et tu drop la 
clé étg. et la table.
y'a de la pizza dans le frigo, a+
```

Allez, courage :wink:

### Un peu d'aide (uniquement si tu bloques)

Déplie les spoilers des termes que tu n'as pas réussi à décrypter ou des points bloquants

<details>
<summary>col idtt</summary>
= colonne identité = GENERATED ALWAYS AS IDENTITY
</details>

<details>
<summary>NN Dft now()</summary>
= NOT NULL DEFAULT now()
</details>

<details>
<summary>clé étg.</summary>
= FK = clé étrangère (Foreign Key en anglais)
</details>

<details>
<summary>PK-FK</summary>
= Primary Key - Foreign Key
</details>

<details>
<summary>+expedition_time tz</summary>
= nouvele colonne expedition_time de type <em>timestamptz</em>
</details>

<details>
<summary>y'a de la pizza dans le frigo</summary>
= prends ton temps, c'est un challenge un peu long mais pas spécialement difficile si tu le découpes bien (et oublie pas de manger)
</details>

<details>
<summary>INSERT SELECT DISTINCT</summary>
Pour importer des données d'une table à une autre, il est possible de les sélectionner dans une table pour aller les insérer dans l'autre, mais il faut que le format corresponde parfaitement. Si certaines infos ne sont pas disponibles dans la table source, il est possible d'écrire des valeurs constantes (quand vous écrivez `SELECT 'coucou';`, <em>'coucou'</em> est une constante).

```sql
INSERT INTO pokemon (nom, génération, url_image)
SELECT nom, 'on verra plus tard', illustration
FROM monstres_en_tout_genre
WHERE origine = 'japon'
AND cri = nom;
```

Le SELECT filtre parmi une (ou plusieurs) table(s) source et ne récupère que certains champs. Ces champs correspondent pile poil aux champs nécessaires à l'insertion dans la table de destination.

Un SELECT DISTINCT, c'est comme un SELECT mais s'il y a des valeurs identiques, on n'en garde qu'un exemplaire.

```sql
SELECT DISTINCT type -- ne retourne qu'une seule fois chaque type différent
FROM pokemon; -- présent dans la table pokemon
```

Bon, on est d'accord qu'idéalement, la table pokemon serait liée à une table type pour éviter les répétitions, mais c'est pour l'exemple :wink:

</details>
