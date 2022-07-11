-- Deploy ocolis:serial_number_text to pg

BEGIN;

ALTER TABLE package
    ALTER COLUMN serial_number TYPE text;

COMMIT;
