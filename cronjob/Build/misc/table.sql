
CREATE TABLE stringlog (
    Stringid int NOT NULL AUTO_INCREMENT,
    StringVal varchar(255) NOT NULL,
    PRIMARY KEY (Stringid)
);

INSERT INTO stringlog (StringVal) VALUES ('Hello World!')