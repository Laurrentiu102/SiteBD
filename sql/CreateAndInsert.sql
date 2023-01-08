DROP SCHEMA IF EXISTS cabinet_avocatura;
CREATE SCHEMA cabinet_avocatura;
USE cabinet_avocatura;

CREATE TABLE Persoana(
    id_p INTEGER,
    nume VARCHAR(50),
    email VARCHAR(50),
    adresa VARCHAR(50)
);

CREATE TABLE Conturi(
    id INTEGER,
    id_p INTEGER,
    parola VARCHAR(200)
);

CREATE TABLE Cookies(
	id INTEGER,
    id_p INTEGER,
    selector VARCHAR(200),
    validator VARCHAR(200),
    data DATETIME
);

CREATE TABLE Contract_j(
	id_cj INTEGER,
	data DATE,
	obiect VARCHAR(50),
	onorar INTEGER,
	nr_pagini INTEGER,
	id_client INTEGER,
	id_avocat INTEGER
);

CREATE TABLE Contract_m(
	id_cm INTEGER,
	data DATE,
	functie VARCHAR(50),
	salar_baza INTEGER,
	comision FLOAT(2),
	id_angajat INTEGER 
);

CREATE TABLE Rata(
	id_cj INTEGER,
	id_r INTEGER,
	data DATE,
	suma INTEGER
);

ALTER TABLE Persoana
ADD CONSTRAINT pk_persoana_id_p PRIMARY KEY (id_p);

ALTER TABLE Conturi
ADD CONSTRAINT pk_conturi_id PRIMARY KEY (id);

ALTER TABLE Conturi
MODIFY id INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE Conturi
ADD CONSTRAINT fk_Conturi_id_Persoana_id_p
FOREIGN KEY (id_p) REFERENCES Persoana(id_p);

ALTER TABLE Cookies
ADD CONSTRAINT pk_Cookies_id PRIMARY KEY (id);

ALTER TABLE Cookies
MODIFY id INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE Cookies
ADD CONSTRAINT fk_Cookies_id_p_Conturi_id_p
FOREIGN KEY (id_p) REFERENCES Conturi(id_p);

ALTER TABLE Cookies
ADD CONSTRAINT Cookies_selector_unic UNIQUE(selector);

ALTER TABLE Contract_j
ADD CONSTRAINT pk_contract_j_id_cj PRIMARY KEY (id_cj);

ALTER TABLE Contract_j
ADD CONSTRAINT fk_Contract_j_id_client
FOREIGN KEY (id_client) REFERENCES Persoana(id_p);

ALTER TABLE Contract_j
ADD CONSTRAINT fk_Contract_j_id_avocat
FOREIGN KEY (id_avocat) REFERENCES Persoana(id_p);

ALTER TABLE Contract_m
ADD CONSTRAINT pk_contract_m_id_cm PRIMARY KEY (id_cm);

ALTER TABLE Contract_m
ADD CONSTRAINT fk_Contract_m_id_angajat
FOREIGN KEY (id_angajat) REFERENCES Persoana(id_p);

ALTER TABLE Rata
ADD CONSTRAINT fk_rata_id_cj
FOREIGN KEY (id_cj) REFERENCES Contract_j(id_cj);

ALTER TABLE Rata
ADD CONSTRAINT pk_rata_id_r_id_cj PRIMARY KEY (id_r,id_cj);

ALTER TABLE Persoana
ADD telefon VARCHAR(50);

ALTER TABLE Contract_j
ADD CONSTRAINT verifica_obiect CHECK(obiect in ('actiune civila','actiune penala'));

ALTER TABLE Contract_j
ADD CONSTRAINT verifica_onorar CHECK(onorar>500 OR obiect<>'actiune penala');

INSERT INTO Persoana VALUES(2,'Neghina Laurentiu','neghinalaurentiu@gmail.com','Strada Plopului','0722131321');
INSERT INTO Persoana VALUES(3,'Fraticiu Andreas','fraticiuandreas@gmail.com','Strada Ceahlau','0722785454');
INSERT INTO Persoana VALUES(4,'Dance Andreea','danceandreea@gmail.com','Strada Soarelui','0722512324');
INSERT INTO Persoana VALUES(5,'Nistor Gabriel','nistorgabriel@gmail.com','Strada Observatorului','0722085481');
INSERT INTO Persoana VALUES(6,'Pop Cornel','popcornel@gmail.com','Strada Decebal','0722859842');
INSERT INTO Persoana VALUES(7,'Ghilea Dan Lucian','ghileadanlucian@gmail.com','Strada Republicii','0722758959');
INSERT INTO Persoana VALUES(8,'Muresan Alexandru','muresanalexandru@gmail.com','Strada Oituz','0722856341');
INSERT INTO Persoana VALUES(9,'Iakabos David','iakabosdavid@gmail.com','Strada 1 Decembrie','0722674743');

