CREATE TABLE STATION (
    id INT,
    city VARCHAR(21),
    state VARCHAR(2),
    lat_n int,
    long_w int
);
INSERT INTO STATION (id, city, state, lat_n, long_w) VALUES
(1, 'Kissee Mills', 'MO', 36, -92),
(2, 'Loma Mar', 'CA', 37, -122),
(3, 'Sandy Hook', 'CT', 41, -73),
(4, 'Tipton', 'IN', 40, -86),
(5, 'Arlington', 'CO', 39, -104),
(6, 'Turner', 'AR', 33, -91),
(7, 'Slidell', 'LA', 30, -89),
(8, 'Negreet', 'LA', 31, -93),
(9, 'Glencoe', 'KY', 37, -86),
(10, 'Chelsea', 'IA', 41, -92),
(11, 'Chignik Lagoon', 'AK', 56, -158),
(12, 'Pelahatchie', 'MS', 32, -89);

select CITY, STATE from STATION;