-- Verify ocolis:delivery_table on pg

BEGIN;

INSERT INTO "delivery_man" (    
    "driver_name" ,
    "vehicle_plate",
    "starting_time",
    "ending_time"
) VALUES (    
    'NULL',-- NULL
    252623, -- NULL
    now(), -- NULL
    NULL   -- 'string'
);


ROLLBACK;
