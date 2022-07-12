-- Revert ocolis:domain from pg

BEGIN;

DROP DOMAIN "vehicle_plate";

DROP DOMAIN "postal_code";

COMMIT;
