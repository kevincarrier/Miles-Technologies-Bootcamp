/*
	Kevin Carrier	10/10/2020
	Miles Technologies Bootcamp - Homework 6
*/


/*
	Drop Tables
*/
DROP TABLE IF EXISTS [RoomStays]
GO

DROP TABLE IF EXISTS [Rooms]
GO

DROP TABLE IF EXISTS [RoomStatus]
GO

DROP TABLE IF EXISTS [SupplySales]
GO

DROP TABLE IF EXISTS [Levels]
GO

DROP TABLE IF EXISTS [Classes]
GO

DROP TABLE IF EXISTS [Guests]
GO

DROP TABLE IF EXISTS [GuestStatuses]
GO

DROP TABLE IF EXISTS [Received]
GO

DROP TABLE IF EXISTS [Inventory]
GO

DROP TABLE IF EXISTS [Supplies]
GO

DROP TABLE IF EXISTS [Sales]
GO

DROP TABLE IF EXISTS [Services]
GO

DROP TABLE IF EXISTS [ServiceStatuses]
GO

DROP TABLE IF EXISTS [Taverns]
GO

DROP TABLE IF EXISTS [Location]
GO

DROP TABLE IF EXISTS [Users]
GO

DROP TABLE IF EXISTS [Roles]
GO

/*
	Create Tables
*/
CREATE TABLE [Roles](
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
	Description varchar(MAX)
)
GO

CREATE TABLE [Users](
	ID int NOT NULL,
	Name varchar(250) NOT NULL,
	RoleID int NOT NULL
)
GO

CREATE TABLE [Location](
	ID int NOT NULL,
	Name varchar(250) NOT NULL
)
GO

CREATE TABLE [Taverns](
	ID int NOT NULL,
	Name varchar(250) NOT NULL,
	LocationID int NOT NULL,
	OwnerID int NOT NULL,
	NumberOfFloors int
)
GO

CREATE TABLE [Supplies](
    ID int NOT NULL,
    Name varchar(100) NOT NULL,
    Unit varchar(100)
)
GO

CREATE TABLE [Inventory](
    ID int NOT NULL,
    SupplyID int NOT NULL,
    TavernID int NOT NULL,
    CurrentCount int NOT NULL,
    LastUpdated datetime NOT NULL
)
GO

CREATE TABLE [Received](
    ID int NOT NULL,
    SupplyID int NOT NULL,
    TavernID int NOT NULL,
    Cost decimal(18,2) NOT NULL,
    AmountReceived decimal(18,2) NOT NULL,
    DateReceived datetime NOT NULL
)
GO

CREATE TABLE [ServiceStatuses](
    ID int NOT NULL,
    Status varchar(100) NOT NULL
)
GO

CREATE TABLE [Services](
    ID int NOT NULL,
    Name varchar(100) NOT NULL,
    StatusID int NOT NULL,
    TavernID int NOT NULL
)
GO

CREATE TABLE [Sales](
    ID int NOT NULL,
    ServiceID int NOT NULL,
    GuestID int NOT NULL,
    Price decimal(18,2) NOT NULL,
    DatePurchased datetime NOT NULL,
    AmountPurchased decimal(18,2) NOT NULL,
    TavernID int NOT NULL
)
GO

CREATE TABLE [GuestStatuses](
	ID int NOT NULL,
    Status varchar(100) NOT NULL
)
GO

CREATE TABLE [Guests](
	ID int NOT NULL,
	Name varchar(250) NOT NULL,
	Notes varchar(MAX),
	Birthdate date NOT NULL,
	Cakeday date,
	StatusID int NOT NULL,
)
GO

CREATE TABLE [Classes](
	ID int NOT NULL,
	Name varchar(50) NOT NULL,
)
GO

CREATE TABLE [Levels](
	ID int NOT NULL,
	GuestID int NOT NULL,
	ClassID int NOT NULL,
	Level int NOT NULL,
	Date date NOT NULL
)
GO

CREATE TABLE [SupplySales](
	ID int NOT NULL,
	SupplyID int NOT NULL,
	SalesID int NOT NULL
)
GO

CREATE TABLE [RoomStatus](
	ID int NOT NULL,
	Name varchar(100) NOT NULL
)
GO

CREATE TABLE [Rooms](
	ID int NOT NULL,
	RoomName varchar(100) NOT NULL,
	RoomStatusID int NOT NULL,
	TavernID int NOT NULL
)
GO

CREATE TABLE [RoomStays](
	ID int NOT NULL,
	Sale decimal(18,2) NOT NULL,
	GuestID int NOT NULL,
	RoomID int NOT NULL,
	DateOfStay datetime NOT NULL,
	Rate decimal(18,2) NOT NULL
)
GO


/*
	Add Keys
*/
ALTER TABLE Roles ADD PRIMARY KEY (ID)
GO