INSERT INTO Contract_m VALUES(2,STR_TO_DATE('01-06-2022',"%d-%m-%Y"),'avocat',5000,12.0,2);
INSERT INTO Contract_m VALUES(3,STR_TO_DATE('25-08-2021',"%d-%m-%Y"),'avocat',7000,7.0,3);
INSERT INTO Contract_m VALUES(4,STR_TO_DATE('12-01-2020',"%d-%m-%Y"),'avocat',4000,15.0,4);
INSERT INTO Contract_m VALUES(5,STR_TO_DATE('1-01-2020',"%d-%m-%Y"),'angajat',7000,15.0,5);
INSERT INTO Contract_m VALUES(6,STR_TO_DATE('21-01-2022',"%d-%m-%Y"),'angajat',4000,8.0,8);
INSERT INTO Contract_m VALUES(7,STR_TO_DATE('15-01-2022',"%d-%m-%Y"),'angajat',4000,12.0,9);

INSERT INTO Contract_j VALUES(1,STR_TO_DATE('01-10-2022',"%d-%m-%Y"),'actiune penala',600,4,7,2);
INSERT INTO Contract_j VALUES(2,STR_TO_DATE('05-10-2022',"%d-%m-%Y"),'actiune penala',1000,4,6,3);
INSERT INTO Contract_j VALUES(3,STR_TO_DATE('10-10-2022',"%d-%m-%Y"),'actiune civila',1400,4,5,4);
INSERT INTO Contract_j VALUES(4,STR_TO_DATE('20-11-2022',"%d-%m-%Y"),'actiune civila',300,4,6,3);
INSERT INTO Contract_j VALUES(5,STR_TO_DATE('30-09-2022',"%d-%m-%Y"),'actiune civila',1100,4,5,3);
INSERT INTO Contract_j VALUES(6,STR_TO_DATE('01-01-2021',"%d-%m-%Y"),'actiune civila',1200,4,7,2);
INSERT INTO Contract_j VALUES(7,STR_TO_DATE('31-12-2020',"%d-%m-%Y"),'actiune penala',1300,4,6,4);

INSERT INTO Rata VALUES(1,1,STR_TO_DATE('01-10-2022',"%d-%m-%Y"),600);
INSERT INTO Rata VALUES(2,2,STR_TO_DATE('05-10-2022',"%d-%m-%Y"),1000);
INSERT INTO Rata VALUES(3,3,STR_TO_DATE('10-08-2022',"%d-%m-%Y"),700);
INSERT INTO Rata VALUES(4,4,STR_TO_DATE('25-11-2022',"%d-%m-%Y"),300);
INSERT INTO Rata VALUES(5,5,STR_TO_DATE('30-09-2022',"%d-%m-%Y"),600);
INSERT INTO Rata VALUES(5,6,STR_TO_DATE('2-10-2022',"%d-%m-%Y"),100);

CREATE VIEW Clienti_John_Doe AS
SELECT c.id_client, b.nume nume_client, b.email, b.adresa, id_cj, data, obiect,
 onorar, nr_pagini
FROM Persoana a, Contract_j c, Persoana b
WHERE a.nume = 'John Doe' AND
 c.id_avocat = a.id_p AND
 b.id_p = c.id_client;
 
 CREATE EVENT cookie_delete_hourly
    ON SCHEDULE
      EVERY 1 HOUR
    COMMENT 'Sterge cookieuri mai vechi de o ora'
    DO
      DELETE FROM cookies;

DROP USER IF EXISTS 'SiteBD'@'localhost';

CREATE USER IF NOT EXISTS'SiteBD'@'localhost'
IDENTIFIED BY 'SiteBD';

GRANT SELECT,INSERT,DELETE,UPDATE,EXECUTE
ON cabinet_avocatura.*
TO 'SiteBD'@'localhost';