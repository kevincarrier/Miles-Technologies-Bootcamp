# Miles-Technologies-Bootcamp
## Homework 4

<ol>
<li>Write a query to return users who have admin roles</li>
<li>Write a query to return users who have admin roles and information about their taverns</li>
<li>Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels</li>
<li>Write a query that returns the top 10 sales in terms of sales price and what the services were</li>
<li>Write a query that returns guests with 2 or more classes</li>
<li>Write a query that returns guests with 2 or more classes with levels higher than 5</li>
<li>Write a query that returns guests with ONLY their highest level class</li>
<li>Write a query that returns guests that stay within a date range. 
Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)</li>
<li>Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.</li>
</ol>

Lab:

SELECT 
<br/>
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece
<br/>
FROM INFORMATION_SCHEMA.TABLES
<br/>
WHERE TABLE_NAME = 'Taverns'
<br/>
UNION ALL
<br/>
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
<br/>
(
<br/>
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
<br/>	
  Then CONCAT
<br/>		
    ('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
<br/>	
  Else '' 
<br/>	
  END)
<br/>
, 
<br/>	
  CASE WHEN refConst.CONSTRAINT_NAME IS NOT NULL
<br/>	
  Then 
<br/>		
    (CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
<br/>	
  Else '' 
<br/>	
  END
<br/>
, 
<br/>
',') as queryPiece FROM 
<br/>
INFORMATION_SCHEMA.COLUMNS as cols
<br/>
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
<br/>
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
<br/>
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
<br/>
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
<br/>
LEFT JOIN 
<br/>
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
<br/>
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
<br/>
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
<br/>
WHERE cols.TABLE_NAME = 'Taverns'
<br/>
UNION ALL
<br/>
SELECT ')'; 
