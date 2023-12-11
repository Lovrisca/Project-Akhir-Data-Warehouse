--ETL Query for DimProduct
SELECT P.ProductID, P.Name as ProductName, P.Color, PSC.Name as ProductSubCategory, PC.Name as ProductCategory 
FROM AdventureWorks2022.Production.Product P
LEFT JOIN AdventureWorks2022.Production.ProductSubcategory PSC ON P.ProductID = PSC.ProductSubcategoryID
LEFT JOIN AdventureWorks2022.Production.ProductCategory PC ON P.ProductID = PC.ProductCategoryID;

--ETL Query for DimDate
DECLARE @StartDate DATE = '2011-05-31';
DECLARE @EndDate DATE = '2014-06-30';

WITH DateSequence AS (
    SELECT DISTINCT 
        DATEADD(DAY, DATEDIFF(DAY, @StartDate, OrderDate), @StartDate) AS DateKey,
        DATEPART(YEAR, OrderDate) as Year,
        DATEPART(MONTH, OrderDate) as Month,
        DATEPART(DAY, OrderDate) as Day
    FROM AdventureWorks2022.Sales.SalesOrderHeader
    WHERE OrderDate <= @EndDate
)
SELECT DateKey, Year, Month, Day
FROM DateSequence
WHERE DateKey BETWEEN @StartDate AND @EndDate;

-- ETL Query for DimSalesTerritory
SELECT T.TerritoryID, T.Name AS Region, T.CountryRegionCode AS Country, T.[Group] AS Grup 
FROM AdventureWorks2022.Sales.SalesTerritory T
ORDER BY T.TerritoryID;

--ETL Query for DimCustomer
SELECT C.CustomerID as CustomerID, P.FirstName as FirstName, P.MiddleName as MiddleName, P.LastName as LastName
FROM AdventureWorks2022.Person.Person P
RIGHT JOIN AdventureWorks2022.Sales.Customer C ON C.PersonID = P.BusinessEntityID

--ETL Query for FactSales
SELECT SH.TaxAmt as TaxAmount, SH.Freight as Freight, OD.OrderQty as OrderQuantity, OD.UnitPrice as UnitPrice, D.IDDate as IDDate, 
C.IDCustomer as IDCustomer, ST.IDSalesTerritory as IDSalesTerritory, P.IDProduct as IDProduct, (OD.UnitPrice * OD.OrderQty) as SalesAmount
FROM AdventureWorks2022.Sales.SalesOrderHeader SH
INNER JOIN AdventureWorks2022.Sales.SalesOrderDetail OD ON OD.SalesOrderID = SH.SalesOrderID
INNER JOIN ETL_DW.dbo.DimDate D ON SH.OrderDate = D.DateKey
INNER JOIN ETL_DW.dbo.DimCustomer C ON SH.CustomerID = C.CustomerID
INNER JOIN ETL_DW.dbo.DimSalesTerritory ST ON SH.TerritoryID = ST.TerritoryID
INNER JOIN ETL_DW.dbo.DimProduct P ON OD.ProductID = P.ProductID