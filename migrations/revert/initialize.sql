-- Revert ocolis:initialize from pg

BEGIN;

-- Dans un revert on met les instructions qui permettent de revenir en arrière sur cette étape. Ici on est sûr que les tables existent, donc pas la peine d'ajouter "IF EXISTS"
DROP TABLE package, place;

COMMIT;
