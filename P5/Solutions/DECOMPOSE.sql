--Rentals

DROP TABLE IF EXISTS Rentals_PID_HID_S;
DROP TABLE IF EXISTS Rentals_HID_HS_HZ;
DROP TABLE IF EXISTS Rentals_HZ_HC;
DROP TABLE IF EXISTS Rentals_PID_PN;

CREATE TABLE Rentals_HZ_HC (
    HZ INTEGER NOT NULL,
    HC CHARACTER VARYING NOT NULL,
    PRIMARY KEY (HZ)
);

CREATE TABLE Rentals_PID_PN (
    PID INTEGER NOT NULL,
    PN CHARACTER VARYING NOT NULL,
    PRIMARY KEY (PID)
);

CREATE TABLE Rentals_HID_HS_HZ (
    HID INTEGER NOT NULL,
    HS CHARACTER VARYING NOT NULL,
    HZ INTEGER NOT NULL,
    PRIMARY KEY (HID),
    FOREIGN KEY (HZ) REFERENCES Rentals_HZ_HC(HZ)
);

CREATE TABLE Rentals_PID_HID_S (
    PID INTEGER NOT NULL,
    HID INTEGER NOT NULL,
    S INTEGER NOT NULL,
    PRIMARY KEY (PID, HID),
    FOREIGN KEY (PID) REFERENCES Rentals_PID_PN(PID),
    FOREIGN KEY (HID) REFERENCES Rentals_HID_HS_HZ(HID)
);

--Coffees

DROP TABLE IF EXISTS Coffees_DID_HID_CID;
DROP TABLE IF EXISTS Coffees_DID_DN_DS;
DROP TABLE IF EXISTS Coffees_CID_CN_CM;

CREATE TABLE Coffees_DID_DN_DS (
    DID INTEGER NOT NULL,
    DN CHARACTER VARYING NOT NULL,
    DS CHARACTER VARYING NOT NULL,
    PRIMARY KEY (DID)
);

CREATE TABLE Coffees_CID_CN_CM (
    CID INTEGER NOT NULL,
    CN CHARACTER VARYING NOT NULL,
    CM CHARACTER VARYING NOT NULL,
    PRIMARY KEY (CID)
);

CREATE TABLE Coffees_DID_HID_CID (
    DID INTEGER NOT NULL,
    HID INTEGER NOT NULL,
    CID INTEGER NOT NULL,
    PRIMARY KEY (DID, HID, CID),
    FOREIGN KEY (DID) REFERENCES Coffees_DID_DN_DS(DID),
    FOREIGN KEY (CID) REFERENCES Coffees_CID_CN_CM(CID)
);

--Projects

DROP TABLE IF EXISTS Projects_ID_PID_SID;
DROP TABLE IF EXISTS Projects_SID_SN;
DROP TABLE IF EXISTS Projects_PID_PN;
DROP TABLE IF EXISTS Projects_ID_MID_MN;

CREATE TABLE Projects_SID_SN (
    SID INTEGER NOT NULL,
    SN CHARACTER VARYING NOT NULL,
    PRIMARY KEY (SID)
);

CREATE TABLE Projects_PID_PN (
    PID INTEGER NOT NULL,
    PN CHARACTER VARYING NOT NULL,
    PRIMARY KEY (PID)
);

CREATE TABLE Projects_ID_MID_MN (
    ID INTEGER NOT NULL,
    MID INTEGER NOT NULL,
    MN CHARACTER VARYING NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE Projects_ID_PID_SID (
    ID INTEGER NOT NULL,
    PID INTEGER NOT NULL,
    SID INTEGER NOT NULL,
    PRIMARY KEY (ID, PID, SID),
    FOREIGN KEY (ID) REFERENCES Projects_ID_MID_MN(ID),
    FOREIGN KEY (PID) REFERENCES Projects_PID_PN(PID),
    FOREIGN KEY (SID) REFERENCES Projects_SID_SN(SID)
);

--Customers

DROP TABLE IF EXISTS Customers_CID_CN_CS_CNr_CZ_EID;
DROP TABLE IF EXISTS Customers_CZ_CC;

CREATE TABLE Customers_CZ_CC (
    CZ INTEGER NOT NULL,
    CC CHARACTER VARYING NOT NULL,
    PRIMARY KEY (CZ)
);

CREATE TABLE Customers_CID_CN_CS_CNr_CZ_EID (
    CID INTEGER NOT NULL,
    CN CHARACTER VARYING NOT NULL, 
    CS CHARACTER VARYING NOT NULL, 
    CNr INTEGER NOT NULL,
    CZ INTEGER NOT NULL,
    EID INTEGER NOT NULL,
    PRIMARY KEY (CID),
    FOREIGN KEY (CZ) REFERENCES Customers_CZ_CC(CZ)
);