-- Revert ocolis:serial_number_text from pg

BEGIN;

ALTER TABLE package
    ALTER COLUMN serial_number TYPE int;

COMMIT;
