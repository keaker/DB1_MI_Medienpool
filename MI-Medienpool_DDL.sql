-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                      

-- DDL SQL
-- ***********************************************************************************

-- L�schen aller Constraints
-- Foreing Key's
ALTER table geraete_verliehen drop constraint benutzer_matrnr_fk;
alter table geraete_verliehen drop constraint geraete_verliehen_id_fk;
alter table geraete_status drop constraint geraete_status_id_fk;
alter table geraete_reserviert drop constraint reservierung_geraete_id_fk;
--Alter table reservierung drop constraint reservierung_geraete_id_fk;
alter table verstoesse drop constraint verstoesse_benutzer_matrnr_fk;
alter table verstoesse drop constraint verstossart_id_fk;
alter table geraete drop constraint geraeteart_id_fk;
alter table geraete_reserviert drop constraint geraete_reserviert_matrnr_fk;

alter table geraete_inreparatur drop constraint geraete_inreparatur_id_fk;





-- Check 
alter table benutzer drop constraint benutzer_gesperrt_check;
Alter table geraete_status drop constraint status_check;
alter table geraetearten drop constraint geraeteart_id_check;
alter table geraetearten drop constraint geraeteart_check;
alter table verstossarten drop constraint verstossarten_id_check;
alter table verstossarten drop constraint verstossart_beschreibung_check;

-- Primary Key's
alter table benutzer drop constraint benutzer_matrnr_pk;
alter table geraete_verliehen drop constraint verleih_id_pk;
alter table geraetearten drop constraint geraeteart_id_pk;
alter table verstossarten drop constraint verstossarten_id_pk;
alter table geraete drop constraint geraete_id_pk;
alter table geraete_inreparatur drop constraint reparatur_id_pk;

-- Trigger
drop trigger trg_verstoesse_insert_1;

-- L�schen aller Tabellen f�r den Restart damit keine Komplikationen auftreten
drop table geraetearten;
drop table geraete;--
drop table benutzer;--
drop table geraete_verliehen;
drop table geraete_status;
drop table geraete_reserviert;
drop table verstossarten;
drop table verstoesse;
drop table geraete_inreparatur;

-- Erstellung aller Tabellen, Indizes, Trigger und Contraints
create table geraetearten (
geraeteart_id INTEGER not null,
geraeteart varchar(60) not null
);

create table geraete (
geraete_id integer generated always as identity,
geraeteart_id integer not null,
beschreibung varchar2(300) default 'Keine Beschreibung verf�gbar' not null,
zubehoer varchar2(300) default 'Kein Zubeh�r verf�gbar' not null
);

create table benutzer (
benutzer_matrnr integer,
benutzer_name varchar2(60),
benutzer_verstosspunkte integer default 0,
gesperrt varchar2(4) default 'Nein'
);

create table geraete_status(
status varchar2(20) default 'Verf�gbar',
datum_von date,
datum_bis date,
geraete_id integer not null
);

create table geraete_verliehen (
verleih_id INTEGER GENERATED ALWAYS AS IDENTITY,
benutzer_MatrNr INTEGER not null,
geraete_id INTEGER not null
);

create table geraete_inreparatur(
reparatur_id integer generated always as identity,
geraete_id integer
);

create table geraete_reserviert (
reservierung_id integer generated always as identity,
benutzer_matrnr integer not null,
reserviert_von date not null,
reserviert_bis date not null,
geraete_id INTEGER not null
);

create table verstossarten(
verstossart_id integer, 
verstossart_beschreibung varchar2(100),
verstossart_punkte integer not null
);

create table verstoesse(
verstoesse_id integer generated always as identity,
verstossart_id integer,
benutzer_matrnr integer not null
);




-- Erstellung der Contraints und Indizes
-- Indizies
create index geraete_id_index on geraete(geraete_id);

