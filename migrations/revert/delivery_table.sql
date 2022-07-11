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
