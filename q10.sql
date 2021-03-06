CREATE TABLE IF NOT EXISTS discussion_group
(
    subject       TEXT UNIQUE             NOT NULL PRIMARY KEY,
    creation_date TIMESTAMP DEFAULT NOW() NOT NULL
);
CREATE TABLE IF NOT EXISTS discussion_group_member
(
    aeroportCode             VARCHAR(8)              NOT NULL,
    date_joined              TIMESTAMP DEFAULT NOW() NOT NULL,
    discussion_group_subject TEXT                    NOT NULL,
    CONSTRAINT fk_discussion_group
        FOREIGN KEY (discussion_group_subject)
            REFERENCES discussion_group (subject),
    CONSTRAINT fk_member
        FOREIGN KEY (aeroportCode)
            REFERENCES aéroport (code),
    UNIQUE (aeroportCode, discussion_group_subject),
    PRIMARY KEY (aeroportCode, discussion_group_subject)
);

INSERT INTO discussion_group (subject)
VALUES ('Mobilité'),
       ('Economie'),
       ('Ecologie');

INSERT INTO discussion_group_member (aeroportCode, discussion_group_subject)
VALUES ('SPN', 'Ecologie'),
       ('SPN', 'Economie'),
       ('SPN', 'Mobilité');

