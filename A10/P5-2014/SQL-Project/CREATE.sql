USE P4;

CREATE TABLE R1 (
       A INT,
       B CHAR(10),
       C CHAR(1),
       D INT,
       E VARCHAR(30),
       PRIMARY KEY (A)
);

CREATE TABLE R2 (
       A INT,
       B CHAR(10),
       C CHAR(1),
       D INT,
       E VARCHAR(30),
       PRIMARY KEY (A, B, C)
);

CREATE TABLE R3 (
       A INT,
       B CHAR(10),
       C CHAR(1),
       D INT,
       E VARCHAR(30),
       PRIMARY KEY (A, B)
);

CREATE TABLE R4 (
       A INT,
       B CHAR(10),
       C CHAR(1),
       D INT,
       E VARCHAR(30),
       PRIMARY KEY (A, B, D)
);

CREATE TABLE R5 (
       A INT,
       B CHAR(10),
       C CHAR(1),
       D INT,
       E VARCHAR(30),
       PRIMARY KEY (A, B, C)
);
