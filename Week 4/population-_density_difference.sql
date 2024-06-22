CREATE TABLE CITY (
    ID int,
    NAME varchar(17),
    COUNTRYCODE varchar(3),
    DISTRICT varchar(20),
    POPULATION int
);
INSERT INTO CITY (ID, NAME, COUNTRYCODE, DISTRICT, POPULATION) VALUES
(1661, 'Rotterdam', 'NLD', 'Zuid-Holland', 593321),
(3878, 'Scottsdale', 'USA', 'Arizona', 202705),
(3965, 'Corona', 'USA', 'California', 124966),
(3973, 'Concord', 'USA', 'California', 121780),
(3977, 'Cedar Rapids', 'USA', 'Iowa', 120758),
(3982, 'Coral Springs', 'USA', 'Florida', 117549),
(4054, 'Fairfield', 'USA', 'California', 92256),
(4058, 'Boulder', 'USA', 'Colorado', 91238),
(4061, 'Fall River', 'USA', 'Massachusetts', 90555);

select max(Population)-min(Population) from City;