CREATE TABLE experts (
                            piloteId uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
                            FOREIGN KEY (piloteid ) REFERENCES pilote.id


);
