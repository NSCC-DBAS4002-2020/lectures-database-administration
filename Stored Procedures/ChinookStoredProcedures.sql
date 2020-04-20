
USE Chinook;
GO

SELECT * FROM Employee;
GO

DECLARE @reportsTo INT;
DECLARE @employeeId INT = 0;
DECLARE @name VARCHAR(32);
DECLARE @line VARCHAR(80);

SELECT TOP 1 @reportsTo = ReportsTo, @name = CONCAT(FirstName, ' ', LastName),
             @employeeId = EmployeeId
FROM Employee
WHERE EmployeeId > @employeeId
ORDER BY EmployeeId;
WHILE @@ROWCOUNT > 0
BEGIN
    SET @line = 'name = ' + @name;
    SET @line += ', reportsTo = ' +
          IIF(@reportsTo IS NULL, 'no one', CAST(@reportsTo AS VARCHAR));
    IF @reportsTo IS NULL
        SET @line += ', Big raise for ' + @name;
    ELSE
        SET @line += ', No raise for ' + @name;
    PRINT @line;
    SELECT TOP 1 @reportsTo = ReportsTo, @name = CONCAT(FirstName, ' ', LastName),
                 @employeeId = EmployeeId
    FROM Employee
    WHERE EmployeeId > @employeeId
    ORDER BY EmployeeId;
END
GO

CREATE VIEW vw_PublicEmployeeInformation
AS
    SELECT EmployeeId, FirstName, LastName, Email, Title
    FROM Employee
    WHERE ReportsTo IS NOT NULL;
GO

SELECT * FROM vw_PublicEmployeeInformation;

CREATE VIEW vw_InvoiceInformation
AS
    SELECT i.InvoiceId, InvoiceDate, Total, Name, Bytes, IL.UnitPrice,
           Quantity, FirstName, LastName, Email
    FROM Invoice i
    INNER JOIN InvoiceLine IL ON i.InvoiceId = IL.InvoiceId
    INNER JOIN Track T ON IL.TrackId = T.TrackId
    INNER JOIN Customer C ON i.CustomerId = C.CustomerId;
GO

SELECT * FROM vw_InvoiceInformation;

