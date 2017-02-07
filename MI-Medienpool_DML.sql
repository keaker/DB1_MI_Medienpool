-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                    

-- DML SQL
-- ***********************************************************************************

-- Geraete Insert's
INSERT INTO geraete (geraete_name, beschreibung, zubehoer) 
VALUES ('MacBook Pro', 'Intel m5 1,2 GHz Dual Core, 8GB Ram, Intel HD Graphics 515, 512 GB Festplatte', 'Ladekabel');
INSERT INTO geraete (geraete_name, zubehoer)
VALUES ('Apple Watch Generation 2', 'Ladekabel');
INSERT INTO geraete (geraete_name, zubehoer)
VALUES ('Oculus Rift', 'Zwei Controller, HDMI-Verbindungskabel, Motiontracking-Kamera, Stromkabel');

-- Benutzer Insert's
INSERT INTO benutzer (benutzer_MatrNr, benutzer_name)
VALUES (31104, 'Hackh, Philipp');
INSERT INTO benutzer (benutzer_MatrNr, benutzer_name)
VALUES (31094, 'Abdel Ghany, Karim ');
INSERT INTO benutzer (benutzer_MatrNr, benutzer_name)
VALUES (32051, 'Wark, Andreas');

-- Geraete_verliehen Insert's
INSERT INTO geraete_verliehen (benutzer_MatrNr, geraete_id)
VALUES (31104, 2);
INSERT INTO geraete_verliehen (benutzer_MatrNr, geraete_id)
VALUES (32051, 1);
INSERT INTO gereate_verliehen (benutzer_MatrNr, geraete_id)
VALUES (32051, 3);

-- Geraete_status Insert's
INSERT INTO geraete_status (status, datum_von, datum_bis, geraete_id)
VALUES ('Ausgeliehen', TO_DATE('05.02.2017', 'DD.MM.YYYY'), TO_DATE('25.02.2017', 'DD.MM.YYYY'), 1);



-- verstoeﬂe Insert's
INSERT INTO verstoeﬂe (verstoeﬂe_beschreibung, verstoeﬂe_punkte, benutzer_MatrNr)
VALUES ('Leihdauer ¸berzogen, Ger‰t noch nicht zur¸ckgebracht', 10, 31104);
INSERT INTO verstoeﬂe (verstoeﬂe_beschreibung, verstoeﬂe_punkte, benutzer_MatrNr)
VALUES ('Displaykratzer', 4, 31094);
INSERT INTO verstoeﬂe (verstoeﬂe_beschreibung, verstoeﬂe_punkte, benutzer_MatrNr)
VALUES ('to doo', 6, 31094);