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