ALTER TABLE Users ADD PRIMARY KEY (ID)
GO
ALTER TABLE Users ADD FOREIGN KEY (RoleID) REFERENCES Roles (ID)
GO

ALTER TABLE Location ADD PRIMARY KEY (ID)
GO

ALTER TABLE Taverns ADD PRIMARY KEY (ID)
GO
ALTER TABLE Taverns ADD FOREIGN KEY (LocationID) REFERENCES Location (ID)
GO
ALTER TABLE Taverns ADD FOREIGN KEY (OwnerID) REFERENCES Users (ID)
GO

ALTER TABLE Supplies ADD PRIMARY KEY (ID)
GO

ALTER TABLE Inventory ADD PRIMARY KEY (ID)
GO
ALTER TABLE Inventory ADD FOREIGN KEY (SupplyID) REFERENCES Supplies (ID)
GO
ALTER TABLE Inventory ADD FOREIGN KEY (TavernID) REFERENCES Taverns (ID)
GO

ALTER TABLE Received ADD PRIMARY KEY (ID)
GO
ALTER TABLE Received ADD FOREIGN KEY (SupplyID) REFERENCES Supplies (ID)
GO
ALTER TABLE Received ADD FOREIGN KEY (TavernID) REFERENCES Taverns (ID)
GO

ALTER TABLE ServiceStatuses ADD PRIMARY KEY (ID)
GO

ALTER TABLE Services ADD PRIMARY KEY (ID)
GO
ALTER TABLE Services ADD FOREIGN KEY (StatusID) REFERENCES ServiceStatuses (ID)
GO
ALTER TABLE Services ADD FOREIGN KEY (TavernID) REFERENCES Taverns (ID)
GO

ALTER TABLE Sales ADD PRIMARY KEY (ID)
GO
ALTER TABLE Sales ADD FOREIGN KEY (ServiceID) REFERENCES Services (ID)
GO
ALTER TABLE Sales ADD FOREIGN KEY (GuestID) REFERENCES Users (ID)
GO
ALTER TABLE Sales ADD FOREIGN KEY (TavernID) REFERENCES Taverns (ID)
GO

ALTER TABLE GuestStatuses ADD PRIMARY KEY (ID)
GO

ALTER TABLE Guests ADD PRIMARY KEY (ID)
GO
ALTER TABLE Guests ADD FOREIGN KEY (StatusID) REFERENCES GuestStatuses (ID)
GO

ALTER TABLE Classes ADD PRIMARY KEY (ID)
GO

ALTER TABLE Levels ADD PRIMARY KEY (ID)
GO
ALTER TABLE Levels ADD FOREIGN KEY (GuestID) REFERENCES Guests (ID)
GO
ALTER TABLE Levels ADD FOREIGN KEY (ClassID) REFERENCES Classes (ID)
GO

ALTER TABLE SupplySales ADD PRIMARY KEY (ID)
GO
ALTER TABLE SupplySales ADD FOREIGN KEY (SupplyID) REFERENCES Supplies (ID)
GO
ALTER TABLE SupplySales ADD FOREIGN KEY (SalesID) REFERENCES Sales (ID)
GO

ALTER TABLE RoomStatus ADD PRIMARY KEY (ID)
GO

ALTER TABLE Rooms ADD PRIMARY KEY (ID)
GO
ALTER TABLE Rooms ADD FOREIGN KEY (RoomStatusID) REFERENCES RoomStatus (ID)
GO
ALTER TABLE Rooms ADD FOREIGN KEY (TavernID) REFERENCES Taverns (ID)
GO

ALTER TABLE RoomStays ADD PRIMARY KEY (ID)
GO
ALTER TABLE RoomStays ADD FOREIGN KEY (GuestID) REFERENCES Guests (ID)
GO
ALTER TABLE RoomStays ADD FOREIGN KEY (RoomID) REFERENCES Rooms (ID)
GO

/*
	Insert Data - SUCCESSFULLY
*/
INSERT INTO Roles
(ID, Name, Description)
VALUES
(1, 'Owner', 'Owner of the tavern'),(2, 'Employee', 'Employee of the tavern'),(3, 'Customer', 'Customer of the tavern'),
(4, 'Truck Driver', null),(5, 'Investor', null),(6, 'Admin', 'Administrator')
GO

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(1, 'Kevin Carrier', 1),(2, 'Chris Miles', 6),(3, 'Kevin Carrier', 3),(4, 'Crystal Vu', 1),(5, 'David Kirkman', 2),
(6, 'John Graham', 1),(7, 'Chris Camac', 1),(8, 'Victoria Tamburro', 2),(9, 'John Doe', 3),(10, 'Admin Admin', 6)
GO