-- Check's
ALTER TABLE benutzer ADD CONSTRAINT benutzer_gesperrt_check CHECK (gesperrt IN('Ja', 'Nein'));
ALTER TABLE geraete_status ADD CONSTRAINT status_check CHECK (status IN ('Verf�gbar','Ausgeliehen','In Reparatur','Reserviert'));
ALTER TABLE geraetearten ADD CONSTRAINT geraeteart_id_check CHECK (geraeteart_id IN (1, 2, 3, 4, 5));
ALTER TABLE geraetearten ADD CONSTRAINT geraeteart_check CHECK  (geraeteart in ('Laptop', 'Wearable', 'Smartphone', 'Tablet', 'Sonstiges'));
alter table verstossarten add constraint verstossarten_id_check check (verstossart_id in (1 ,2 ,3));
alter table verstossarten add constraint verstossart_beschreibung_check check (verstossart_beschreibung in ('Leihdauer ueberzogen', 'Geraet defekt zurueckgebracht', 'Geraet verkratzt/beschaedigt'));

-- Primary Key's
alter table benutzer add constraint benutzer_matrnr_pk primary key (benutzer_matrnr);
alter table geraete_verliehen add constraint verleih_id_pk primary key (verleih_id);
alter table geraetearten add constraint geraeteart_id_pk primary key (geraeteart_id);
alter table verstossarten add constraint verstossarten_id_pk primary key (verstossart_id);
alter table geraete add constraint geraete_id_pk primary key (geraete_id);
alter table geraete_inreparatur add constraint reparatur_id_pk primary key (reparatur_id);

-- Foreign Key's
alter table geraete_verliehen add constraint benutzer_matrnr_fk foreign key (benutzer_matrnr) references benutzer(benutzer_matrnr);
alter table geraete_verliehen add constraint geraete_verliehen_id_fk foreign key (geraete_id) references geraetearten(geraeteart_id);
alter table geraete_status add constraint geraete_status_id_fk foreign key (geraete_id) references geraete (geraete_id);
alter table geraete_reserviert add constraint reservierung_geraete_id_fk foreign key (geraete_id) references geraete (geraete_id); -- ?
alter table verstoesse add constraint verstoesse_benutzer_matrnr_fk foreign key (benutzer_matrnr) references benutzer(benutzer_matrnr);
alter table geraete add constraint geraeteart_id_fk foreign key (geraeteart_id) references geraetearten(geraeteart_id);
alter table verstoesse add constraint verstossart_id_fk foreign key (verstossart_id) references verstossarten(verstossart_id);
alter table geraete_reserviert add constraint geraete_reserviert_matrnr_fk foreign key (benutzer_matrnr) references benutzer(benutzer_matrnr);

alter table geraete_inreparatur add constraint geraete_inreparatur_id_fk foreign key (geraete_id) references geraetearten(geraeteart_id);

-- trigger testversuch
CREATE OR REPLACE TRIGGER trg_verstoesse_insert_1
  AFTER INSERT ON verstoesse
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  b_verstosspunkte integer;
  b_matrnr integer;
  v_verstosspunkte integer;
BEGIN
  SELECT benutzer_verstosspunkte, benutzer_matrnr
  INTO b_verstosspunkte, b_matrnr
  FROM benutzer
  WHERE benutzer_matrnr = :NEW.benutzer_matrnr;
  SELECT verstossart_punkte
  INTO v_verstosspunkte
  from verstossarten
  WHERE verstossart_id = :NEW.verstossart_id;
  
  UPDATE benutzer SET benutzer_verstosspunkte = b_verstosspunkte + v_verstosspunkte 
  WHERE benutzer_matrnr = b_matrnr;
  UPDATE benutzer SET gesperrt = 'Ja' WHERE benutzer_verstosspunkte > 9;
END;
/



/*CREATE OR REPLACE TRIGGER trg_benutzer_update_1
  AFTER UPDATE OF benutzer_verstosspunkte ON benutzer
  REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
  b_punkte integer;
  b_gesperrt varchar2(10);
BEGIN
  SELECT benutzer_verstosspunkte
    INTO b_punkte
    FROM benutzer
    WHERE benutzer_matrnr = :NEW.benutzer_matrnr;
  SELECT gesperrt
    INTO b_gesperrt
    FROM benutzer
    WHERE benutzer_matrnr = :NEW.benutzer_matrnr;
  --IF (b_punkte >9) THEN
    --b_gesperrt := 'Ja';
    UPDATE benutzer SET gesperrt = 'Ja' WHERE b_punkte > 9;
  --ENDIF;
  --benutzer.gesperrt := :NEW.b_gesperrt;
END;
