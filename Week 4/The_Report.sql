CREATE TABLE Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Marks INT
);

INSERT INTO Students (ID, Name, Marks) VALUES
(1, 'Julia', 88),
(2, 'Samantha',68 ),
(3, 'Maria', 99),
(4, 'Scarlet', 78),
(5, 'Ashley', 63),
(6, 'Jane',81);


CREATE TABLE Grades (
    GradeID INT PRIMARY KEY,
    Min_Marks INT,
    Max_Marks INT
);
INSERT INTO Grades (GradeID, Min_Marks, Max_Marks) VALUES
(1, 0, 9),
(2, 10, 19),
(3, 20, 29),
(4, 30, 39),
(5, 40, 49),
(6, 50, 59),
(7, 60, 69),
(8, 70, 79),
(9, 80, 89),
(10, 90, 100);

SELECT 
    CASE 
        WHEN g.GradeID >= 8 THEN s.Name 
        ELSE 'NULL' 
    END AS Name,
    g.GradeID AS Grade,
    s.Marks
FROM 
    Students s
JOIN 
    Grades g ON s.Marks BETWEEN g.Min_Marks AND g.Max_Marks
ORDER BY 
    g.GradeID DESC,
    CASE 
        WHEN g.GradeID >= 8 THEN s.Name
        ELSE CAST(s.Marks AS VARCHAR)
    END ASC;
