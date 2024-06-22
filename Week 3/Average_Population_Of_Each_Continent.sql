    CREATE TABLE Country (
	Code VARCHAR(3),
    Name VARCHAR(44),
    Continent VARCHAR(13),
    Region CHAR(25),
    SurfaceArea int,
    IndepYear VARCHAR(5),
    Population INT,
    LifeExpectancy VARCHAR(4),
    GNP INT,
    GNPOld VARCHAR(9),
    LocalName VARCHAR(44),
    GovernmentForm VARCHAR(44),
    HeadOfState VARCHAR(32),
    Capital VARCHAR(4),
    Code2 VARCHAR(2)
);
INSERT INTO Country (Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, GNPOld, LocalName, GovernmentForm, HeadOfState, Capital, Code2)
VALUES 
('NLD', 'Netherlands', 'Europe', NULL, NULL, NULL, 593321, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('USA', 'United States', 'North America', NULL, NULL, NULL, 202705, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('USA', 'United States', 'North America', NULL, NULL, NULL, 124966, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('USA', 'United States', 'North America', NULL, NULL, NULL, 121780, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('USA', 'United States', 'North America', NULL, NULL, NULL, 120758, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);



SELECT Country.Continent, FLOOR(AVG(City.Population))
FROM Country, City 
WHERE Country.Code = City.CountryCode 
GROUP BY Country.Continent ;