/*
    Kevin Carrier 9/24/2020
    Miles Technologies Bootcamp - Homework 1
*/



/*
    Drop Tables
*/

DROP TABLE IF EXISTS [Received];
DROP TABLE IF EXISTS [Inventory];
DROP TABLE IF EXISTS [Supplies];
DROP TABLE IF EXISTS [Sales];
DROP TABLE IF EXISTS [Services];
DROP TABLE IF EXISTS [Statuses];
DROP TABLE IF EXISTS [BasementRats];
DROP TABLE IF EXISTS [Taverns];
DROP TABLE IF EXISTS [Locations];
DROP TABLE IF EXISTS [Users];
DROP TABLE IF EXISTS [Roles];

/*
    Create Tables
*/


CREATE TABLE [Roles](
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RoleName varchar(50) NOT NULL,
	RoleDescription varchar(max)
);

CREATE TABLE [Users](
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name varchar(50) NOT NULL,
	RoleID int NOT NULL REFERENCES Roles (ID)
);

CREATE TABLE [Locations](
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name varchar(100) NOT NULL
);

CREATE TABLE [Taverns](
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TavernName varchar(250) NOT NULL,
	LocationID int NOT NULL REFERENCES Locations (ID),
	OwnerID int NOT NULL REFERENCES Users (ID),
	NumberOfFloors int
);

CREATE TABLE [BasementRats](
	ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name varchar(100) NOT NULL,
	TavernID int NOT NULL REFERENCES Taverns (ID)
);

CREATE TABLE [Supplies](
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Unit varchar(100)
);

CREATE TABLE [Inventory](
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SupplyID int NOT NULL REFERENCES Supplies (ID),
    TavernID int NOT NULL REFERENCES Taverns (ID),
    CurrentCount int NOT NULL,
    LastUpdated datetime NOT NULL
);

CREATE TABLE [Received](
    ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SupplyID int NOT NULL REFERENCES Supplies (ID),
    TavernID int NOT NULL REFERENCES Taverns (ID),
    Cost decimal(18,2) NOT NULL,
    AmountReceived decimal(18,2) NOT NULL,
    DateReceived datetime NOT NULL
);

CREATE TABLE [Statuses](
    ID int NOT NULL PRIMARY KEY,
    Status varchar(100) NOT NULL
);

CREATE TABLE [Services](
    ID int NOT NULL PRIMARY KEY,
    Name varchar(100) NOT NULL,
    StatusID int NOT NULL REFERENCES Statuses (ID),
    TavernID int NOT NULL REFERENCES Taverns (ID)
);

CREATE TABLE [Sales](
    ID int NOT NULL PRIMARY KEY,
    ServiceID int NOT NULL REFERENCES Services (ID),
    GuestID int NOT NULL REFERENCES Users (ID),
    Price decimal(18,2) NOT NULL,
    DatePurchased datetime NOT NULL,
    AmountPurchased decimal(18,2) NOT NULL,
    TavernID int NOT NULL REFERENCES Taverns (ID)
);

/*
    Seed Database With Dummy Data
*/

INSERT INTO Roles
(ID, RoleName, RoleDescription)
VALUES
(1, 'Owner', 'Owner of the tavern');

INSERT INTO Roles
(ID, RoleName, RoleDescription)
VALUES
(2, 'Employee', 'Employee of the tavern');

INSERT INTO Roles
(ID, RoleName, RoleDescription)
VALUES
(3, 'Customer', 'Customer of the tavern');

INSERT INTO Roles
(ID, RoleName, RoleDescription)
VALUES
(4, 'Customer', null);

INSERT INTO Roles
(ID, RoleName, RoleDescription)
VALUES
(5, 'Customer', null);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(1, 'Kevin Carrier', 1);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(2, 'Kevin Carrier', 1);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(3, 'Kevin Carrier', 3);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(4, 'Crystal Vu', 1);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(5, 'David Kirkman', 2);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(6, 'John Graham', 1);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(7, 'Chris Camac', 1);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(8, 'Victoria Tamburro', 2);

INSERT INTO Users
(ID, Name, RoleID)
VALUES
(9, 'John Doe', 3);

INSERT INTO Locations
(ID, Name)
VALUES
(1, '200 Country Club Pkwy, Mt Laurel Township, NJ 08054');

INSERT INTO Locations
(ID, Name)
VALUES
(2, '123 Tavern Ave, Camden, NJ 12345');

INSERT INTO Locations
(ID, Name)
VALUES
(3, '1442 Marlton Pike East, Cherry Hill, NJ 08034');

