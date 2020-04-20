
USE StudentDemo;
GO

SELECT * FROM Student;
GO

CREATE PROCEDURE usp_GetStudents
AS
BEGIN
    SELECT * FROM Student;
END;

EXEC dbo.usp_GetStudents;
GO

DROP PROCEDURE usp_GetStudents;
GO
CREATE PROCEDURE usp_GetStudents
    @age SMALLINT
AS
BEGIN
    SELECT * FROM Student
    WHERE Age > @age;
END;
GO

EXEC usp_GetStudents 18;
GO

DROP PROCEDURE usp_GetStudents;
GO
CREATE PROCEDURE usp_GetStudentsByName
    @firstName NVARCHAR(32), @lastName NVARCHAR(32)
AS
BEGIN
    SELECT FirstName, LastName FROM Student
    WHERE FirstName LIKE @firstName OR LastName LIKE @lastName;
END;
GO

EXEC usp_GetStudentsByName N'J%', N'S%';
GO

SELECT AVG(Age) AS AverageAge FROM Student;
GO

DROP PROCEDURE usp_GetStudentAverageAge;
GO
CREATE PROCEDURE usp_GetStudentAverageAge
    @averageAge SMALLINT OUTPUT
AS
BEGIN
    SET @averageAge = (SELECT AVG(Age) FROM Student);
END;
GO

DECLARE @avg SMALLINT;
EXEC usp_GetStudentAverageAge @avg OUTPUT;
PRINT 'avg = ' + STR(@avg);
GO

CREATE FUNCTION ufn_GetStudentAverageAge ()
RETURNS SMALLINT
AS
BEGIN
    DECLARE @avg SMALLINT;
    SET @avg = (SELECT AVG(Age) FROM Student);
    RETURN @avg;
END;
GO

DECLARE @avg SMALLINT;
EXEC @avg = ufn_GetStudentAverageAge;
PRINT 'avg = ' + STR(@avg);
GO