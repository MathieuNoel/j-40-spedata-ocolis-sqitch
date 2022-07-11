BEGIN;

ALTER TABLE package
    -- A partir du moment on l'on décide de renommer une colonne d'une table, on ne peut faire QUE cela.
    RENAME COLUMN volume TO height;

ALTER TABLE package
    -- Contrairement au fait d'ajouter une colonne qui permet de le faire pluqieurs fois au sein de la même requête.
    ADD COLUMN width int NOT NULL DEFAULT 1,
    -- Ici on ajoute une valeur par défaut histoire que tous les enregistrement possède la valeur 1 au moment de la migration. Par contre cette caractéristique n'est pas une règle logique pour nos données. Un colis ne DOIT pas avoir de taille par défaut.
    -- Par contre le fait dans utilisé une, nous permet de modifier automatiquement les enregistrement déjà existant (ce qui est très pratique)
    ADD COLUMN depth int NOT NULL DEFAULT 1;

-- Pour régler ce souci de valeur par défaut, on après modification de tous les enregistrement, à travers la requête précédente, supprimer les valeurs par défauts des 2 nouveaux champs.
-- Le fait de supprimer la valeur par défaut ne supprimera pas la valeur 1 des champs des enregistrements.
ALTER TABLE package
    ALTER COLUMN width DROP DEFAULT,
    ALTER COLUMN depth DROP DEFAULT;

COMMIT;