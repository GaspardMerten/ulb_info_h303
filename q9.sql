CREATE TABLE IF NOT EXISTS experts
(
    piloteId uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY
        CONSTRAINT fk_id
            REFERENCES utilisateur,

    date     TIMESTAMP                       NOT NULL,
    nouveau  BOOLEAN                         NOT NULL
);

CREATE TEMPORARY TABLE IF NOT EXISTS tmp
(
    raw_data TEXT      NOT NULL,
    date     TIMESTAMP NOT NULL
);


\COPY tmp (raw_data, DATE) FROM 'data.csv' DELIMITER ',' CSV;

INSERT INTO experts (piloteId, date, nouveau)

SELECT SPLIT_PART(raw_data, '--', 2)::uuid,
       date,
       CASE WHEN SPLIT_PART(raw_data, '--', 1) = 'new-expert' THEN TRUE ELSE FALSE END
FROM tmp
;

DROP TABLE tmp;