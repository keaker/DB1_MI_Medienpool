-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                      

-- DDL SQL
-- ***********************************************************************************
alter table geraete drop constraint geraete_id_index;
-- Löschen aller Constraints
-- Foreing Key's
alter table geraete_verliehen drop constraint benutzer_matrnr_fk;
alter table geraete_verliehen drop constraint geraete_verliehen_id_fk;
alter table geraete_status drop constraint geraete_status_id_fk;
alter table reservierung drop constraint reservierung_geraete_id_fk;
alter table verstoeße drop constraint verstoeße_benutzer_matrnr_fk;
alter table verstoeße drop constraint verstoßart_id_fk;

-- Primary Key's
alter table benutzer drop constraint benutzer_matrnr_pk;
alter table geraete_verliehen drop constraint verleih_id_pk;
alter table geraete drop constraint geraete_id_pk;

-- Check 

alter table benutzer drop constraint benutzer_gesperrt_check;
alter table geraete_status drop constraint status_check;
-- Indizies


 

-- Löschen aller Tabellen für den Restart damit keine Komplikationen auftreten
drop table geraete;
drop table benutzer;
drop table geraete_verliehen;
drop table geraete_status;
drop table reservierung;
drop table verstoeße;

-- Erstellung aller Tabellen, Indizes, Trigger und Contraints
create table geraetearten (
geraete_id integer GENERATED ALWAYS AS IDENTITY,
geraete_name varchar2(60) not null,
beschreibung varchar2(300) default 'Keine Beschreibung verfügbar' not null,
zubehoer varchar2(300) default 'Kein Zubehör verfügbar' not null,
status varchar2(30) default 'Verfügbar' not null
);

create table benutzer (
benutzer_matrnr integer,
benutzer_name varchar2(60),
benutzer_verstoßpunkte integer default 0,
gesperrt varchar2(4) default 'Nein'
);

create table geraete_verliehen (
verleih_id INTEGER GENERATED ALWAYS AS IDENTITY,
benutzer_MatrNr INTEGER not null,
geraete_id INTEGER not null
);

create table geraete_status(
status varchar2(20) default 'Verfügbar',
datum_von date,
datum_bis date,
geraete_id integer not null --FK
);

create table reservierung (
reserviert_von date,
reserviert_bis date,
geraete_id INTEGER not null
);

create table verstoßarten(
verstoßart_id integer generated always as identity,
verstoßart_beschreibung varchar2(100),
verstoßart_punkte integer not null
);

create table verstoeße(
verstoeße_id integer generated always as identity,
verstoßart_id integer,
benutzer_MatrNr varchar2(5) not null
);


-- Erstellung der Contraints und Indizes
-- Indizies
-- create index index_geraete on geraete(geraete_id); ??????

-- Check's
ALTER TABLE benutzer ADD CONSTRAINT benutzer_gesperrt_check CHECK (gesperrt IN('Ja', 'Nein'));
ALTER TABLE geraete_status ADD CONSTRAINT status_check CHECK (status IN ('Verfügbar','Ausgeliehen','In Reperatur','Reserviert'));

-- Primary Key's
alter table benutzer add constraint benutzer_matrnr_pk primary key (benutzer_matrnr);
alter table geraete_verliehen add constraint verleih_id_pk primary key (verleih_id);
alter table geraete add constraint geraete_id_pk primary key (geraete_id);


-- Foreign Key's
alter table geraete_verliehen add constraint benutzer_matrnr_fk foreign key (benutzer_MatrNr) references benutzer(benutzer_matrnr);
alter table geraete_verliehen add constraint geraete_verliehen_id_fk foreign key (geraete_id) references geraete(geraete_id);
alter table geraete_status add constraint geraete_status_id_fk foreign key (geraete_id) references geraete (geraete_id);
alter table reservierung add constraint reservierung_geraete_id_fk foreign key (geraete_id) references geraete (geraete_id);
alter table verstoeße add constraint verstoeße_benutzer_matrnr_fk foreign key (benutzer_matrnr) references benutzer(benutzer_matrnr);
alter table verstoeße add constraint verstoßart_id_fk foreign key (verstoßart_id) references verstoßarten(verstoßart_id);


create index geraete_id_index on geraete (geraete_id);

-- trigger
/*
CREATE OR REPLACE TRIGGER verstoeße_trigger
  AFTER INSERT ON verstoeße
  referencing new as new old as old for each row
BEGIN
  when new.verstoeße_punkte >= 10 then
  INSERT INTO benutzer (gesperrt) VALUES ('Ja')

END
/
*/