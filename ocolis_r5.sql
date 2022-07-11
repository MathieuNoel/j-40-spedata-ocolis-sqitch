BEGIN;

ALTER TABLE package
    ADD COLUMN request_time timestamptz NOT NULL DEFAULT now(),
    ADD COLUMN expedition_time timestamptz,
    ADD COLUMN delivered_time timestamptz;

COMMIT;