/*
	Kevin Carrier	9/27/2020
	Miles Technologies Bootcamp - Homework 2
*/


/*
	Drop Tables
*/
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

/*
	Insert Data - SUCCESSFULLY
*/
INSERT INTO Roles
(ID, Name, Description)
VALUES
(1, 'Owner', 'Owner of the tavern'),(2, 'Employee', 'Employee of the tavern'),(3, 'Customer', 'Customer of the tavern'),
(4, 'Truck Driver', null),(5, 'Investor', null)
GO

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(1, 'Kevin Carrier', 1),(2, 'Chris Miles', 1),(3, 'Kevin Carrier', 3),(4, 'Crystal Vu', 1),(5, 'David Kirkman', 2),
(6, 'John Graham', 1),(7, 'Chris Camac', 1),(8, 'Victoria Tamburro', 2),(9, 'John Doe', 3)
GO

INSERT INTO Location
(ID, Name)
VALUES
(1, '200 Country Club Pkwy, Mt Laurel Township, NJ 08054'),(2, '123 Tavern Ave, Camden, NJ 12345'),(3, '1442 Marlton Pike East, Cherry Hill, NJ 08034'),
(4, '2 S Centre St, Merchantville, NJ 08109'),(5, '456 Tavern Ave, Camden, NJ 12345'),(6, '')
GO

INSERT INTO Taverns
(ID, Name, LocationID, OwnerID, NumberOfFloors)
VALUES
(1, 'Seven Tap Tavern', 1, 1, 4),(2, 'The Farm and Fisherman Tavern', 3, 4, 2),(3, 'Blue Monkey Tavern', 4, 7, 1),
(4, 'Hidden Tavern', 6, 6, 1),(5, 'Hidden Tavern II', 6, 6, 3)
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
(1, 'Pool', 1, 1),(2, 'Weapon Sharpening', 1, 1),(3, 'Pool', 1, 3),(4, 'Pool', 2, 3),(5, 'Pool', 1, 4)
GO

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(1, 1, 3, 15.00, '2020-09-09', 20.00, 4),(2, 1, 3, 10.00, '2020-09-12', 10.00, 5),(3, 2, 9, 15.00, '2020-08-28', 20.00, 4),
(4, 1, 9, 15.00, '2020-09-09', 15.00, 1),(5, 2, 9, 15.00, '2020-09-09', 15.00, 1)
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
(4, 'Taylor Swift', 'Singer', '1989-12-13', '1989-12-12', 5), (5, 'Oprah Winfrey', null, '1954-01-29', '1954-01-29', 2)
GO

INSERT INTO Classes
(ID, Name)
VALUES
(1, 'Mage'), (2, 'Fighter'), (3, 'Archer'), (4, 'Monk'), (5, 'Assassin')
GO

INSERT INTO Levels
(ID, GuestID, ClassID, Level, Date)
VALUES
(1, 4, 3, 7, '2020-09-25'), (2, 1, 2, 3, '2020-09-26'), (3, 5, 1, 2, '2020-09-26'),(4, 2, 5, 5, '2020-09-26'), (5, 3, 1, 4, '2020-09-28')
GO

INSERT INTO SupplySales
(ID, SupplyID, SalesID)
VALUES
(1, 2, 4), (2, 3, 4), (3, 1, 3), (4, 2, 3), (5, 3, 3) 
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