INSERT INTO Location
(ID, Name)
VALUES
(1, '200 Country Club Pkwy, Mt Laurel Township, NJ 08054'),(2, '123 Tavern Ave, Camden, NJ 12345'),(3, '1442 Marlton Pike East, Cherry Hill, NJ 08034'),
(4, '2 S Centre St, Merchantville, NJ 08109'),(5, '456 Tavern Ave, Camden, NJ 12345'),(6, ''),(7, '100 Mt Holly Bypass, Lumberton, NJ 08048')
GO

INSERT INTO Taverns
(ID, Name, LocationID, OwnerID, NumberOfFloors)
VALUES
(1, 'Seven Tap Tavern', 1, 1, 4),(2, 'The Farm and Fisherman Tavern', 3, 4, 2),(3, 'Blue Monkey Tavern', 4, 7, 1),
(4, 'Hidden Tavern', 6, 6, 1),(5, 'Hidden Tavern II', 6, 6, 3),(6, 'Miles Tavern', 7, 2, 2)
GO

INSERT INTO ServiceStatuses
(ID, Status)
VALUES
(1, 'Active'),(2, 'Inactive'),(3, 'Out of Stock'),(4, 'Discontinued'),(5, 'Reordered')
GO

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(1, 'Lime Juice', 'Ounce'),(2, 'Dogfish 90 Minute IPA', 'IPA'),(3, 'Ale Ale Ale', 'Strong Ale'),
(4, 'Cranberry Juice', 'Ounce'),(5, 'Orange Juice', 'Ounce')
GO

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(1, 2, 1, 300, '2020-09-22'),(2, 3, 1, 250, '2020-09-22'),(3, 2, 3, 1000, '2020-09-20'),
(4, 1, 2, 15, '2020-09-19'),(5, 1, 1, 15, '2020-09-19'),(6, 5, 2, 30, '2020-09-20')
GO

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(1, 2, 1, 7.50, 10.00, '2020-09-20'),(2, 2, 3, 7.50, 10.00, '2020-09-20'),(3, 2, 1, 7.50, 7.50, '2020-09-21'),
(4, 3, 1, 6.00, 6.00, '2020-09-22'),(5, 3, 3, 4.00, 5.00, '2020-09-22')
GO

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(1, 'Pool', 1, 1),(2, 'Weapon Sharpening', 1, 1),(3, 'Pool', 1, 3),(4, 'Pool', 2, 3),(5, 'Pool', 1, 4),(6, 'Darts', 1, 1)
GO

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(1, 1, 3, 15.00, '2020-09-09', 20.00, 4),(2, 1, 3, 10.00, '2020-09-12', 10.00, 5),(3, 2, 9, 15.00, '2020-08-28', 20.00, 4),
(4, 1, 9, 15.00, '2020-09-09', 15.00, 1),(5, 2, 9, 15.00, '2020-09-09', 15.00, 1),
(6, 6, 3, 35.00, '2020-09-09', 40.00, 4),(7, 1, 3, 10.00, '2020-09-12', 10.00, 5),(8, 2, 9, 15.00, '2020-08-28', 20.00, 4),
(9, 1, 9, 15.00, '2020-09-09', 15.00, 1),(10, 2, 9, 15.00, '2020-09-09', 15.00, 1),
(11, 6, 3, 35.00, '2020-09-09', 50.00, 4),(12, 1, 3, 10.00, '2020-09-12', 10.00, 5),(13, 2, 9, 15.00, '2020-08-28', 20.00, 4)
GO

INSERT INTO GuestStatuses
(ID, Status)
VALUES
(1, 'Sick'),(2, 'Fine'),(3, 'Hangry'),(4, 'Raging'),(5, 'Placid')
GO

INSERT INTO Guests
(ID, Name, Notes, Birthdate, Cakeday, StatusID)
VALUES
(1, 'Leonardo DiCaprio', 'Actor', '1974-11-11', '1974-11-11', 5), (2, 'Kevin Hart', 'Comedian', '1979-07-06', '1979-07-04', 3), (3, 'Miley Cyrus', 'Singer', '1992-11-23', '1992-11-25', 4), 
(4, 'Taylor Swift', 'Singer', '1989-12-13', '1989-12-12', 5), (5, 'Oprah Winfrey', null, '1954-01-29', '1954-01-29', 2), (6, 'Finn Wolfhard', 'Actor From Stranger Things', '2002-12-23', '2002-12-25', 3),
(7, 'Miley Cyrus', 'Singer', '1992-11-23', '1992-11-25', 4)
GO

INSERT INTO Classes
(ID, Name)
VALUES
(1, 'Mage'), (2, 'Fighter'), (3, 'Archer'), (4, 'Monk'), (5, 'Assassin')
GO

