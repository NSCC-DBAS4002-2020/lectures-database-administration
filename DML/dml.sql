USE StudentDemo;
GO
-- simple INSERT statement
INSERT INTO dbo.Student (FirstName, LastName, Age, Photo)
VALUES ('John', 'Smith', 45, NULL),
       ('Jane', 'Doe', 32, NULL),
       ('Jack', 'Sprat', 19, NULL);

PRINT '@@IDENTITY: ' + STR(@@IDENTITY);

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4003', 'Transactional SQL', @@IDENTITY, GETDATE());

PRINT 'SCOPE_IDENTITY(): ' + STR(SCOPE_IDENTITY());

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4004', 'Transactional SQL', SCOPE_IDENTITY(), GETDATE());

INSERT INTO dbo.Student (FirstName, LastName, Age, Photo)
VALUES ('Tom', 'Thumb', 36, NULL);

DECLARE @StudentID INT;
SET @StudentID = SCOPE_IDENTITY();

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4005', 'Transactional SQL', @StudentID, GETDATE()),
       ('PROG1401', 'Intro to OOP', @StudentID, GETDATE());

SET IDENTITY_INSERT Student ON;
INSERT INTO Student (StudentID, FirstName, LastName, Age, Photo)
VALUES (100, 'Nancy', 'Drew', 41, NULL);
SET IDENTITY_INSERT Student OFF;

INSERT INTO Course (Code, Name, StudentID, EnrolDate)
VALUES ('DBAS4006', 'Transactional SQL', 100, GETDATE()),
       ('PROG1402', 'Intro to OOP', 100, GETDATE());

DELETE FROM Course
WHERE CourseID = 11;

DELETE FROM dbo.Student
WHERE StudentID = 100;

UPDATE Course
SET Name = 'Intro to Object-Oriented'
WHERE CourseID = 9;

-- a (complicated) example of changing an identity field
SET IDENTITY_INSERT Course ON;
DECLARE @Name NVARCHAR(32);
DECLARE @Code NCHAR(8);
DECLARE @StudentID INT;
DECLARE @EnrolDate DATETIME;
SELECT @Code=Code, @Name=Name, @StudentID=StudentID, @EnrolDate=EnrolDate
FROM Course
WHERE CourseID = 13;
DELETE FROM Course
WHERE CourseID = 13;
INSERT INTO Course (CourseID, Code, Name, StudentID, EnrolDate)
VALUES (6, @Code, @Name, @StudentID, @EnrolDate)
SET IDENTITY_INSERT Course OFF;