INSERT INTO Locations
(ID, Name)
VALUES
(4, '2 S Centre St, Merchantville, NJ 08109');

INSERT INTO Locations
(ID, Name)
VALUES
(5, '123 Tavern Ave, Camden, NJ 12345');

INSERT INTO Locations
(ID, Name)
VALUES
(6, '123 Tavern Ave, Camden, NJ 12345');

INSERT INTO Locations
(ID, Name)
VALUES
(7, '');

INSERT INTO Locations
(ID, Name)
VALUES
(8, '');

INSERT INTO Taverns
(ID, TavernName, LocationID, OwnerID, NumberOfFloors)
VALUES
(1, 'Seven Tap Tavern', 1, 1, 4);

INSERT INTO Taverns
(ID, TavernName, LocationID, OwnerID, NumberOfFloors)
VALUES
(2, 'The Farm and Fisherman Tavern', 3, 4, 2);

INSERT INTO Taverns
(ID, TavernName, LocationID, OwnerID, NumberOfFloors)
VALUES
(3, 'Blue Monkey Tavern', 4, 7, 1);

INSERT INTO Taverns
(ID, TavernName, LocationID, OwnerID, NumberOfFloors)
VALUES
(4, 'Hidden Tavern', 6, 6, 1);

INSERT INTO Taverns
(ID, TavernName, LocationID, OwnerID, NumberOfFloors)
VALUES
(5, 'Hidden Tavern', 6, 6, 1);

INSERT INTO BasementRats
(ID, Name, TavernID)
VALUES
(1, 'James', 3);

INSERT INTO BasementRats
(ID, Name, TavernID)
VALUES
(2, 'James', 3);

INSERT INTO BasementRats
(ID, Name, TavernID)
VALUES
(3, 'Ashley', 2);

INSERT INTO BasementRats
(ID, Name, TavernID)
VALUES
(4, 'Eddie', 2);

INSERT INTO BasementRats
(ID, Name, TavernID)
VALUES
(5, 'Jerry', 1);

INSERT INTO Statuses
(ID, Status)
VALUES
(1, 'Active');

INSERT INTO Statuses
(ID, Status)
VALUES
(2, 'Inactive');

INSERT INTO Statuses
(ID, Status)
VALUES
(3, 'Out of Stock');

INSERT INTO Statuses
(ID, Status)
VALUES
(4, 'Discontinued');

INSERT INTO Statuses
(ID, Status)
VALUES
(5, 'Out of Stock');

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(1, 'Lime Juice', 'Ounce');

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(2, 'Dogfish 90 Minute IPA', 'IPA');

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(3, 'Ale Ale Ale', 'Strong Ale');

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(4, 'Ale Ale Ale', 'Strong Ale');

INSERT INTO Supplies
(ID, Name, Unit)
VALUES
(5, 'Orange Juice', 'Ounce');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(1, 2, 1, 300, '2020-09-22');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(2, 3, 1, 250, '2020-09-22');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(3, 2, 3, 1000, '2020-09-20');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(4, 1, 2, 15, '2020-09-19');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(5, 1, 2, 15, '2020-09-19');

INSERT INTO Inventory
(ID, SupplyID, TavernID, CurrentCount, LastUpdated)
VALUES
(6, 5, 2, 30, '2020-09-20');

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(1, 2, 1, 7.50, 10.00, '2020-09-20');

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(2, 2, 1, 7.50, 10.00, '2020-09-20');

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(3, 2, 1, 7.50, 7.50, '2020-09-21');

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(4, 3, 1, 6.00, 6.00, '2020-09-22');

INSERT INTO Received
(ID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
(5, 3, 3, 4.00, 5.00, '2020-09-22');

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(1, 'Pool', 1, 1);

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(2, 'Weapon Sharpening', 1, 1);

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(3, 'Pool', 2, 3);

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(4, 'Pool', 2, 3);

INSERT INTO Services
(ID, Name, StatusID, TavernID)
VALUES
(5, 'Pool', 1, 4);

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(1, 1, 3, 15.00, '2020-09-09', 20.00, 4);

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(2, 1, 3, 10.00, '2020-09-12', 10.00, 5);

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(3, 2, 9, 15.00, '2020-08-28', 20.00, 4);

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(4, 1, 9, 15.00, '2020-09-09', 15.00, 1);

INSERT INTO Sales
(ID, ServiceID, GuestID, Price, DatePurchased, AmountPurchased, TavernID)
VALUES
(5, 1, 9, 15.00, '2020-09-09', 15.00, 1);
