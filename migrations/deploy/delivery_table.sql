-- Deploy ocolis:delivery_table to pg

BEGIN;

CREATE TABLE "delivery_man" (
    "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "driver_name" TEXT NOT NULL,
    "vehicle_plate" int NOT NULL,
    "starting_time" timestamptz NOT NULL DEFAULT now(),
    "ending_time" timestamptz
);

ALTER TABLE "package"
ADD COLUMN "delivery_man_id" int REFERENCES "delivery_man" ("id");

INSERT INTO "delivery_man" ("starting_time")
SELECT DISTINCT "expedition_time"
FROM "package";

ALTER TABLE "package"
DROP COLUMN "expedition_time";

COMMIT;

-- correction 
-- CREATE TABLE "expedition" (
--     "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
--     "driver_name" text NOT NULL,
--     "vehicle_plate" text NOT NULL,
--     "starting_time" timestamptz NOT NULL DEFAULT now(),
--     "ending_time" timestamptz
-- );

-- ALTER TABLE "package"
--     ADD COLUMN "expedition_id" int REFERENCES "expedition" ("id");

-- INSERT INTO "expedition" ("driver_name", "vehicle_plate", "starting_time")
-- -- Ce qui suit estr comparable a VALUES , 'NA','2022-07-11 08:00:00'),('NA', 'NA','2022-07-11 09:00:0('NA'0'),('NA', 'NA','2022-07-11 10:00:00')
-- -- Comme les champs driver_name et vehicle_plate sont obligatoire mais que l'on a aucune données historiques pour les indiquer, on ajoute une constante signifiant qu'il manque l'information.
-- SELECT DISTINCT 'NA', 'NA', expedition_time 
-- FROM "package";

-- UPDATE "package" SET
--     expedition_id = (
--         SELECT id FROM "expedition" 
--         WHERE package.expedition_time = expedition.starting_time
--     );

-- ALTER TABLE "package"
--     DROP COLUMN expedition_time;