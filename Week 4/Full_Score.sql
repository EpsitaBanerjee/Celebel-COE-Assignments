CREATE TABLE Hackers (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Hackers (hacker_id, name) VALUES
(5580, 'Rose'),
(8439, 'Angela'),
(27205, 'Frank'),
(52243, 'Patrick'),
(52348, 'Lisa'),
(57645, 'Kimberly'),
(77726, 'Bonnie'),
(83082, 'Michael'),
(86870, 'Todd'),
(90411, 'Joe');

CREATE TABLE Difficulty (
    difficulty_level INT PRIMARY KEY,
    score INT
);

INSERT INTO Difficulty (difficulty_level, score) VALUES
(1, 20),
(2, 30),
(3, 40),
(4, 60),
(5, 80),
(6, 100),
(7, 120);

CREATE TABLE Challenges (
    challenge_id INT PRIMARY KEY,
    hacker_id INT,
    difficulty_level INT,
    FOREIGN KEY (hacker_id) REFERENCES Hackers(hacker_id),
    FOREIGN KEY (difficulty_level) REFERENCES Difficulty(difficulty_level)
);

INSERT INTO Challenges (challenge_id, hacker_id, difficulty_level) VALUES
(4810, 77726, 4),
(21089, 27205, 1),
(36566, 5580, 7),
(66730, 52243, 6),
(71055, 52243, 2);

CREATE TABLE Submissions (
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    challenge_id INT,
    score INT,
    FOREIGN KEY (hacker_id) REFERENCES Hackers(hacker_id),
    FOREIGN KEY (challenge_id) REFERENCES Challenges(challenge_id)
);

INSERT INTO Submissions (submission_id, hacker_id, challenge_id, score) VALUES
(68628, 77726, 36566, 30),
(65300, 77726, 21089, 10),
(40326, 52243, 36566, 77),
(8941, 27205, 4810, 4),
(83554, 77726, 66730, 30),
(43353, 52243, 66730, 0),
(55385, 52348, 71055, 20),
(39784, 27205, 71055, 23),
(94613, 86870, 71055, 30),
(45788, 52348, 36566, 0),
(93058, 86870, 36566, 30),
(7344, 8439, 66730, 92),
(2721, 8439, 4810, 36),
(523, 5580, 71055, 4),
(49105, 52348, 66730, 0),
(55877, 57645, 66730, 80),
(38355, 27205, 66730, 35),
(3924, 8439, 36566, 80),
(97397, 90411, 66730, 100),
(84162, 83082, 4810, 40),
(97431, 90411, 71055, 30);

SELECT h.hacker_id, h.name
FROM Submissions s
JOIN Challenges c ON c.challenge_id = s.challenge_id
JOIN Difficulty d ON d.difficulty_level = c.difficulty_level AND d.score = s.score
JOIN Hackers h ON h.hacker_id = s.hacker_id
GROUP BY h.hacker_id, h.name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, hacker_id;
