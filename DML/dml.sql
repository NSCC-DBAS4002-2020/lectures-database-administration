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

-- SELECT statements
USE AdventureWorks2017;
GO
SELECT * FROM Person.Person
WHERE FirstName LIKE '%Ken%';
GO
SELECT FirstName, LastName, JobTitle
FROM Person.Person p
RIGHT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
SELECT FirstName, LastName, JobTitle
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
UNION ALL
SELECT FirstName, LastName, JobTitle
FROM Person.Person p
RIGHT OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
SELECT DISTINCT FirstName, LastName, JobTitle
FROM Person.Person p
FULL OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
SELECT FirstName, LastName, JobTitle, COUNT(*) AS DuplicateCount
FROM Person.Person p
FULL OUTER JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID
GROUP BY FirstName, LastName, JobTitle
HAVING COUNT(*) > 1
ORDER BY LastName;

SELECT STRING_AGG (CONVERT(nvarchar(max),FirstName), ',') AS csv
FROM Person.Person;

SELECT FirstName, LastName FROM Person.Person;
GO

-- concatenating string
SELECT FirstName + ' ' + LastName AS FullName FROM Person.Person;
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM Person.Person;
-- substrings
SELECT LEFT(FirstName, 1) AS Initial FROM Person.Person;
SELECT FirstName, SUBSTRING(FirstName, 2, 3) FROM Person.Person;
SELECT FirstName, CHARINDEX('a', FirstName) FROM Person.Person;

SELECT
       LOWER(CONCAT(LEFT(FirstName, 1), LEFT(LastName, 3))) AS UserName
FROM Person.Person;
-- trimming
SELECT
       LTRIM(STR(SubTotal, 10, 2)) + ' + ' +
       LTRIM(STR(TaxAmt, 10, 2)) + ' = ' +
       LTRIM(STR(TotalDue, 10, 2))
FROM Sales.SalesOrderHeader;
-- length
SELECT (FirstName + ' ' + LastName) AS FullName,
       LEN(FirstName + ' ' + LastName) AS Length
FROM Person.Person;
SELECT MAX(LEN(FirstName + ' ' + LastName)) AS MaxLength
FROM Person.Person;

-- cast/convert
SELECT TotalDue, CAST(TotalDue AS INT) FROM Sales.SalesOrderHeader;
SELECT TotalDue, CONVERT(INT, TotalDue) FROM Sales.SalesOrderHeader;

SELECT OrderDate, CONVERT(VARCHAR, OrderDate, 127) FROM Sales.SalesOrderHeader;

-- date/time functions
SELECT OrderDate, YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate)
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 5;

SELECT OrderDate, DATEPART(HOUR, OrderDate), DATEPART(MINUTE, OrderDate)
FROM Sales.SalesOrderHeader;

DECLARE @value INT;
SET @value = 123;

SELECT IIF(@value > 100, '> 100', '<= 100') AS OneHundred;

SELECT
       FirstName, LastName,
       IIF(CHARINDEX('a', LastName) != 0, 'Letter A in name', '') AS AinName
FROM Person.Person;

-- 1 = OK, 2 = GOOD, 3 = BAD
SELECT CHOOSE(2, 'OK', 'GOOD', 'BAD') AS Status;

-- 0 = No emails, 1 = want emails, 2 = different emails
SELECT CHOOSE(EmailPromotion + 1, 'No Emails', 'Some Emails', 'All Emails')
FROM Person.Person;

DECLARE @letter CHAR(1);
SET @letter = 'c';

SELECT IIF(@letter = 'a', 'It is an A',
            IIF(@letter = 'b', 'It is a B',
                IIF(@letter = 'c', 'It is a C', 'It is NOT A, B, or C')))
    AS LetterCheck;

SELECT CASE @letter
        WHEN 'a' THEN 'It is an A'
        WHEN 'b' THEN 'It is a B'
        WHEN 'c' THEN 'It is a C'
        ELSE 'It is NOT A, B, or C'
        END AS LetterCheck;

DECLARE @letter CHAR(1);
SET @letter = 'c';
SELECT CASE
        WHEN @letter = 'a' THEN 'It is an A'
        WHEN @letter = 'b' THEN 'It is a B'
        WHEN @letter = 'c' THEN 'It is a C'
        ELSE 'It is NOT A, B, or C'
        END AS LetterCheck3;


SELECT   ProductNumber, Name, "Price Range" =
      CASE
         WHEN ListPrice =  0 THEN 'Mfg item - not for resale'
         WHEN ListPrice < 50 THEN 'Under $50'
         WHEN ListPrice >= 50 and ListPrice < 250 THEN 'Under $250'
         WHEN ListPrice >= 250 and ListPrice < 1000 THEN 'Under $1000'
         ELSE 'Over $1000'
      END
FROM Production.Product
ORDER BY ProductNumber ;
GO

-- locates the first non-null value in a list of values
SELECT COALESCE(NULL, NULL, NULL, 1, 2, 3, 4, 5) AS Number;

SELECT COALESCE(JobTitle, FirstName, LastName) AS Title
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID;

-- replace JobTitle with 'Customer'
SELECT ISNULL(JobTitle, 'Customer'), FirstName, LastName AS Title
FROM Person.Person p
LEFT OUTER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID;

SELECT JobTitle,
       (SELECT FirstName + ' ' + LastName
        FROM Person.Person p WHERE p.BusinessEntityID = e.BusinessEntityID)
FROM HumanResources.Employee e;

SELECT PersonType, FirstName, LastName
FROM Person.Person;

SELECT JobTitle FROM HumanResources.Employee
WHERE BusinessEntityID IN
    (SELECT BusinessEntityID FROM Person.Person WHERE PersonType = 'SC');

SELECT FirstName, LastName FROM Person.Person
WHERE BusinessEntityID IN
    (SELECT CustomerID FROM Sales.Customer);