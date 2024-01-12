IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'PixlePromoters')
BEGIN
    CREATE DATABASE PixlePromoters;
END
GO

USE PixlePromoters;
GO
--Create database and set your context. If you need to reference the database around multiple others, sometimes <USE [Pixel Promoters]> works better for this.

--If you run this a second time, the BULK INSERT later gave me trouble, so better to erase the data from the table and reinsert
ALTER TABLE Department DROP CONSTRAINT FK_Department_Manager;
ALTER TABLE Employee DROP CONSTRAINT FK_Employee_Department;
ALTER TABLE Campaign DROP CONSTRAINT FK_Campaign_Client;

DELETE FROM Employee
DELETE FROM Department
DELETE FROM Campaign
DELETE FROM Client
DELETE FROM SocialMedia

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Client]') AND type in (N'U'))
BEGIN
	CREATE TABLE Client (
		ClientID INT PRIMARY Key,
		CompanyName NVARCHAR(50),
		ContactInfo NVARCHAR(50),
		ContractStartDate DATETIME2 (7),
		ContractEndDate DATETIME2 (7)
	);
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Campaign]') AND type in (N'U'))
BEGIN
	CREATE TABLE Campaign (
		CampaignID INT PRIMARY KEY,
		ClientID INT,
		CampaignStartDate DATE,
		CampaignEndDate DATE,
		Budget MONEY,
		Objective NVARCHAR(550)
	);
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
BEGIN
	CREATE TABLE Employee (
		EmployeeID INT PRIMARY KEY,
		Name NVARCHAR(50),
		DepartmentID INT NULL,
		JobRole NVARCHAR(50),
		Salary MONEY,
		HireDate DATE,
		Employed BIT
--BIT is a boolean in this language
		FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
	);
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Department]') AND type in (N'U'))
BEGIN
	CREATE TABLE Department (
		DepartmentID INT PRIMARY KEY,
		DepartmentName NVARCHAR(50),
		ManagerID INT NULL
	);
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SocialMedia]') AND type in (N'U'))
BEGIN
    CREATE TABLE SocialMedia (
        PlatformID INT PRIMARY KEY,
        PlatformName NVARCHAR (50),
        Characteristics NVARCHAR (1) NULL
    );
END
GO

--FOREIGN KEYS
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID);
GO

ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_Department
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);
GO

ALTER TABLE Campaign
ADD CONSTRAINT FK_Campaign_Client
FOREIGN KEY (ClientID)
REFERENCES Client (ClientID);
GO

--I kept getting errors and consulted with a friend to understand "dynamic SQL". I can't create a procedure/function inside an "IF" block, so we're using EXEC.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddNewCampaign]') AND type in (N'P'))
BEGIN
    EXEC sp_executesql N'
        CREATE PROCEDURE [dbo].[AddNewCampaign]
            @CampaignID INT,
            @ClientID INT,
            @CampaignStartDate DATE,
            @CampaignEndDate DATE,
            @Budget MONEY,
            @Objective NVARCHAR(550)
        AS
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM Client WHERE ClientID = @ClientID)
            BEGIN
                RAISERROR (''ClientID doesn''''t exist'', 13, 1);
                RETURN;
            END
            INSERT INTO Campaign (CampaignID, ClientID, CampaignStartDate, CampaignEndDate, Budget, Objective)
            VALUES (@CampaignID, @ClientID, @CampaignStartDate, @CampaignEndDate, @Budget, @Objective);
        END'
END;
GO

--This is a simple FUNCTION to grab the "FullName" of an employee.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFullName]') AND type in (N'FN'))
BEGIN
    EXEC sp_executesql N'
        CREATE FUNCTION [dbo].[GetFullName](@EmployeeID INT)
        RETURNS NVARCHAR(100)
        AS
        BEGIN
            DECLARE @FullName NVARCHAR(100);
            SELECT @FullName = Name FROM Employee WHERE EmployeeID = @EmployeeID;
            RETURN @FullName;
        END'
END;
GO

--The TABLE work is done above, and VIEW/SELECT/INSERT is attempted below.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PictureThePixel]') AND type in (N'V'))
BEGIN
    EXEC sp_executesql N'
        CREATE VIEW [dbo].[PictureThePixel] AS
        SELECT 
            ''INSERT INTO VALUES example'' AS InsertIntoValues,
            ''INSERT INTO SELECT example'' AS InsertIntoSelect,
            ''SELECT INTO example'' AS SelectInto
        FROM 
            (SELECT TOP 1 * FROM Campaign) AS TrialData'
END;
GO

--This adds a new client with INSERT
INSERT INTO Client (ClientID, CompanyName, ContactInfo, ContractStartDate, ContractEndDate)
VALUES (1, 'FarceBook', 'JaneDoe@newclient.com', '2023-01-01', '2023-12-31');
GO

--Now that all my structures are in place, I want to give it the actual data with BULK INSERT, just to see if I could do it.
--This wasn't working at all until I found some Hex nonsense about 0x0a versus \r\n or anything similar. ascittable.com tells me the A represents the same LF / new line issue you can find on VS Code.
--This actually seems it won't work; I've made it a little too complicated in my diagram having some key values. Line 160, 171, 182, and 193 are getting constant "Cannot obtain the required interface
--BULK INSERT Campaign
--FROM 'C:\tmp\Campaign.csv'
--WITH (
--	FORMAT = 'CSV',
--	DATAFILETYPE = 'char',
--    FIELDTERMINATOR = ',',
--    ROWTERMINATOR = '0x0a',
--    FIRSTROW = 2 
--);
--GO

--BULK INSERT Client
--FROM 'C:\tmp\Client.csv'
--WITH (
--	FORMAT = 'CSV',
--	FIRSTROW = 2,
--	DATAFILETYPE = 'char',
--    FIELDTERMINATOR = ',',
--    ROWTERMINATOR = '0x0a'
--);
--GO

--BULK INSERT Department
--FROM 'C:\tmp\Department.csv'
--WITH (
--	FORMAT = 'CSV',
--	FIRSTROW = 2,
--	DATAFILETYPE = 'char',
--    FIELDTERMINATOR = ',',
--    ROWTERMINATOR = '0x0a'
--);
--GO

--BULK INSERT Employee
--FROM 'C:\tmp\Employee.csv'
--WITH (
--	FORMAT = 'CSV',
--	FIRSTROW = 2,
--	DATAFILETYPE = 'char',
--    FIELDTERMINATOR = ',',
--    ROWTERMINATOR = '0x0a'
--);
--GO

--BULK INSERT SocialMedia
--FROM 'C:\tmp\SocialMedia.csv'
--WITH (
--	FORMAT = 'CSV',
--	FIRSTROW = 2,
--	DATAFILETYPE = 'char',
--    FIELDTERMINATOR = ',',
--    ROWTERMINATOR = '0x0a'
--);
--GO

--Our 13th Campaign just won the lottery, hurray. This UPDATEs their budget. 
UPDATE Campaign
SET Budget = 20000
WHERE CampaignID = 13;
GO
--Unlucky #13 Elane Knutsen made a horrible editing mistake! She gets the last laugh after she DELETEd her data from the system. Now there's a big ol' lawsuit.
DELETE FROM Employee
WHERE EmployeeID = 1;
GO

--This SELECTs from the previous "PictureThePixel" compilation VIEW. Leaving at the end because it seems to be easier accessed and changed that way.
SELECT * FROM PictureThePixel;