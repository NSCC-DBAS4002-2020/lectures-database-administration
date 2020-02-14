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
    Code NCHAR(8) NOT NULL,
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