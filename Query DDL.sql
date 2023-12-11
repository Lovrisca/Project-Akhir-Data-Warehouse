--create DimProduct Table
CREATE TABLE DimProduct(
    IDProduct int IDENTITY(1,1) PRIMARY KEY,
    ProductID int,
    ProductName nvarchar(255),
    Color nvarchar(255),
    ProductSubCategory nvarchar(255),
    ProductCategory nvarchar(255)
);

--create DimDate Table
CREATE TABLE DimDate(
    IDDate int IDENTITY(1,1) PRIMARY KEY,
	DateKey Date,
    Year int,
    Month int,
    Day int
);

--create DimSalesTerritory Table
CREATE TABLE DimSalesTerritory(
	IDSalesTerritory int IDENTITY(1,1) PRIMARY KEY,
	TerritoryID int,
	Region nvarchar(255),
	Country nvarchar(255),
	Grup nvarchar(255)
);

--create DimCustomer Table
CREATE TABLE DimCustomer(
    IDCustomer int IDENTITY(1,1) PRIMARY KEY,
    CustomerID int,
    FirstName nvarchar(255),
	MiddleName nvarchar(255),
	LastName nvarchar(255)
);

--create FactSales Table
CREATE TABLE FactSales (
	IDSalesTerritory int, --
	IDCustomer int, --
	IDProduct int,
	IDDate int, --

	FOREIGN KEY(IDSalesTerritory) REFERENCES DimSalesTerritory(IDSalesTerritory),
	FOREIGN KEY(IDCustomer) REFERENCES DimCustomer(IDCustomer),
	FOREIGN KEY(IDProduct) REFERENCES DimProduct(IDProduct),
	FOREIGN KEY(IDDate) REFERENCES DimDate(IDDate),

	OrderQuantity smallint, --SalesOrderDetail
	UnitPrice money, --SalesOrderDetail
	SalesAmount money,
	TaxAmount money, --SalesOrderHeader
	Freight money --SalesOrderHeader
);