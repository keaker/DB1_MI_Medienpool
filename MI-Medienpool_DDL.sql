-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                      

-- DDL SQL
-- ***********************************************************************************

-- Loeschen aller Constraints
-- Foreing Key's
ALTER TABLE geraete_verliehen DROP CONSTRAINT benutzer_matrnr_fk;
ALTER TABLE geraete_verliehen DROP CONSTRAINT geraete_verliehen_id_fk;
ALTER TABLE geraete_verfuegbar DROP CONSTRAINT geraete_verfuegbar_id_fk;
ALTER TABLE geraete_reserviert DROP CONSTRAINT reservierung_geraete_id_fk;
ALTER TABLE verstoesse DROP CONSTRAINT verstoesse_benutzer_matrnr_fk;
ALTER TABLE verstoesse DROP CONSTRAINT verstossart_id_fk;
ALTER TABLE geraete DROP CONSTRAINT geraeteart_id_fk;
ALTER TABLE geraete_reserviert DROP CONSTRAINT geraete_reserviert_matrnr_fk;
ALTER TABLE geraete_inreparatur DROP CONSTRAINT geraete_inreparatur_id_fk;

-- Check 
ALTER TABLE benutzer DROP CONSTRAINT benutzer_gesperrt_check;
ALTER TABLE geraete DROP CONSTRAINT status_check;
ALTER TABLE geraetearten DROP CONSTRAINT geraeteart_id_check;
ALTER TABLE geraetearten DROP CONSTRAINT geraeteart_check;
ALTER TABLE verstossarten DROP CONSTRAINT verstossarten_id_check;
ALTER TABLE verstossarten DROP CONSTRAINT verstossart_beschreibung_check;

-- Primary Key's
ALTER TABLE benutzer DROP CONSTRAINT benutzer_matrnr_pk;
ALTER TABLE geraete_verliehen DROP CONSTRAINT verleih_id_pk;
ALTER TABLE geraetearten DROP CONSTRAINT geraeteart_id_pk;
ALTER TABLE verstossarten DROP CONSTRAINT verstossarten_id_pk;
ALTER TABLE geraete DROP CONSTRAINT geraete_id_pk;
ALTER TABLE geraete_inreparatur DROP CONSTRAINT reparatur_id_pk;

-- Trigger
DROP TRIGGER trg_verstoesse_insert_1;
DROP TRIGGER trg_insert_status_1;
DROP TRIGGER trg_insert_status_2;
DROP TRIGGER trg_insert_status_3;

-- Loeschen aller Tabellen fuer den Restart damit keine Komplikationen auftreten
DROP TABLE geraetearten;
DROP TABLE geraete;
DROP TABLE benutzer;
DROP TABLE geraete_verliehen;
DROP TABLE geraete_verfuegbar;
DROP TABLE geraete_reserviert;
DROP TABLE verstossarten;
DROP TABLE verstoesse;
DROP TABLE geraete_inreparatur;

-- Erstellung aller Tabellen, Indizes, Trigger und Contraints
CREATE TABLE geraetearten (
geraeteart_id INTEGER NOT NULL,
geraeteart VARCHAR2(60) NOT NULL
);

CREATE TABLE geraete (
geraete_id INTEGER GENERATED ALWAYS AS IDENTITY,
geraeteart_id INTEGER NOT NULL,
beschreibung VARCHAR2(300) DEFAULT 'Keine Beschreibung verfuegbar' NOT NULL,
zubehoer VARCHAR2(300) DEFAULT 'Kein Zubehoer verfuegbar' NOT NULL,
status VARCHAR2(20) DEFAULT 'Verfuegbar' NOT NULL
);

CREATE TABLE benutzer (
benutzer_matrnr NUMBER(5),
benutzer_name VARCHAR2(60),
benutzer_verstosspunkte FLOAT DEFAULT 0,
gesperrt VARCHAR2(4) DEFAULT 'Nein'
);

CREATE TABLE geraete_verfuegbar(
verfuegbar_id INTEGER GENERATED ALWAYS AS IDENTITY,
geraete_id INTEGER NOT NULL
);

CREATE TABLE geraete_verliehen (
verleih_id INTEGER GENERATED ALWAYS AS IDENTITY,
benutzer_MatrNr NUMBER(5) NOT NULL,
verliehen_von DATE NOT NULL,
verliehen_bis DATE NOT NULL,
geraete_id INTEGER NOT NULL
);

CREATE TABLE geraete_inreparatur(
reparatur_id INTEGER GENERATED ALWAYS AS IDENTITY,
geraete_id INTEGER
);

CREATE TABLE geraete_reserviert (
reservierung_id INTEGER GENERATED ALWAYS AS IDENTITY,
benutzer_matrnr NUMBER(5) NOT NULL,
reserviert_von DATE NOT NULL,
reserviert_bis DATE NOT NULL,
geraete_id INTEGER NOT NULL
);

CREATE TABLE verstossarten(
verstossart_id INTEGER, 
verstossart_beschreibung VARCHAR2(100),
verstossart_punkte FLOAT NOT NULL
);

CREATE TABLE verstoesse(
verstoesse_id INTEGER GENERATED ALWAYS AS IDENTITY,
verstossart_id INTEGER,
benutzer_matrnr NUMBER(5) NOT NULL
);

-- Erstellung der Contraints und Indizes
-- Indizies
CREATE INDEX geraete_id_index ON geraete(geraete_id);

