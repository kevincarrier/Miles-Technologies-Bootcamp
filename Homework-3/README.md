# Miles-Technologies-Bootcamp
## Homework 3

<ol>
<li>The system should also be able to track Rooms. Rooms should have a status and an associated tavern. 
There should be a way to track Room Stays which will contain a sale, guest, room, the date it was stayed in and the rate</li>
<li>Write a query that returns guests with a birthday before 2000.</li>
<li>Write a query to return rooms that cost more than 100 gold a night</li>
<li>Write a query that returns UNIQUE guest names.</li>
<li>Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]</li>
<li>Write a query that returns the top 10 highest price sales</li>
<li>Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference typically with just an ID and a name. 
This should be a dynamic combining of all of the tables</li>
<li>Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)</li>
<li>Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements 
(See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
<ul><li>Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)</li></ul>
</li>
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
(CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
<br/>
Then CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)),
<br/>
')') Else '' END), ',') as queryPiece FROM
<br/>
INFORMATION_SCHEMA.COLUMNS as cols WHERE
<br/>
TABLE_NAME = 'Taverns'
<br/>
UNION ALL
<br/>
SELECT ')';

