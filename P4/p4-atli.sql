CREATE TABLE People (
    ID SERIAL,
    name VARCHAR(255),
    address VARCHAR (255),
    phone_number VARCHAR(7),
    date_of_birth DATE,
    date_of_death DATE DEFAULT NULL,
    PRIMARY KEY(ID),
);

CREATE TABLE Members (
    peopleID INT,
    date_of_membership DATE,
    FOREIGN KEY (peopleID) REFERENCES People(ID),
    UNIQUE(peopleID),
    PRIMARY KEY(peopleID),
);

CREATE TABLE Enemies (
    peopleID INT,
    FOREIGN KEY (peopleID) REFERENCES People(ID),
    UNIQUE(peopleID),
    PRIMARY KEY(peopleID),
);

CREATE TABLE Linkings (
    ID SERIAL,
    name VARCHAR(255),
    type VARCHAR(255),
    description VARCHAR(255),
    PRIMARY KEY(ID),
);

CREATE TABLE PeopleLinkingConnection (
    linkingID INT,
    peopleID INT,
    FOREIGN KEY (linkingID) REFERENCES Linkings(ID),
    FOREIGN KEY (peopleID) REFERENCES People(ID),
    UNIQUE(linkingID, peopleID),
    PRIMARY KEY (linkingID, peopleID),
);

CREATE TABLE Opponents (
    memberID INT,
    enemyID INT,
    start_date DATE,
    end_date DATE DEFAULT NULL,
    FOREIGN KEY (memberID) REFERENCES Members(peopleID),
    FOREIGN KEY (enemyID) REFERENCES Enemies(peopleID),
    UNIQUE(memberID, enemyID),
    PRIMARY KEY (memberID, enemyID),
);

CREATE TABLE Assets (
    name VARCHAR(255),
    details VARCHAR(255),
    potential VARCHAR(255),
    UNIQUE(name),
    PRIMARY KEY (name),
);

CREATE TABLE Roles (
    ID SERIAL,
    title VARCHAR(255),
    PRIMARY KEY (ID),
);