INSERT INTO Levels
(ID, GuestID, ClassID, Level, Date)
VALUES
(1, 4, 3, 7, '2020-09-25'), (2, 1, 2, 13, '2020-09-26'), (3, 5, 1, 2, '2020-09-26'),(4, 2, 5, 11, '2020-09-26'), (5, 3, 1, 4, '2020-09-28'),(6, 5, 4, 6, '2020-09-28'),
(7, 1, 5, 10, '2020-10-2')
GO

INSERT INTO SupplySales
(ID, SupplyID, SalesID)
VALUES
(1, 2, 4), (2, 3, 4), (3, 1, 3), (4, 2, 3), (5, 3, 3)
GO

INSERT INTO RoomStatus
(ID, Name)
VALUES
(1, 'Vacant'), (2, 'Not Vacant'), (3, 'Under Maintainence')
GO

INSERT INTO Rooms
(ID, RoomName, RoomStatusID, TavernID)
VALUES
(1, 'Spiderman', 2, 1),(2, 'Iron Man', 1, 3),(3, 'Captian America', 1, 1),(4, 'Hulk', 3, 3),(5, 'Thor', 2, 2)
GO


INSERT INTO RoomStays
(ID, Sale, GuestID, RoomID, DateOfStay, Rate)
VALUES
(1, 600, 2, 1, '9/3/2020', 100), (2, 910, 4, 2, '3/9/2020', 65), (3, 360, 1, 5, '6/18/2020', 180), (4, 875, 3, 3, '12/25/2019', 125), (5, 500, 3, 1, '7/4/2020', 100), (6, 125, 2, 3, '10/1/2020', 125),
(7, 400, 3, 4, '9/30/2020', 100), (8, 910, 4, 2, '3/9/2020', 65), (9, 360, 1, 5, '6/18/2020', 180), (10, 875, 3, 3, '12/25/2019', 125), (11, 500, 3, 1, '7/4/2020', 100),(12, 125, 2, 3, '10/1/2020', 125)
GO


/*
	Insert Data - FAILED BECAUSE OF FOREIGN KEY CONSTRAINTS
*/

/*
--Roles Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Roles
(ID, Name, Description)
VALUES
(1, 'Auditor', 'Audits the Tavern')
GO
*/

/*
--Users Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Users
(ID, Name, RoleID)
VALUES
(1, 'Carson Wentz', 1)
GO
*/
/*
--Users Table
--Conflict on RoleID, RoleID 10 does not exist in Roles Table
INSERT INTO Users
(ID, Name, RoleID)
VALUES
(10, 'Carson Wentz', 10)
GO
*/

/*
--Location Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Location
(ID, Name)
VALUES
(1, '100 Mt Holly Bypass, Lumberton, NJ 08048')
GO
*/

/*
--Taverns Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Taverns
(ID, Name, LocationID, OwnerID, NumberOfFloors)
VALUES
(1, 'Seven Tap Tavern', 1, 1, 4)
GO
*/
/*
--Taverns Table
--Conflict on LocationID, LocationID 20 does not exist in Location Table
INSERT INTO Taverns
(ID, Name, LocationID, OwnerID, NumberOfFloors)
VALUES
(10, 'Seven Tap Tavern', 20, 1, 4)
GO
*/
/*
--Taverns Table
--Conflict on OwnerID, OwnerID 20 does not exist in Users Table
INSERT INTO Taverns
(ID, Name, LocationID, OwnerID, NumberOfFloors)
VALUES
(10, 'Seven Tap Tavern', 1, 20, 4)
GO
*/

/*
--ServiceStatuses Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO ServiceStatuses
(ID, Status)
VALUES
(1, 'Pending')
GO
*/

/*
--Supplies Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(1, 'Lemon Juice', 'Ounce')
GO
*/

/*
--Inventory Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(1, 2, 1, 300, '2020-09-22')
GO
*/
/*
--Inventory Table
--Conflict on SupplyID, SupplyID 20 does not exist in Supplies Table
INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(10, 20, 1, 300, '2020-09-22')
GO
*/
/*
--Inventory Table
--Conflict on TavernID, TavernID 20 does not exist in Taverns Table
INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(11, 2, 20, 300, '2020-09-22')
GO
*/

/*
--Received Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(1, 2, 1, 7.50, 10.00, '2020-09-20')
GO
*/
/*
--Received Table
--Conflict on SupplyID, SupplyID 20 does not exist in Supplies Table
INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(10, 20, 1, 7.50, 10.00, '2020-09-20')
GO
*/
/*
--Received Table
--Conflict on TavernID, TavernID 20 does not exist in Taverns Table
INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(11, 2, 20, 7.50, 10.00, '2020-09-20')
GO
*/

/*
--Services Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(1, 'Arcade', 1, 1)
GO
*/
/*
--Services Table
--Conflict on StatusID, StatusID 10 does not exist in ServiceStatuses Table
INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(11, 'Arcade', 10, 1)
GO
*/
/*
--Services Table
--Conflict on TavernID, TavernID 20 does not exist in Taverns Table
INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(12, 'Arcade', 1, 20)
GO
*/

