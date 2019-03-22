SELECT avg([TotalDue]) [Precio Medio]
FROM [Sales].[SalesOrderHeader]

SELECT DATEPART(YEAR, [DueDate]) Año, DATEPART(Q, [DueDate]) Trimestrales, 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos],
	MAX([TotalDue]) Máximo,
	MIN([TotalDue]) Mínimo
FROM [Sales].[SalesOrderHeader]
WHERE Status not in (4, 6)
GROUP BY DATEPART(YEAR, [DueDate]), DATEPART(Q, [DueDate])
ORDER BY DATEPART(YEAR, [DueDate]), DATEPART(Q, [DueDate])

SELECT DATEPART(YEAR, [DueDate]) Año, DATEPART(MONTH, [DueDate]) Mes, 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
GROUP BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])
HAVING count(*) > 1000
ORDER BY DATEPART(YEAR, [DueDate]), DATEPART(MONTH, [DueDate])

SELECT [SalesPersonID], 
	sum([TotalDue]) [Total Ventas],
	count(*) [Número Pedidos]
FROM [Sales].[SalesOrderHeader]
WHERE [SalesPersonID] IS NOT NULL
GROUP BY [SalesPersonID]
ORDER BY sum([TotalDue]) DESC, [SalesPersonID]

SELECT ISNULL(cast([ProductSubcategoryID] as varchar), '(Sin subcategoria)') [Sub categoria], COUNT(IIF(Class = 'L', Class, NULL)) Baja,
	SUM(IIF(Class = 'M', 1, 0)) Media, SUM(IIF(Class = 'H', 1, 0)) Alta,
	COUNT(class) Total
FROM Production.Product
GROUP BY [ProductSubcategoryID]
ORDER BY [ProductSubcategoryID]

						   
SELECT  Name, [ListPrice], 
	[ListPrice] - avg(ListPrice) over(partition by [ProductSubcategoryID]) [Delta precio],
	[ListPrice] - max(ListPrice) over(partition by [ProductSubcategoryID]) [Delta máximo],
	[ListPrice] - min(ListPrice) over(partition by [ProductSubcategoryID]) [Delta mínimo]
FROM Production.Product
SELECT  ProductSubcategoryID,Name, [ListPrice], 
	rank() over(order by ListPrice desc) [Ranking de precios],
	rank() over(partition by [ProductSubcategoryID] order by ListPrice desc) [Ranking de precios por categoria]
FROM Production.Product
SELECT  Name, [ListPrice],
	case NTILE(3) over (order by [ListPrice] desc)
	when 1 then 'Caro'
	when 2 then 'Normal'
	else 'Barato'
	end Tipo
	,
	case 
	when ListPrice = 0  then 'Regalao'
	when ListPrice > 1000  then 'Caro'
	when ListPrice between 100 and 1000 then 'Normal'
	else 'Barato'
	end 
FROM Production.Product
							

SELECT        Ped.SalesPersonID, Ven.FirstName + ' ' + Ven.LastName Vendedor, COUNT(*) AS [Número Pedidos], SUM(Ped.TotalDue) AS [Total Ventas]
FROM            Sales.SalesOrderHeader AS Ped INNER JOIN
                         Sales.SalesPerson AS SP ON Ped.SalesPersonID = SP.BusinessEntityID INNER JOIN
                         HumanResources.Employee AS E ON SP.BusinessEntityID = E.BusinessEntityID INNER JOIN
                         Person.Person AS Ven ON E.BusinessEntityID = Ven.BusinessEntityID AND E.BusinessEntityID = Ven.BusinessEntityID
GROUP BY Ped.SalesPersonID, Ven.FirstName, Ven.LastName
ORDER BY Ven.FirstName, Ven.LastName

SELECT        Ped.SalesOrderID, Ped.RevisionNumber, Ped.OrderDate, Ped.DueDate, Ped.ShipDate, Ped.Status, Ped.OnlineOrderFlag, Ped.SalesOrderNumber, Ped.PurchaseOrderNumber, Ped.AccountNumber, 
                         Cliente.FirstName + ' ' + Cliente.LastName AS Cliente, Ped.SalesPersonID, Sales.SalesTerritory.Name AS Zona, Ped.BillToAddressID, Ped.ShipToAddressID, Ped.ShipMethodID, Ped.CreditCardID, Ped.CreditCardApprovalCode, 
                         Ped.CurrencyRateID, Ped.SubTotal, Ped.TaxAmt, Ped.Freight, Ped.TotalDue, Ped.Comment, Ped.rowguid, Ped.ModifiedDate
FROM            Sales.SalesTerritory RIGHT OUTER JOIN
                         Sales.SalesOrderHeader AS Ped ON Sales.SalesTerritory.TerritoryID = Ped.TerritoryID AND Sales.SalesTerritory.TerritoryID = Ped.TerritoryID LEFT OUTER JOIN
                         Person.Person AS Vendedor ON Ped.SalesPersonID = Vendedor.BusinessEntityID LEFT OUTER JOIN
                         Person.Person AS Cliente ON Ped.CustomerID = Cliente.BusinessEntityID

SELECT        P.SalesOrderID, SUM(LP.LineTotal) AS [Total lineas], P.SubTotal
FROM            Sales.SalesOrderHeader AS P INNER JOIN
                         Sales.SalesOrderDetail AS LP ON P.SalesOrderID = LP.SalesOrderID
GROUP BY P.SalesOrderID, P.SubTotal
HAVING        (P.SubTotal <> SUM(LP.LineTotal))
