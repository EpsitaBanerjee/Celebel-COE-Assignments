CREATE TABLE Wands (
    id INT PRIMARY KEY,
    code INT NOT NULL,
    coins_needed INT NOT NULL,
    power INT NOT NULL
);
INSERT INTO Wands (id, code, coins_needed, power) VALUES
(1, 4, 3688, 8),
(2, 3, 9365, 3),
(3, 3, 7187, 10),
(4, 3, 734, 8),
(5, 1, 6020, 2),
(6, 2, 6773, 7),
(7, 3, 9873, 9),
(8, 3, 7721, 7),
(9, 1, 1647, 10),
(10, 4, 504, 5),
(11, 2, 7587, 5),
(12, 5, 9897, 10),
(13, 3, 4651, 8),
(14, 2, 5408, 1),
(15, 2, 6018, 7),
(16, 4, 7710, 5),
(17, 2, 8798, 7),
(18, 2, 3312, 3),
(19, 4, 7651, 6);

CREATE TABLE Wands_Property (
    code INT PRIMARY KEY,
    age INT NOT NULL,
    is_evil INT NOT NULL
);

INSERT INTO Wands_Property (code, age, is_evil) VALUES
(1, 45, 0),
(2, 40, 0),
(3, 40, 1),
(4, 20, 0),
(5, 17, 0);

SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands w
JOIN Wands_Property wp ON w.code = wp.code
WHERE wp.is_evil = 0
AND w.coins_needed = (
    SELECT MIN(w2.coins_needed)
    FROM Wands w2
    WHERE w2.power = w.power AND w2.code = w.code
)
ORDER BY w.power DESC, wp.age DESC;
