USE AdventureWorks2017;
GO
SELECT Name FROM Purchasing.Vendor
ORDER BY Name DESC;
GO
ALTER TABLE Purchasing.PurchaseOrderHeader
DROP CONSTRAINT FK_PurchaseOrderHeader_Vendor_VendorID;
GO
ALTER TABLE Purchasing.ProductVendor
DROP CONSTRAINT FK_ProductVendor_Vendor_BusinessEntityID;
GO
ALTER TABLE Purchasing.Vendor
DROP CONSTRAINT PK_Vendor_BusinessEntityID;
GO
DROP INDEX PK_Vendor_BusinessEntityID
ON Purchasing.Vendor;
GO
CREATE CLUSTERED INDEX IX__Vendor__Name
ON Purchasing.Vendor (Name DESC);
GO

