-- ###################################################################
-- #                     Vorlesung Datenbanken 1                     #
-- #                                                                 #
-- # Projekt MI-Medienpool DDL Skript                                #
-- #                                                                 #
-- # Mitglieder:                                                     #
-- # Philipp Hackh, Andreas Wark,                                    #
-- # Karim Abdel Ghany                                               #                                                         
-- #                                                                 #
-- #                                                                 #
-- ###################################################################

-- Loeschung aller Tabellen fuer einen reibungslosen Restart
-- drop




-- Erstellen der Tabellen, Constraints und Trigger

create table geraete (
geraete_id integer generated always as identity primary key,
geraete_name varchar2(20) not null,
beschreibung varchar2(150) default 'Keine Beschreibung verfügbar' not null,
anzahl int(3) not null,
);

create index index_geraete on geraete(geraete_name);

create table benutzer(
benutzer_matrkelnummer int(5) primary key, -- to do
benutzer_name varchar2(60)),
geraete_geliehen foreign key, -- to do
gesperrt varchar2(4) default 'Nein' not null,
);

create table geraete_status(
status varchar(20) default 'Verfügbar',
datumm_von date,
datum_bis date
);

create table reservierung (
-- to do
);

create table verstoeße(
-- to do
);

create geraete_verliehen (
geraete_id integer preferences geraete(geraete_id) not null,

);