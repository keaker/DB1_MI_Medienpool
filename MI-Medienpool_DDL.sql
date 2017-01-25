-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                      

-- DDL SQL
-- ***********************************************************************************

-- Löschen aller Constraints

--Primary Key's
alter table geraete drop constraint geraete_id_pk;
alter table benutzer drop constraint benutzer_matrnr_pk;
alter table geraete_verliehen drop constraint verleih_id_pk;


--Foreing Key's
alter table benutzer drop constraint geraete_id_fk;                  -- ?
alter table geraete_verliehen drop constraint benutzer_matrnr_fk;
alter table geraete_status drop constraint geraete_id_fk;            -- ?

--Check 
alter table benutzer drop constraint benutzer_gesperrt_check;

-- Löschen aller Tabellen für den Restart damit keine Komplikationen auftreten
drop table geraete;
drop table benutzer;
drop table geraete_verliehen;
drop table reservierung;
drop table verstoeße;
drop table geraete_verliehen;

-- Erstellung aller Tabellen, Indizes, Trigger und Contraints

create table geraete (
geraete_id integer generated always as identity,
geraete_name varchar2(60) not null,
beschreibung varchar2(300) default 'Keine Beschreibung verfügbar' not null,
zubehoer varchar2(300) default 'Kein Zubehör verfügbar' not null,
status varchar2(30) default 'Verfügbar' not null
);



create table benutzer (
benutzer_MatrNr integer,
benutzer_name varchar2(60),
gesperrt varchar2(4) default 'Nein',
geraete_geliehen varchar2(100)
);


create table geraete_verliehen (
verleih_id INTEGER GENERATED ALWAYS AS IDENTITY,
benutzer_MatrNr INTEGER REFERENCES benutzer (benutzer_MatrNr) not null,
geraete_id INTEGER REFERENCES geraete (geraete_id) not null
);




create table geraete_status(
status varchar2(20) default 'Verfügbar',
datum_von date,
datum_bis date
geraete_id INTEGER REFERENCES geraete(geraete_id) not null
);


create table reservierung (
reserviert_von date,
reserviert_bis date,
geraete_id INTEGER REFERENCES gereate(gereate_id) not null
);

create table verstoeße(
verstoeße_id integer generated always as identity primary key,
verstoeße_beschreibung varchar2(100) not null,
verstoeße_punkte integer,
benutzer_MatrNr varchar2 references benutzer(Benutzer_MatrNr) not null,
geraete
);
-- Erstellung der Contraints und Indizes
-- Indizies
create index index_geraete on geraete(geraete_name);

-- Primary Key's
alter table geraete_verliehen add constraint verleih_id_pk primary key (verleih_id)
alter table benutzer add constraint benutzer_matrnr_pk primary key (benutzer_matrnr);
alter table geraete add constraint geraete_id_pk primary key (geraete_id);


-- Foreign Key's
alter table geraete_status add constraint geraete_id_fk foreign key (geraete) references geraete (geraete_id);
alter table geraete_verliehen add constraint benutzer_matrnr_fk foreign key (geraete_verliehen) references benutzer(benutzer_matrnr);
alter table benutzer add constraint geraete_id_fk foreign key (geraete) references geraete (geraete_id);


-- Check's
ALTER TABLE benutzer ADD CONSTRAINT benutzer_gesperrt_check CHECK (gesperrt IN('Ja', 'Nein'));

-- trigger

CREATE OR REPLACE TRIGGER verstoeße_trigger
  AFTER INSERT ON verstoeße
  referencing new as new old as old for each row
BEGIN
  when new.verstoeße_punkte >= 10 then
  INSERT INTO benutzer (gesperrt) VALUES ('JA')

END
/