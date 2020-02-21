-- move to default database
USE master;
GO
-- create new database
DROP DATABASE IF EXISTS StudentDemo;
CREATE DATABASE StudentDemo;
GO
-- switch to new database
USE StudentDemo;
GO
-- create Student table
DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
    StudentID INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(32) NOT NULL,
    LastName NVARCHAR(32) NOT NULL,
    Age INT NOT NULL,
    Photo VARBINARY(MAX) NULL
);
GO
INSERT INTO Student (FirstName, LastName, Age, Photo)
VALUES ('John', 'Smith', 32, NULL);
GO
SELECT * FROM Student;
GO
DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
    CourseID INT IDENTITY PRIMARY KEY,
    Code NCHAR(8) NOT NULL DEFAULT ('ABCD1234'),
    Name NVARCHAR(32) NOT NULL,
    StudentID INT NOT NULL
);
GO
ALTER TABLE Course
ADD CONSTRAINT FK__Student__StudentID
FOREIGN KEY (StudentID)
REFERENCES Student (StudentID) ON DELETE CASCADE ON UPDATE CASCADE ;
GO
INSERT INTO Course (Code, Name, StudentID)
VALUES ('DBAS4002', 'Transactional SQL Programming', 1);
GO
INSERT INTO Course (Name, StudentID)
VALUES ('Default Name', 1);
GO
ALTER TABLE Course
ADD CONSTRAINT AK__Course__Code
UNIQUE (Code);
GO
-- tests the UNIQUE constraint on Code
-- INSERT INTO Course (Code, Name, StudentID)
-- VALUES ('DBAS4002', 'Transactional SQL Programming', 1);
-- GO
ALTER TABLE Student
ADD CONSTRAINT CK__Student__Age
CHECK (Age > 0);
GO
-- tests the Age constraint
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('Jane', 'Smith', 0, NULL);
-- GO
ALTER TABLE Student
ADD CONSTRAINT DF__Student__FirstName
DEFAULT ('') FOR FirstName;
GO
INSERT INTO Student (LastName, Age, Photo)
VALUES ('Smith', 10, NULL);
GO
ALTER TABLE Student
ADD CONSTRAINT CK__Student__FirstName
CHECK (FirstName NOT LIKE '%[0-9]%');
GO
-- test that firstname can't have a number
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('Bob123', 'Jones', 45, NULL);
-- GO
-- ALTER TABLE Student
-- DROP CONSTRAINT CK__Student__LastName;
-- GO
ALTER TABLE Student
ADD CONSTRAINT CK__Student__LastName
CHECK (LEN(LastName) > 0 AND LastName NOT LIKE '%[0-9]%');
GO
-- tests that the LastName must contain a value
-- INSERT INTO Student (FirstName, LastName, Age, Photo)
-- VALUES ('Mike', '', 34, NULL);
-- GO
INSERT INTO Student (FirstName, LastName, Age, Photo)
VALUES ('Mike', 'Jones', 34, NULL);
GO
ALTER TABLE Course
ADD EnrolDate DATE NOT NULL DEFAULT (GETDATE());
GO
INSERT INTO Course (Code, Name, StudentID)
VALUES ('PROG1400', 'Intro to OOP', 1);
GO