-- Check's
ALTER TABLE benutzer ADD CONSTRAINT benutzer_gesperrt_check CHECK (gesperrt IN('Ja', 'Nein'));
ALTER TABLE geraete ADD CONSTRAINT status_check CHECK (status IN ('Verfuegbar','Ausgeliehen','In Reparatur','Reserviert'));
ALTER TABLE geraetearten ADD CONSTRAINT geraeteart_id_check CHECK (geraeteart_id IN (1, 2, 3, 4, 5));
ALTER TABLE geraetearten ADD CONSTRAINT geraeteart_check CHECK  (geraeteart IN ('Laptop', 'Wearable', 'Smartphone', 'Tablet', 'Sonstiges'));
ALTER TABLE verstossarten ADD CONSTRAINT verstossarten_id_check CHECK (verstossart_id IN (1 ,2 ,3));
ALTER TABLE verstossarten ADD CONSTRAINT verstossart_beschreibung_check CHECK (verstossart_beschreibung in ('Leihdauer ueberzogen', 'Geraet defekt zurueckgebracht', 'Geraet verkratzt/beschaedigt'));

-- Primary Key's
ALTER TABLE benutzer ADD CONSTRAINT benutzer_matrnr_pk PRIMARY KEY (benutzer_matrnr);
ALTER TABLE geraete_verliehen ADD CONSTRAINT verleih_id_pk PRIMARY KEY (verleih_id);
ALTER TABLE geraetearten ADD CONSTRAINT geraeteart_id_pk PRIMARY KEY (geraeteart_id);
ALTER TABLE verstossarten ADD CONSTRAINT verstossarten_id_pk PRIMARY KEY (verstossart_id);
ALTER TABLE geraete ADD CONSTRAINT geraete_id_pk PRIMARY KEY (geraete_id);
ALTER TABLE geraete_inreparatur ADD CONSTRAINT reparatur_id_pk PRIMARY KEY (reparatur_id);

-- Foreign Key's
ALTER TABLE geraete_verliehen ADD CONSTRAINT benutzer_matrnr_fk FOREIGN KEY (benutzer_matrnr) REFERENCES benutzer(benutzer_matrnr);
ALTER TABLE geraete_verliehen ADD CONSTRAINT geraete_verliehen_id_fk FOREIGN KEY (geraete_id) REFERENCES geraete(geraete_id);
ALTER TABLE geraete_verfuegbar ADD CONSTRAINT geraete_verfuegbar_id_fk FOREIGN KEY (geraete_id) REFERENCES geraete (geraete_id);
ALTER TABLE geraete_reserviert ADD CONSTRAINT reservierung_geraete_id_fk FOREIGN KEY (geraete_id) REFERENCES geraete (geraete_id); -- ?
ALTER TABLE verstoesse ADD CONSTRAINT verstoesse_benutzer_matrnr_fk FOREIGN KEY (benutzer_matrnr) REFERENCES benutzer (benutzer_matrnr);
ALTER TABLE geraete ADD CONSTRAINT geraeteart_id_fk FOREIGN KEY (geraeteart_id) REFERENCES geraetearten (geraeteart_id);
ALTER TABLE verstoesse ADD CONSTRAINT verstossart_id_fk FOREIGN KEY (verstossart_id) REFERENCES verstossarten (verstossart_id);
ALTER TABLE geraete_reserviert ADD CONSTRAINT geraete_reserviert_matrnr_fk FOREIGN KEY (benutzer_matrnr) REFERENCES benutzer (benutzer_matrnr);
ALTER TABLE geraete_inreparatur ADD CONSTRAINT geraete_inreparatur_id_fk FOREIGN KEY (geraete_id) REFERENCES geraete (geraete_id);

-- Unique
ALTER TABLE benutzer ADD UNIQUE (benutzer_name);

-- Trigger
CREATE OR REPLACE TRIGGER trg_verstoesse_insert_1
  AFTER INSERT ON verstoesse
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  b_verstosspunkte INTEGER;
  b_matrnr INTEGER;
  v_verstosspunkte INTEGER;
BEGIN
  SELECT benutzer_verstosspunkte, benutzer_matrnr
  INTO b_verstosspunkte, b_matrnr
  FROM benutzer
  WHERE benutzer_matrnr = :NEW.benutzer_matrnr;
  SELECT verstossart_punkte
  INTO v_verstosspunkte
  FROM verstossarten
  WHERE verstossart_id = :NEW.verstossart_id;
  
  UPDATE benutzer SET benutzer_verstosspunkte = b_verstosspunkte + v_verstosspunkte 
  WHERE benutzer_matrnr = b_matrnr;
  UPDATE benutzer SET gesperrt = 'Ja' WHERE benutzer_verstosspunkte > 9;
END;
/


CREATE OR REPLACE TRIGGER trg_status_update_1
  AFTER UPDATE OF status ON geraete
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  IF (:NEW.status = 'Verfuegbar') THEN
    INSERT INTO geraete_verfuegbar (geraete_id)
      VALUES (:NEW.geraete_id);
    DElETE FROM geraete_inreparatur
      WHERE geraete_id = :NEW.geraete_id;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_insert_status_1
  AFTER INSERT ON geraete_verliehen
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  UPDATE geraete SET status = 'Ausgeliehen' WHERE geraete_id = :NEW.geraete_id;
END;
/

CREATE OR REPLACE TRIGGER trg_insert_status_2
  AFTER INSERT ON geraete_reserviert
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  UPDATE geraete SET status = 'Reserviert' WHERE geraete_id = :NEW.geraete_id;
END;
/

CREATE OR REPLACE TRIGGER trg_insert_status_3
  AFTER INSERT ON geraete_inreparatur
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
BEGIN
  UPDATE geraete SET status = 'In Reparatur' WHERE geraete_id = :NEW.geraete_id;
END;

