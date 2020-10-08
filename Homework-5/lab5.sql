IF OBJECT_ID (N'dbo.createTableFunction', N'FN') IS NOT NULL  
    DROP FUNCTION createTableFunction;  
GO  
CREATE FUNCTION dbo.createTableFunction(@TableName varchar(100))  
RETURNS varchar(max)
AS   
BEGIN  
    DECLARE @result varchar(MAX);
	
	SELECT @result = CONCAT('SELECT 
CONCAT(''CREATE TABLE '',TABLE_NAME, '' ('') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = ''', @TableName, 
''' UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, '' '', cols.DATA_TYPE, 
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		(''('', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), '')'') 
	Else '''' 
	END)
, CASE WHEN cols.COLUMN_NAME = ''ID''
	THEN
		('' IDENTITY (1,1)'')
	ELSE ''''
	END
,
(CASE WHEN IS_NULLABLE = ''NO'' THEN '' NOT NULL'' ELSE '' NULL'' END),
	CASE 
	WHEN refConst.CONSTRAINT_NAME IS NOT NULL
	Then 
		(CONCAT('' FOREIGN KEY REFERENCES '', constKeys.TABLE_NAME, ''('', constKeys.COLUMN_NAME, '')'')) 
	END
, 
'','') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
 WHERE cols.TABLE_NAME = ''', @TableName,
''' UNION ALL
SELECT 
CONCAT(''PRIMARY KEY ('', k.COLUMN_NAME, '')'')
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS as t JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as k ON t.CONSTRAINT_NAME = k.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as r ON t.CONSTRAINT_NAME = r.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as a ON a.CONSTRAINT_NAME = r.UNIQUE_CONSTRAINT_NAME
WHERE t.TABLE_NAME = ''', @TableName, ''' and t.CONSTRAINT_TYPE = ''PRIMARY KEY''
UNION ALL
SELECT '')''');
    RETURN @result;  
END; 

  IF OBJECT_ID (N'dbo.Pricing', N'FN') IS NOT NULL  
    DROP FUNCTION Pricing;  
GO  
CREATE FUNCTION dbo.Pricing(@SupplyID int, @Quantity int)
RETURNS decimal(18,2)
AS   
BEGIN
	DECLARE @result decimal(18,2)
	SELECT @result = (SELECT TOP(1) c.price FROM SupplySales as a JOIN Supplies as b ON a.SupplyID = b.ID JOIN Sales as c ON a.SalesID = c.ID WHERE a.SupplyID = @SupplyID) * @Quantity
	RETURN @result;
END;

  SELECT * FROM SupplySales as a JOIN Supplies as b ON a.SupplyID = b.ID JOIN Sales as c ON a.SalesID = c.ID where supplyid = 1

  SELECT dbo.createTableFunction('Taverns')

  SELECT b.Name, c.Price, dbo.Pricing(1, 10) FROM SupplySales as a JOIN Supplies as b ON a.SupplyID = b.ID JOIN Sales as c ON a.SalesID = c.ID where supplyid = 1
