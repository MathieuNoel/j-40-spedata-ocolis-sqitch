-- Deploy ocolis:rest_of_nosqitch to pg

BEGIN;

ALTER TABLE package
    ADD UNIQUE (serial_number);

ALTER TABLE package
    RENAME COLUMN volume TO height;

ALTER TABLE package
    ADD COLUMN width int NOT NULL DEFAULT 1,
    ADD COLUMN depth int NOT NULL DEFAULT 1;
ALTER TABLE package
    ALTER COLUMN width DROP DEFAULT,
    ALTER COLUMN depth DROP DEFAULT;

ALTER TABLE package
    ADD COLUMN request_time timestamptz NOT NULL DEFAULT now(),
    ADD COLUMN expedition_time timestamptz,
    ADD COLUMN delivered_time timestamptz;


COMMIT;
