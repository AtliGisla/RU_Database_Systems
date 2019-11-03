CREATE TABLE Gender (
       gender CHAR(1),
       description VARCHAR(10)
);

CREATE TABLE People (
       ID INT,
       name VARCHAR(50),
       gender CHAR(1),
       height FLOAT
);

CREATE TABLE Sports (
       ID INT,
       name VARCHAR(50),
       record FLOAT
);

CREATE TABLE Competitions (
       ID INT,
       place VARCHAR(50),
       held DATE
);

CREATE TABLE Results (
       peopleID INT,
       competitionID INT,
       sportID INT,
       result FLOAT
);
