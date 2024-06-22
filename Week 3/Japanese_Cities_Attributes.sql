CREATE TABLE JapaneseCity (
    ID int,
    NAME varchar(17),
    COUNTRYCODE varchar(3),
    DISTRICT varchar(20),
    POPULATION int
);
INSERT INTO JapaneseCity(ID, NAME, COUNTRYCODE, DISTRICT, POPULATION) VALUES
(1613, 'Neyagawa', 'JPN', 'Osaka', 257315),
(1630, 'Ageo', 'JPN', 'Saitama', 209442),
(1661, 'Sayama', 'JPN', 'Saitama', 162472),
(1681, 'Omuta', 'JPN', 'Fukuoka', 142889),
(1739, 'Tokuyama', 'JPN', 'Yamaguchi', 107078);

SELECT * FROM JapaneseCity WHERE COUNTRYCODE = 'JPN';

