
USE Chinook;
GO

BEGIN TRANSACTION;
BEGIN TRY
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress,
                     BillingCity, BillingState, BillingCountry, BillingPostalCode, Total)
VALUES (503, 1, GETDATE(), N'123 Somewhere Dr.', N'Halifax', N'NS', N'Canada', N'H0H0H0', 100.00);

INSERT INTO InvoiceLine (InvoiceLineId, InvoiceId, TrackId, UnitPrice, Quantity)
VALUES (2503, 503, 1, 0.99, 1);
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Invoice not inserted!'
    END
END CATCH
IF @@TRANCOUNT > 0
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Invoice successfully inserted!'
END