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
