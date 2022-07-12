-- Revert ocolis:delivery_table from pg

BEGIN;

ALTER TABLE "package"
ADD COLUMN "expedition_time" timestamptz;

INSERT INTO "package" ("expedition_time")
SELECT DISTINCT "starting_time"
FROM "delivery_man";
ALTER TABLE "package"
DROP COLUMN "delivery_man_id";

DROP TABLE "delivery_man";

COMMIT;

-- correction
-- ALTER TABLE "package"
--     ADD COLUMN expedition_time timestamptz;

-- UPDATE "package" SET
--     expedition_time = (
--         SELECT starting_time FROM "expedition" 
--         WHERE package.expedition_id = expedition.id
--     );

-- -- En suivant la logique d'inversion d'action dans le revert on serait tenter de supprimer les données de la table expedition de-- mais de tout de façon à la fin on va supprimer la table elle-même, donc pas la peine de s'embêter a supprimer d'abord les données, elles le seront en même temps que la structure
-- /*
-- INSERT INTO "expedition" ("driver_name", "vehicle_plate", "starting_time")
-- SELECT DISTINCT 'NA', 'NA', expedition_time 
-- FROM "package";
-- */

-- ALTER TABLE "package"
--     DROP COLUMN "expedition_id";

-- DROP TABLE "expedition";

