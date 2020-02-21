USE AdventureWorks2017;
GO
SELECT StockedQty FROM Production.WorkOrder
WHERE StockedQty > 0;
GO
CREATE INDEX IX__WorkOrder__StockedQty
ON Production.WorkOrder (StockedQty);
GO