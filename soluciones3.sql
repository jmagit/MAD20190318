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
							