/*
--Sales Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(1, 1, 3, 15.00, '2020-09-09', 20.00, 4)
GO
*/
/*
--Sales Table
--Conflict on ServiceID, ServiceID 20 does not exist in Services Table
INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(10, 20, 3, 15.00, '2020-09-09', 20.00, 4)
GO
*/
/*
--Sales Table
--Conflict on GuestID, GuestID 20 does not exist in Users Table
INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(11, 1, 20, 15.00, '2020-09-09', 20.00, 4)
GO
*/
/*
--Sales Table
--Conflict on TavernID, TavernID 20 does not exist in Taverns Table
INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(12, 1, 3, 15.00, '2020-09-09', 20.00, 20)
GO
*/

/*
--GuestStatuses Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO GuestStatuses
(ID, Status)
VALUES
(1, 'Sleepy')
GO
*/

/*
--Guests Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Guests
(ID, Name, Notes, Birthdate, Cakeday, StatusID)
VALUES
(1, 'Brad Pitt', 'Actor', '1963-12-18', '1963-12-25', 5)
GO
*/
/*
--Guests Table
--Conflict on StatusID, StatusID 20 does not exist in GuestStatuses Table
INSERT INTO Guests
(ID, Name, Notes, Birthdate, Cakeday, StatusID)
VALUES
(10, 'Brad Pitt', 'Actor', '1963-12-18', '1963-12-25', 20)
GO
*/

/*
--Classes Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Classes
(ID, Name)
VALUES
(1, 'Axe Thrower')
GO
*/

/*
--Levels Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Levels
(ID, GuestID, ClassID, Level, Date)
VALUES
(1, 4, 3, 7, '2020-09-25')
GO
*/
/*
--Levels Table
--Conflict on GuestID, GuestID 20 does not exist in Guests Table
INSERT INTO Levels
(ID, GuestID, ClassID, Level, Date)
VALUES
(10, 20, 3, 7, '2020-09-25')
GO
*/
/*
--Levels Table
--Conflict on ClassID, ClassID 20 does not exist in Classes Table
INSERT INTO Levels
(ID, GuestID, ClassID, Level, Date)
VALUES
(11, 4, 20, 7, '2020-09-25')
GO
*/

/*
--SupplySales Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO SupplySales
(ID, SupplyID, SalesID)
VALUES
(1, 2, 4)
GO
*/
/*
--SupplySales Table
--Conflict on SupplyID, SupplyID 20 does not exist in Supplies Table
INSERT INTO SupplySales
(ID, SupplyID, SalesID)
VALUES
(10, 20, 4)
GO
*/
/*
--SupplySales Table
--Conflict on SalesID, SalesID 20 does not exist in Sales Table
INSERT INTO SupplySales
(ID, SupplyID, SalesID)
VALUES
(11, 2, 20)
GO
*/
/*
--RoomStatus Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO RoomStatus
(ID, Name)
VALUES
(3, 'Build In Future')
GO
*/
/*
--Rooms Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO Rooms
(ID, RoomName, RoomStatusID, TavernID)
VALUES
(1, 'Black Panther', 2, 1)
GO

--Rooms Table
--Conflict on RoomStatusID, RoomStatusID 20 does not exist in RoomStatus Table
INSERT INTO Rooms
(ID, RoomName, RoomStatusID, TavernID)
VALUES
(6, 'Black Panther', 20, 1)
GO

--Rooms Table
--Conflict on TavernID, TavernID 20 does not exist in Tavern Table
INSERT INTO Rooms
(ID, RoomName, RoomStatusID, TavernID)
VALUES
(6, 'Black Panther', 2, 20)
GO
*/
/*
--RoomStays Table
--Duplicate ID, ID is a primary key and must be unique
INSERT INTO RoomStays
(ID, Sale, GuestID, RoomID, DateOfStay, Rate)
VALUES
(1, 200, 5, 1, '1/18/2020', 100)
GO

--RoomStays Table
--Conflict on GuestID, GuestID 20 does not exist in Guests Table
INSERT INTO RoomStays
(ID, Sale, GuestID, RoomID, DateOfStay, Rate)
VALUES
(10, 200, 20, 1, '1/18/2020', 100)
GO

--RoomStays Table
--Conflict on RoomID, RoomID 20 does not exist in Rooms Table
INSERT INTO RoomStays
(ID, Sale, GuestID, RoomID, DateOfStay, Rate)
VALUES
(10, 200, 5, 20, '1/18/2020', 100)
GO
*/

/*
	HW 3 Queries 
*/

