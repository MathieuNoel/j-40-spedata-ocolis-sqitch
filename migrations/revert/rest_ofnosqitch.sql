-- Revert ocolis:rest_of_nosqitch from pg

BEGIN;

-- afin de créer un revert répidement on inverse d'une part l'ordre de préossupation et le sens des instructions

ALTER TABLE package
    DROP COLUMN request_time,
    DROP COLUMN expedition_time,
    DROP COLUMN delivered_time;

-- Ces colonnes on va les supprimer de tout de façon donc pas la peine de s'embêter a inverser cette requête
/*
ALTER TABLE package
    ALTER COLUMN width DROP DEFAULT,
    ALTER COLUMN depth DROP DEFAULT;
*/

ALTER TABLE package
    DROP COLUMN width,
    DROP COLUMN depth;

ALTER TABLE package
    RENAME COLUMN height TO volume;


COMMIT;
