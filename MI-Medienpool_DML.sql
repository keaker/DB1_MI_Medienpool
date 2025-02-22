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
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (1, 'Microsoft Surface Pro 4', 'Ladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (4, 'iPad Pro 128GB Spacegrau', 'Ladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (5, 'Oculus Rift', 'Motiontrackingkamera, Controller');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
Values (2, 'Motorolla 360', 'Induktionsladekabel');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (5, 'Nintendo Switch', 'Ladekabel, Controller');
INSERT INTO geraete (geraeteart_id, beschreibung, zubehoer)
VALUES (5, 'Apple TV', 'HDMI-Kabel, Fernbedienung');

-- Benutzer Insert's
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte)
VALUES (31104, 'Hackh, Philipp', 0);
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte, gesperrt)
VALUES (31094, 'Abdel Ghany, Karim ', 10, 'Ja');
INSERT INTO benutzer (benutzer_matrnr, benutzer_name, benutzer_verstosspunkte)
VALUES (32051, 'Wark, Andreas', 4);

-- Geraete_verfuegbar Insert's
INSERT INTO geraete_verfuegbar (geraete_id)
VALUES (1);
INSERT INTO geraete_verfuegbar (geraete_id)
VALUES (2);
INSERT INTO geraete_verfuegbar (geraete_id)
VALUES (3);

-- Geraete verliehen Insert's
INSERT INTO geraete_verliehen (benutzer_matrnr, verliehen_von, verliehen_bis, geraete_id)
VALUES (31104, TO_DATE('11.02.2017', 'DD.MM.YYYY'), TO_DATE('28.02.2017', 'DD.MM.YYYY'), 4);
INSERT INTO geraete_verliehen (benutzer_MatrNr, verliehen_von, verliehen_bis, geraete_id)
VALUES (32051, TO_DATE('08.02.2017', 'DD.MM.YYYY'), TO_DATE('01.03.2017', 'DD.MM.YYYY'), 5);
INSERT INTO geraete_verliehen (benutzer_MatrNr, verliehen_von, verliehen_bis, geraete_id)
VALUES (32051, TO_DATE('07.02.2017', 'DD.MM.YYYY'), TO_DATE('18.02.2017', 'DD.MM.YYYY'), 6);

-- Geraete in Reparatur Inserts's
Insert INTO geraete_inreparatur (geraete_id)
VALUES (7);
INSERT INTO geraete_inreparatur (geraete_id)
VALUES (8);
INSERT INTO geraete_inreparatur (geraete_id)
VALUES (9);

-- Geraete Reservierung Insert's
INSERT INTO geraete_reserviert (benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
VALUES (31104, TO_DATE('07.02.2017', 'DD.MM.YYYY'), TO_DATE('10.02.2017', 'DD.MM.YYYY'), 10);
INSERT INTO geraete_reserviert (benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
VALUES (32051, TO_DATE('09.02.2017', 'DD.MM.YYYY'), TO_DATE('15.02.2017', 'DD.MM.YYYY'), 11);
INSERT INTO geraete_reserviert (benutzer_matrnr, reserviert_von, reserviert_bis, geraete_id)
VALUES (32051, TO_DATE('04.02.2017', 'DD.MM.YYYY'), TO_DATE('02.03.2017', 'DD.MM.YYYY'), 12);

-- Verstossarten Insert's
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (1, 'Leihdauer ueberzogen', 1.5);
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (2, 'Geraet defekt zurueckgebracht', 5.0);
INSERT INTO verstossarten (verstossart_id, verstossart_beschreibung, verstossart_punkte)
VALUES (3, 'Geraet verkratzt/beschaedigt', 1.5);

-- Verstoesse Insert's
INSERT INTO verstoesse (verstossart_id, benutzer_matrnr)
VALUES (1, 32051);
INSERT INTO verstoesse (verstossart_id, benutzer_matrnr)
VALUES (2, 32051);
INSERT INTO verstoesse (verstossart_id, benutzer_matrnr)
VALUES (1, 31104);

-- Trigger Updates
UPDATE geraete SET status = 'Verfuegbar' 
WHERE geraete_id = 7;