--Write a query that returns guests with a birthday before 2000.
SELECT * FROM Guests where YEAR(Birthdate) < 2000 
--Write a query to return rooms that cost more than 100 gold a night
SELECT * FROM RoomStays where Rate > 100
--Write a query that returns UNIQUE guest names. 
SELECT DISTINCT (Name) FROM Guests
--Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]
SELECT Name FROM Guests order by name asc
--Write a query that returns the top 10 highest price sales
SELECT TOP(10) * FROM RoomStays order by Sale desc
--Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference typically with just an ID and a name. 
--This should be a dynamic combining of all of the tables
SELECT * FROM Classes 
UNION ALL
SELECT * FROM GuestStatuses
UNION ALL
SELECT * FROM Location
UNION ALL
SELECT * FROM RoomStatus
UNION ALL
SELECT * FROM ServiceStatuses
--Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)
SELECT g.Name, c.Name, l.Level, CASE WHEN l.Level BETWEEN 1 AND 10 THEN 'lvl 1-10' WHEN l.Level BETWEEN 11 AND 20 THEN 'lvl 11-20' ELSE '' END AS 'Level Group' FROM Levels as l JOIN Guests as g ON l.GuestID = g.ID JOIN Classes c ON l.ClassID = c.ID
--Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements 
--(See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
--Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)
SELECT
CONCAT('INSERT INTO ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT (cols.COLUMN_NAME, CASE WHEN ORDINAL_POSITION != (SELECT MAX(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'Taverns') THEN ',' ELSE '' END) FROM 
INFORMATION_SCHEMA.COLUMNS as cols WHERE
TABLE_NAME = 'Taverns'
UNION ALL
SELECT ') VALUES'
UNION ALL
SELECT '(50, ''Tech Tavern'', 6, 6, 3)'



--------------------------------------------

/*
	HW 4 Queries
*/

--Write a query to return users who have admin roles
SELECT u.Name FROM Users as u JOIN Roles as r ON u.RoleID = r.ID where r.Name = 'Admin'

---Write a query to return users who have admin roles and information about their taverns
SELECT u.Name as 'Admin', t.Name as 'Tavern Name', l.Name as 'Location', t.NumberOfFloors AS 'Number of Floors' FROM Users as u JOIN Roles as r ON u.RoleID = r.ID JOIN Taverns as t ON t.OwnerID = u.ID JOIN Location as l ON l.ID = t.LocationID where r.Name = 'Admin'

--Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels
SELECT g.Name, c.Name, l.Level FROM Levels as l RIGHT JOIN Guests as g ON l.GuestID = g.ID LEFT JOIN Classes c ON l.ClassID = c.ID order by g.Name asc

--Write a query that returns the top 10 sales in terms of sales price and what the services were
SELECT TOP(10) s.ID as 'Sales ID', s.Price, v.Name FROM Sales as s JOIN Services as v ON s.ServiceID = v.ID ORDER BY s.Price desc, s.ServiceID

--Write a query that returns guests with 2 or more classes
SELECT g.Name FROM Levels as l JOIN Guests as g ON l.GuestID = g.ID GROUP BY g.ID, g.Name HAVING COUNT(*) > 1

--Write a query that returns guests with 2 or more classes with levels higher than 5
SELECT g.Name FROM Levels as l JOIN Guests as g ON l.GuestID = g.ID WHERE l.Level > 5 GROUP BY g.ID, g.Name HAVING COUNT(*) > 1

--Write a query that returns guests with ONLY their highest level class
SELECT g.Name, MAX(l.Level) AS 'Level' FROM Levels as l JOIN Guests as g ON l.GuestID = g.ID GROUP BY g.ID, g.Name

--Write a query that returns guests that stay within a date range. Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)
SELECT r.ID, n.RoomName, g.Name, r.DateOfStay, CAST((r.Sale/r.Rate) as int) as 'Number of Nights', (DateOfStay + (r.Sale/r.Rate)) as 'Checkout'  FROM RoomStays as r JOIN Guests as g ON r.GuestID = g.ID JOIN Rooms as n ON r.RoomID = n.ID
where (DateOfStay > '2020-09-01' and DateOfStay < '2020-10-01') and ((DateOfStay + (r.Sale/r.Rate)) > '2020-09-05' and (DateOfStay + (r.Sale/r.Rate)) < '2020-10-05') 

--Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.
SELECT 
CONCAT('CREATE TABLE ',TABLE_NAME, ' (') as queryPiece 
FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(cols.COLUMN_NAME, ' ', cols.DATA_TYPE, 
(
	CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL 
	Then CONCAT
		('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')') 
	Else '' 
	END)
, CASE WHEN cols.COLUMN_NAME = 'ID'
	THEN
		(' IDENTITY (1,1)')
	ELSE ''
	END
,
(CASE WHEN IS_NULLABLE = 'NO' THEN ' NOT NULL' ELSE ' NULL' END),
	CASE 
	WHEN refConst.CONSTRAINT_NAME IS NOT NULL
	Then 
		(CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')')) 
	END
