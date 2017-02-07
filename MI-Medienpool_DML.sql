-- Vorlesung Datenbanken 1                 
-- Projekt MI-Medienpool DDL Skript
-- Teilnehmer: Philipp Hackh (ph057), Andreas Wark (aw131), Karim Abdel Ghany (ka026)                                                    

-- DML SQL
-- ***********************************************************************************
-- Geraetearten Insert's
INSERT INTO geraetearten (geraeteart_id, geraeteart) 
VALUES (1, 'Laptop');
INSERT INTO geraetearten (geraeteart_id, geraeteart) 
VALUES (2, 'Wearable');
INSERT INTO geraetearten (geraeteart_id, geraeteart) 
VALUES (3, 'Smartphone');
INSERT INTO geraetearten (geraeteart_id, geraeteart) 
VALUES (4, 'Tablet');
INSERT INTO geraetearten (geraeteart_id, geraeteart) 
VALUES (5, 'Sonstiges');

-- Gereate Insert's
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (3, 'iPhone 7 128GB Spacegrau', 'Ladekabel, EarPods');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (2, 'Apple Watch 2 Spacegrau', 'Ladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (4, 'iPad Air 2 64GB silber', 'Ladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (1, 'MacBook Pro 2017 Spacegrau mit TouchBar', 'Ladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (5, 'HP Photosmart 8850 Drucker', 'Stromkabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (3, 'Samsung Galaxy S7', 'Ladekabel, Kopfhoerer');

-- Benutzer Insert's
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte)
VALUES (31104, 'Hackh, Philipp', 0);
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte, gesperrt)
VALUES (31094, 'Abdel Ghany, Karim ', 10, 'Ja');
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte)
VALUES (32051, 'Wark, Andreas', 4);

-- Geraete_verliehen Insert's
INSERT INTO geraete_verliehen (benutzer_matrnr, geraete_id)
VALUES (31104, 2);
INSERT INTO geraete_verliehen (benutzer_MatrNr, geraete_id)
VALUES (32051, 1);
INSERT INTO geraete_verliehen (benutzer_MatrNr, geraete_id)
VALUES (32051, 3);

-- Geraete_status Insert's
INSERT INTO geraete_status (status, datum_von, datum_bis, geraete_id)
VALUES ('Ausgeliehen', TO_DATE('05.02.2017', 'DD.MM.YYYY'), TO_DATE('25.02.2017', 'DD.MM.YYYY'), 1);
INSERT INTO geraete_status (status, datum_von, datum_bis, geraete_id)
VALUES ('In Reperatur', TO_DATE('01.02.2017', 'DD.MM.YYYY'), TO_DATE('28.02.2017', 'DD.MM.YYYY'), 6);
INSERT INTO geraete_status (status, datum_von, datum_bis, geraete_id)
VALUES ('Ausgeliehen', TO_DATE('08.02.2017', 'DD.MM.YYYY'), TO_DATE('16.02.2017', 'DD.MM.YYYY'), 2);
INSERT INTO geraete_status (status, datum_von, datum_bis, geraete_id)
VALUES ('Ausgeliehen', TO_DATE('07.02.2017', 'DD.MM.YYYY'), TO_DATE('09.02.2017', 'DD.MM.YYYY'), 3);

-- Reservierung Insert's
INSERT INTO reservierung (benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
VALUES (31104, TO_DATE('07.02.2017', 'DD.MM.YYYY'), TO_DATE('10.02.2017', 'DD.MM.YYYY'), 4);
INSERT INTO reservierung (benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
VALUES (32051, TO_DATE('09.02.2017', 'DD.MM.YYYY'), TO_DATE('15.02.2017', 'DD.MM.YYYY'), 5);
--INSERT INTO reservierung (reservierung_id, benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
--VALUES (3, 31104, TO_DATE('04.02.2017', 'DD.MM.YYYY'), TO_DATE('02.03.2017', 'DD.MM.YYYY'), 3);

-- verstossarten Insert's
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (1, 'Leihdauer ueberzogen', 2);
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (2, 'Geraet defekt zurueckgebracht', 5);
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (3, 'Geraet verkratzt/beschaedigt', 1);

/*-- TO DOO !!!!
-- verstoesse Insert's
INSERT INTO verstoesse (verstoesse_id, verstossart_id, benutzer_matrnr)
VALUES (1, 1, 32051);
INSERT INTO verstoesse (verstoesse_id, verstossart_id, benutzer_matrnr)
VALUES (2, 2, 32051);
INSERT INTO verstoesse (verstoesse_id, verstossart_id, benutzer_matrnr)
VALUES (3, 1, 31104);
*/