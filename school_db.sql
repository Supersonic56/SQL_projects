CREATE DATABASE schoolDB;
CREATE TABLE Classes (
    Class_ID INT NOT NULL PRIMARY KEY,
    Class_Name VARCHAR(255) NOT NULL
);

CREATE TABLE Students (
    Student_Id INT NOT NULL PRIMARY KEY,
    Student_Name VARCHAR(255) NOT NULL
);

CREATE TABLE Instructors(
    Instructor_ID INT NOT NULL PRIMARY KEY,
    Instructor_Name VARCHAR(255) NOT NULL
);

ALTER TABLE Students
ADD Class_ID INT NULL;

ALTER TABLE Students
ADD Instructor_ID INT NULL;

ALTER TABLE Students ADD FOREIGN KEY (Class_ID) REFERENCES Classes(Class_ID);
ALTER TABLE Students ADD FOREIGN KEY (Instructor_ID) REFERENCES Instructors(Instructor_ID);

INSERT INTO Classes VALUES
    (1, 'Software Developer Boot Camp'),
    (2, 'C# Boot Camp');

--
CREATE TABLE Janitor (
    Janitor_ID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Janitor_Name VARCHAR(255) NOT NULL
);

ALTER TABLE Janitor
ADD Class_ID_forJanitor INT NULL;

ALTER TABLE Janitor
ADD FOREIGN KEY (Class_ID_forJanitor) REFERENCES Classes(Class_ID);

INSERT INTO Janitor (Janitor_Name) VALUES
    ('Joe'),
    ('Jack');

    INSERT INTO Students (Student_Id, Student_Name) VALUES  
        (1, 'Jessica'),
        (2, 'Shawn'),
        (3, 'Holly'),
        (4, 'Harry'),
        (5, 'Valerie'),
        (6, 'Nathan');

    INSERT INTO Instructors VALUES
    (1, 'Lacey'),
    (2, 'Ben');

    UPDATE Students
    SET Class_ID = 1 WHERE Student_Id <= 3;
    UPDATE Students
    SET Class_ID = 2 WHERE Student_Id > 3;

    UPDATE Students
    SET Instructor_ID = 2 WHERE Class_ID = 1;
    UPDATE Students
    SET Instructor_ID = 1 WHERE Class_ID = 2;

    SELECT Instructor_Name FROM Instructors;

    SELECT Student_Name FROM Students
    ORDER BY Student_Name ASC;

    SELECT Classes.Class_Name, Students.Student_Name, Instructors.Instructor_Name
    FROM (( Classes
    INNER JOIN Students ON Classes.Class_ID = Students.Class_ID)
    INNER JOIN Instructors ON Students.Instructor_ID = Instructors.Instructor_ID);

