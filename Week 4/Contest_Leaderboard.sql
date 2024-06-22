CREATE TABLE Hackerss (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO Hackerss (hacker_id, name) VALUES
(4071, 'Rose'),
(4806, 'Angela'),
(26071, 'Frank'),
(49438, 'Patrick'),
(74842, 'Lisa'),
(80305, 'Kimberly'),
(84072, 'Bonnie'),
(87868, 'Michael'),
(92118, 'Todd'),
(95895, 'Joe');


CREATE TABLE Submissions (
    submission_id INT PRIMARY KEY,
    hacker_id INT NOT NULL,
    challenge_id INT NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (hacker_id) REFERENCES Hackerss(hacker_id)
);

INSERT INTO Submissions (submission_id, hacker_id, challenge_id, score) VALUES
(67194, 74842, 63132, 76),
(64479, 74842, 19797, 98),
(40742, 26071, 49593, 20),
(17513, 4806, 49593, 32);

SELECT h.hacker_id, h.name, t1.total_score
  FROM (
        SELECT hacker_id, SUM(max_score) AS total_score
          FROM (
                SELECT hacker_id, MAX(score) AS max_score
                  FROM Submissions
                GROUP BY hacker_id, challenge_id
               ) t
        GROUP BY hacker_id
       ) t1
  JOIN Hackerss h
    ON h.hacker_id = t1.hacker_id
 WHERE t1.total_score <> 0
 ORDER BY total_score DESC, hacker_id;
