USE [master]
GO
/****** Object:  Database [PixlePromoters]    Script Date: 1/10/2024 4:32:06 PM ******/
CREATE DATABASE [PixlePromoters]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PixlePromoters', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PixlePromoters.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PixlePromoters_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PixlePromoters_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PixlePromoters] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PixlePromoters].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PixlePromoters] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PixlePromoters] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PixlePromoters] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PixlePromoters] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PixlePromoters] SET ARITHABORT OFF 
GO
ALTER DATABASE [PixlePromoters] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PixlePromoters] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PixlePromoters] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PixlePromoters] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PixlePromoters] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PixlePromoters] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PixlePromoters] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PixlePromoters] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PixlePromoters] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PixlePromoters] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PixlePromoters] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PixlePromoters] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PixlePromoters] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PixlePromoters] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PixlePromoters] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PixlePromoters] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PixlePromoters] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PixlePromoters] SET RECOVERY FULL 
GO
ALTER DATABASE [PixlePromoters] SET  MULTI_USER 
GO
ALTER DATABASE [PixlePromoters] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PixlePromoters] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PixlePromoters] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PixlePromoters] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PixlePromoters] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PixlePromoters] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PixlePromoters', N'ON'
GO
ALTER DATABASE [PixlePromoters] SET QUERY_STORE = ON
GO
ALTER DATABASE [PixlePromoters] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PixlePromoters]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFullName]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--This is a simple FUNCTION to grab the "FullName" of an employee.
CREATE FUNCTION [dbo].[GetFullName](@EmployeeID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FullName NVARCHAR(100);
    SELECT @FullName = Name FROM Employee WHERE EmployeeID = @EmployeeID;
    RETURN @FullName;
END;
GO
/****** Object:  Table [dbo].[Campaign]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaign](
	[CampaignID] [int] NOT NULL,
	[ClientID] [int] NULL,
	[CampaignStartDate] [date] NULL,
	[CampaignEndDate] [date] NULL,
	[Budget] [money] NULL,
	[Objective] [nvarchar](550) NULL,
PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[DemoView]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[DemoView] AS
SELECT 
    'INSERT INTO VALUES example' AS InsertIntoValuesDemo,
    'INSERT INTO SELECT example' AS InsertIntoSelectDemo,
    'SELECT INTO example' AS SelectIntoDemo
FROM 
    (SELECT TOP 1 * FROM Campaign) AS SampleData;
GO
/****** Object:  View [dbo].[PictureThePixel]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PictureThePixel] AS
SELECT 
    'INSERT INTO VALUES example' AS InsertIntoValuesDemo,
    'INSERT INTO SELECT example' AS InsertIntoSelectDemo,
    'SELECT INTO example' AS SelectIntoDemo
FROM 
    (SELECT TOP 1 * FROM Campaign) AS SampleData;
GO
/****** Object:  Table [dbo].[Client]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientID] [int] NOT NULL,
	[CompanyName] [nvarchar](50) NULL,
	[ContactInfo] [nvarchar](50) NULL,
	[ContractStartDate] [datetime2](7) NULL,
	[ContractEndDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] NOT NULL,
	[DepartmentName] [nvarchar](50) NULL,
	[ManagerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[DepartmentID] [int] NULL,
	[JobRole] [nvarchar](50) NULL,
	[Salary] [money] NULL,
	[HireDate] [date] NULL,
	[Employed] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialMedia]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialMedia](
	[PlatformID] [int] NOT NULL,
	[PlatformName] [nvarchar](50) NULL,
	[Characteristics] [nvarchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[PlatformID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Campaign]  WITH NOCHECK ADD  CONSTRAINT [FK_Campaign_Client] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Client] ([ClientID])
GO
ALTER TABLE [dbo].[Campaign] CHECK CONSTRAINT [FK_Campaign_Client]
GO
ALTER TABLE [dbo].[Department]  WITH NOCHECK ADD  CONSTRAINT [FK_Department_Manager] FOREIGN KEY([ManagerID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Manager]
GO
ALTER TABLE [dbo].[Employee]  WITH NOCHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Employee]  WITH NOCHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCampaign]    Script Date: 1/10/2024 4:32:07 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Sometimes I get an error that "this needs to go first", but I believe this needs to follow the creation of tables. It works, sometimes!
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
        RAISERROR ('ClientID doesn''t exist', 13, 1);
        RETURN;
    END

    INSERT INTO Campaign (CampaignID, ClientID, CampaignStartDate, CampaignEndDate, Budget, Objective)
    VALUES (@CampaignID, @ClientID, @CampaignStartDate, @CampaignEndDate, @Budget, @Objective);
END;
GO
USE [master]
GO
ALTER DATABASE [PixlePromoters] SET  READ_WRITE 
GO
