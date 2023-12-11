--Displays total income data in all US regions in July 2011
SELECT ROW_NUMBER() OVER(ORDER BY SUM(FS.SalesAmount) DESC) AS Number,
D.Year, D.Month, ST.Country, ST.Region, SUM(FS.SalesAmount) AS TotalIncome 
FROM ETL_DW.dbo.FactSales FS
JOIN ETL_DW.dbo.DimDate D ON D.IDDate = FS.IDDate
JOIN ETL_DW.dbo.DimProduct P ON P.IDProduct = FS.IDProduct
JOIN ETL_DW.dbo.DimCustomer C ON C.IDCustomer = FS.IDCustomer
JOIN ETL_DW.dbo.DimSalesTerritory ST ON ST.IDSalesTerritory = FS.IDSalesTerritory
WHERE D.Year = 2011
AND D.Month = 7
AND ST.Country = 'US'
GROUP BY D.Year, D.Month, ST.Country, ST.Region
ORDER BY Number, ST.Country, TotalIncome DESC;

--Displays total income for each month of 2012 in the Germany region sorted by highest income
SELECT ROW_NUMBER() OVER (ORDER BY SUM(FS.SalesAmount) DESC) AS Ranking,
D.Year, D.Month, ST.Region, SUM(FS.SalesAmount) AS TotalIncome 
FROM ETL_DW.dbo.FactSales FS
JOIN ETL_DW.dbo.DimDate D ON D.IDDate = FS.IDDate
JOIN ETL_DW.dbo.DimCustomer C ON C.IDCustomer = FS.IDCustomer
JOIN ETL_DW.dbo.DimSalesTerritory ST ON ST.IDSalesTerritory = FS.IDSalesTerritory
WHERE ST.Region = 'Germany'
AND D.Year = 2012
GROUP BY D.Year, D.Month, ST.Region
ORDER BY Ranking, TotalIncome DESC;

--Displays data on the number of sales for each product in the Northwest region in May 2013
SELECT RANK() OVER (ORDER BY SUM(FS.OrderQuantity) DESC) AS ranking,
D.Month, D.Year, ST.Region, P.ProductName, SUM(FS.OrderQuantity) AS TotalOrderQuantity
FROM ETL_DW.dbo.FactSales FS
JOIN ETL_DW.dbo.DimDate D ON D.IDDate = FS.IDDate
JOIN ETL_DW.dbo.DimProduct P ON P.IDProduct = FS.IDProduct
JOIN ETL_DW.dbo.DimCustomer C ON C.IDCustomer = FS.IDCustomer
JOIN ETL_DW.dbo.DimSalesTerritory ST ON ST.IDSalesTerritory = FS.IDSalesTerritory
WHERE ST.Region = 'Northwest'
AND D.Year = 2013
AND D.Month = 5
GROUP BY D.Month, D.Year, ST.Region, P.ProductName
ORDER BY TotalOrderQuantity DESC;