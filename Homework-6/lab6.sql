--Create a Stored Procedure that Adds A Supply Sale and deducts from the Tavern Inventory appropriately
DROP PROCEDURE IF EXISTS AddSupplySale;  
GO
CREATE PROCEDURE AddSupplySale(@SupplyID int, @SalesID int)
AS
DECLARE @SupplySalesID int
SET @SupplySalesID = (SELECT MAX(ID) + 1 FROM SupplySales)

INSERT INTO SupplySales
(ID, SupplyID, SalesID)
Values
(@SupplySalesID, @SupplyID, @SalesID)
GO

--Move the Inventory Modification step into a trigger
DROP TRIGGER IF EXISTS DeductFromInventory;  
GO
CREATE TRIGGER DeductFromInventory
ON SupplySales
AFTER INSERT
AS 
BEGIN
	DECLARE @SupplyID int, @TavernID int, @SalesID int
	SET @SupplyID = (SELECT TOP 1 SupplyID FROM inserted);
	SET @SalesID = (SELECT TOP 1 SalesID FROM inserted);
	SET @TavernID = (SELECT TOP 1 TavernID FROM Sales where ID = @SalesID)


	UPDATE Inventory SET CurrentCount = CurrentCount - 1 where SupplyID = @SupplyID AND TavernID = @TavernID;
END
GO

--Create a Trigger to “order” more supply in the form a Supply Received entry. Remember to update supplies.
DROP TRIGGER IF EXISTS OrderMoreSupply;
GO
CREATE TRIGGER OrderMoreSupply
ON Inventory
AFTER UPDATE
AS
BEGIN
	IF (SELECT TOP 1 CurrentCount FROM inserted) = 0
		BEGIN
			DECLARE @SupplyID int, @TavernID int
			SET @SupplyID = (SELECT TOP 1 SupplyID FROM inserted)
			SET @TavernID = (SELECT TOP 1 TavernID FROM inserted)


			INSERT INTO Received
			(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
			VALUES
			((SELECT MAX(ID) + 1 FROM Received), @SupplyID, @TavernID, 1200.00, 10.00, GETDATE());
			UPDATE Inventory SET CurrentCount = 10 where SupplyID = @SupplyID AND TavernID = @TavernID;
		END
END
GO



--EXEC AddSupplySale 1, 9

--SELECT * FROM Inventory where SupplyID = 1

--SELECT * FROM Sales where ID = 1