, 
',') as queryPiece FROM 
INFORMATION_SCHEMA.COLUMNS as cols
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as keys ON 
(keys.TABLE_NAME = cols.TABLE_NAME and keys.COLUMN_NAME = cols.COLUMN_NAME)
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as refConst ON 
(refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
LEFT JOIN 
(SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys 
ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
 WHERE cols.TABLE_NAME = 'Taverns'
UNION ALL
SELECT 
CONCAT('PRIMARY KEY (', k.COLUMN_NAME, ')')
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS as t JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as k ON t.CONSTRAINT_NAME = k.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as r ON t.CONSTRAINT_NAME = r.CONSTRAINT_NAME
LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE as a ON a.CONSTRAINT_NAME = r.UNIQUE_CONSTRAINT_NAME
WHERE t.TABLE_NAME = 'Taverns' and t.CONSTRAINT_TYPE = 'PRIMARY KEY'
UNION ALL
SELECT ')';



--------------------------------------------

/*
	HW 5 Queries
*/

--Write a query to return a “report” of all users and their roles
SELECT u.Name as 'User', r.Name as 'Role', r.Description as 'Role Description' FROM Users as u JOIN Roles as r ON u.RoleID = r.ID

--Write a query to return all classes and the count of guests that hold those classes
SELECT c.Name as 'Class', COUNT(*) as 'Count of Guests' FROM Levels as l RIGHT JOIN Classes as c ON l.ClassID = c.ID GROUP BY c.Name

--Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels.
--Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
SELECT g.Name, c.Name, l.Level, 
CASE WHEN l.Level >= 1 AND l.Level < 5 THEN 'beginner (lvl 1-5)' 
WHEN l.Level >= 5 AND l.Level < 10 THEN 'intermediate (lvl 5-10)' 
WHEN l.Level >= 10 THEN 'expert (lvl 10+)' 
ELSE '' END AS 'Experience' 
FROM Levels as l RIGHT JOIN Guests as g ON l.GuestID = g.ID LEFT JOIN Classes c ON l.ClassID = c.ID order by g.Name asc

--Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
IF OBJECT_ID (N'dbo.guestExperience', N'FN') IS NOT NULL  
    DROP FUNCTION guestExperience;  
GO
CREATE FUNCTION dbo.guestExperience(@Level int)  
RETURNS varchar(100)
AS   
BEGIN  
	DECLARE @result varchar(MAX);
	SELECT @result = (SELECT CASE 
WHEN @Level >= 1 AND @Level < 5 THEN 'beginner (lvl 1-5)' 
WHEN @Level >= 5 AND @Level < 10 THEN 'intermediate (lvl 5-10)' 
WHEN @Level >= 10 THEN 'expert (lvl 10+)' 
ELSE '' END)
	RETURN @result
END;
GO

--Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
IF OBJECT_ID (N'dbo.openRooms', N'IF') IS NOT NULL  
    DROP FUNCTION openRooms;  
GO
CREATE FUNCTION dbo.openRooms(@ParticularDay datetime)  
RETURNS TABLE
AS   
RETURN(
	SELECT  r.RoomName as 'Room Name', t.Name as 'Tavern Name' FROM Rooms r JOIN Taverns t ON r.TavernID = t.ID
where r.ID NOT IN (SELECT DISTINCT s.RoomID FROM RoomStays as s where @ParticularDay BETWEEN s.DateOfStay AND s.DateOfStay + (Sale/Rate)));
GO

--Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
ALTER FUNCTION dbo.openRooms(@MinPrice decimal(18,2), @MaxPrice decimal(18,2))
RETURNS TABLE
AS   
RETURN(
	SELECT DISTINCT r.ID as 'RoomID', r.RoomName as 'Room Name', t.Name as 'Tavern Name', s.Rate FROM Rooms r JOIN Taverns t ON r.TavernID = t.ID JOIN RoomStays s ON s.RoomID = r.ID
where r.ID IN (SELECT DISTINCT s.RoomID FROM RoomStays as s where Rate BETWEEN @MinPrice AND @MaxPrice));
GO

--Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one
INSERT INTO Rooms
(ID, RoomName, RoomStatusID, TavernID)
VALUES
(25, 'Cheapest Room By A Penny', 1, 1)
GO
INSERT INTO RoomStays
(ID, Sale, GuestID, RoomID, DateOfStay, Rate)
VALUES
(25, 600.00, 3, 25, '2020-03-01', (SELECT MIN(Rate)-0.01 FROM openRooms(50,100)))
GO

--------------------------------------------

/*
	HW 6 Queries
*/

--Write a stored procedure that takes a class name and returns all guests that have any levels of that class
DROP PROCEDURE IF EXISTS GuestsInAClass;  
GO
CREATE PROCEDURE GuestsInAClass(@Class varchar(50))
AS
SELECT DISTINCT g.Name FROM Classes as c JOIN Levels as l ON c.ID = l.ClassID JOIN Guests as g ON g.ID = l.GuestID where c.Name = @Class
GO

--Write a stored procedure that takes a guest id and returns the total that guest spent on services
DROP PROCEDURE IF EXISTS GuestTotalSpentOnServices;
GO
CREATE PROCEDURE GuestTotalSpentOnServices(@GuestID int)
AS
SELECT SUM(Price) FROM Sales where GuestID = @GuestID
GO

--Write a stored procedure that takes a level and an optional argument that determines whether the procedure returns guests of that level and higher or that level and lower
DROP PROCEDURE IF EXISTS GuestsOfLevel;
GO
CREATE PROCEDURE GuestsOfLevel(@Level int, @HighLow varchar(50))
AS
IF @HighLow = 'Higher' OR @HighLow = 'High' OR @HighLow = 'H'
	BEGIN
		SELECT DISTINCT g.Name FROM Levels as l JOIN Guests as g ON  l.GuestID = g.ID where Level > @Level 
	END
ELSE IF @HighLow = 'Lower' OR @HighLow = 'Low' OR @HighLow = 'L'
	BEGIN
		SELECT DISTINCT g.Name FROM Levels as l JOIN Guests as g ON  l.GuestID = g.ID where Level < @Level 
	END
ELSE
	BEGIN
		SELECT DISTINCT g.Name FROM Levels as l JOIN Guests as g ON  l.GuestID = g.ID where Level = @Level 
	END
GO

--Write a stored procedure that deletes a Tavern ( don’t run it yet or rollback your transaction if you do )
DROP PROCEDURE IF EXISTS DeleteTavern;
GO
CREATE PROCEDURE DeleteTavern(@TavernID int)
AS
	DELETE FROM Taverns where ID = @TavernID;
GO

--Write a trigger that watches for deleted taverns and use it to remove taverns, supplies, rooms, and services tied to it
DROP TRIGGER IF EXISTS DeleteTavernTies;
GO
CREATE TRIGGER DeleteTavernTies
ON Taverns
AFTER DELETE
AS
BEGIN
	DECLARE @TavernID int
	SET @TavernID = (SELECT TOP 1 ID FROM Deleted)
	
	DELETE FROM Inventory where TavernID = @TavernID
	DELETE FROM Received where TavernID = @TavernID
	DELETE FROM Rooms where TavernID = @TavernID
	DELETE FROM Sales where TavernID = @TavernID
	DELETE FROM Services where TavernID = @TavernID
END
GO

--Write a stored procedure that uses the function from the last assignment that returns open rooms with their prices, and automatically book the lowest price room with a guest for one day
DROP PROCEDURE IF EXISTS AutomaticBooking;
GO
CREATE PROCEDURE AutomaticBooking(@GuestID int, @MinPrice decimal(18,2), @MaxPrice decimal(18,2), @CheckInDate datetime, @NumberOfNights int)
AS
	DECLARE @RoomStayID int, @RoomID int, @Rate decimal(18,2)
	SET @RoomStayID  = (SELECT MAX(ID) + 1 FROM RoomStays)
	SET @RoomID = (SELECT TOP 1 RoomID FROM openRooms(50, 200) order by Rate asc)
	SET @Rate = (SELECT TOP 1 Rate FROM openRooms(50, 200) order by Rate asc)

	INSERT INTO RoomStays
	(ID, GuestID, RoomID, Rate, DateOfStay, Sale)
	VALUES
	(@RoomStayID, @GuestID, @RoomID, @Rate, @CheckInDate, @Rate * @NumberOfNights)
GO

--Write a trigger that watches for new bookings and adds a new sale for the guest for a service (for free if you can in your schema)
DROP TRIGGER IF EXISTS AddSale;
GO
CREATE TRIGGER AddSale
ON RoomStays
AFTER INSERT
AS
BEGIN
	DECLARE @SalesID int, @RoomID int, @TavernID int, @GuestID int, @CheckInDate datetime
	SET @SalesID  = (SELECT MAX(ID) + 1 FROM Sales)
	SET @RoomID =  (SELECT TOP 1 RoomID FROM inserted)
	SET @TavernID = (SELECT TOP 1 TavernID FROM Rooms where ID = @RoomID)
	SET @GuestID = (SELECT TOP 1 GuestID FROM inserted)
	SET @CheckInDate = (SELECT TOP 1 DateOfStay FROM inserted)

	INSERT INTO Sales
	(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
	VALUES
	(@SalesID, 1, @GuestID, 600, @CheckInDate, 605, @TavernID)
END
GO