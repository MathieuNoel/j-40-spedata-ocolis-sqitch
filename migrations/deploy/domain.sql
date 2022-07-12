-- Deploy ocolis:domain to pg

BEGIN;

CREATE DOMAIN plate AS text
    CHECK ( VALUE ~ '[A-Z]{2}-\d{3}-[A-Z]{2}' );


CREATE DOMAIN postal AS text
    CHECK ( VALUE ~ '^\d{5}$' ); 

ALTER TABLE delivery_man
    ALTER COLUMN "vehicle_plate" TYPE plate;

ALTER TABLE place
    ALTER COLUMN "postal_code" TYPE postal;

COMMIT;
