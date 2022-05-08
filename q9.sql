CREATE TABLE IF NOT EXISTS expert
(
    piloteId uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY
        CONSTRAINT fk_id
            REFERENCES utilisateur,

    date     TIMESTAMP                       NOT NULL,
    nouveau  BOOLEAN                         NOT NULL
);