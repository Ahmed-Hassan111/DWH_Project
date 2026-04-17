-- Database creation
CREATE DATABASE GravityBooks_DW


-- Dims creation

-- Dim_Date  Role Playing Dimension

-- calender
CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,  -- ????: 20250101
    FullDate DATE NOT NULL,
    Day INT NOT NULL,
    Month INT NOT NULL,
    Year INT NOT NULL,
    Quarter INT NOT NULL,
    MonthName NVARCHAR(60),
    DayOfWeek NVARCHAR(60),
    DayOfWeekNumber INT,
    IsWeekend BIT,
    FiscalQuarter NVARCHAR(10)
);

-- int instead of date becuase this faster in queries
-- : YYYYMMDD == 20240115 == 15 jan 2024

-- Dim_Customer  SCD Type 2 track address of customers

CREATE TABLE Dim_Customer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,  -- ????? ????
    CustomerID INT NOT NULL,                     -- ??????? ?? ??? OLTP
    FirstName NVARCHAR(150),
    LastName NVARCHAR(150),
    Email NVARCHAR(350),
    Street NVARCHAR(350),
    City NVARCHAR(150),
    Country NVARCHAR(150),
    StartDate DATE NOT NULL,                     -- ????? ????? ?????
    EndDate DATE,                                -- ????? ????? ????? (NULL ?? ??? ???)
    IsActive BIT DEFAULT 1,                      -- ?? ????? ????
    CurrentFlag BIT DEFAULT 1                    -- ?? ?? ???? ?????
);

-- Dim_Book 

-- ???? ????? - ????? ??? ?????? ??????? ??????? ??????
CREATE TABLE Dim_Book (
    BookKey INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    ISBN13 NVARCHAR(60),
    NumPages INT,
    PublicationDate DATE,
    Language NVARCHAR(150),
    AuthorName NVARCHAR(350),
    PublisherName NVARCHAR(350),
    Category NVARCHAR(150)  -- ???? ?????? ??????

);


-- Dim_Location  Outrigger Dimension (Country ????? ?? Location)

-- ???? ??????? ?????????
CREATE TABLE Dim_Location (
    LocationKey INT IDENTITY(1,1) PRIMARY KEY,
    AddressID INT,
    Street NVARCHAR(350),
    City NVARCHAR(150),
    Country NVARCHAR(150),
    CountryID INT,
    PostalCode NVARCHAR(60)
);

-- Dim_Shipping

CREATE TABLE Dim_Shipping (
    ShippingKey INT IDENTITY(1,1) PRIMARY KEY,
    ShippingMethodID INT NOT NULL,
    MethodName NVARCHAR(150) NOT NULL,
    Cost DECIMAL(10,2)
);


-- Dim_Order_Status 

CREATE TABLE Dim_OrderStatus (
    StatusKey INT IDENTITY(1,1) PRIMARY KEY,
    StatusID INT NOT NULL,
    StatusValue NVARCHAR(150) NOT NULL,
    Description NVARCHAR(200)
);





-----------------
-- ???? ??????? - Transactional Fact
CREATE TABLE Fact_Sales (
    SalesKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    
    -- Foreign Keys ???????
    DateKey INT NOT NULL,              -- ????? ?????
    OrderDateKey INT NOT NULL,         -- Role Playing: ????? ?????
    ShipDateKey INT,                   -- Role Playing: ????? ?????
    CustomerKey INT NOT NULL,
    BookKey INT NOT NULL,
    LocationKey INT ,
    ShippingKey INT,
    StatusKey INT,
   
    
    -- Degenerate Dimensions (????? ?????? ?? ??? Fact)
    OrderID INT NOT NULL,
    OrderLineNumber INT,
    
    -- Measures (Additive Facts)
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,  -- Derived: Quantity * UnitPrice
    ShippingCost DECIMAL(10,2),
    
    -- Non-Additive Fact
    DiscountPercent DECIMAL(5,2) DEFAULT 0,
    
    -- Constraints
    CONSTRAINT FK_Fact_Sales_Date FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
    CONSTRAINT FK_Fact_Sales_OrderDate FOREIGN KEY (OrderDateKey) REFERENCES Dim_Date(DateKey),
    CONSTRAINT FK_Fact_Sales_ShipDate FOREIGN KEY (ShipDateKey) REFERENCES Dim_Date(DateKey),
    CONSTRAINT FK_Fact_Sales_Customer FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey),
    CONSTRAINT FK_Fact_Sales_Book FOREIGN KEY (BookKey) REFERENCES Dim_Book(BookKey),
    CONSTRAINT FK_Fact_Sales_Location FOREIGN KEY (LocationKey) REFERENCES Dim_Location(LocationKey),
    CONSTRAINT FK_Fact_Sales_Shipping FOREIGN KEY (ShippingKey) REFERENCES Dim_Shipping(ShippingKey),
    CONSTRAINT FK_Fact_Sales_Status FOREIGN KEY (StatusKey) REFERENCES Dim_OrderStatus(StatusKey)
);
GO

-- ????? Indexes ?????? ??????
CREATE INDEX IX_Fact_Sales_DateKey ON Fact_Sales(DateKey);
CREATE INDEX IX_Fact_Sales_CustomerKey ON Fact_Sales(CustomerKey);
CREATE INDEX IX_Fact_Sales_BookKey ON Fact_Sales(BookKey);
CREATE INDEX IX_Fact_Sales_OrderID ON Fact_Sales(OrderID);
GO