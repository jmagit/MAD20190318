SELECT  ProductSubcategoryID, Class, Style, count(*) total, 
	GROUPING(ProductSubcategoryID) [T.SC], GROUPING(Class) [T.Class],  
	GROUPING(Style) [T.Style],
	GROUPING_ID(ProductSubcategoryID, Class, Style)
	,
	case GROUPING_ID(ProductSubcategoryID, Class, Style)
	when 7 then 'Total total'
	when 3 then 'Total categoria ' + isnull(str(ProductSubcategoryID), 'X')
	when 1 then 'Total categoria ' + isnull(str(ProductSubcategoryID), 'X') + ' clase ' + isnull(Class, 'nula')
	else 'No es total'
	end
	,
	iif(GROUPING_ID(ProductSubcategoryID, Class, Style) = 0, 0, 1) orden
FROM Production.Product
group by cube(ProductSubcategoryID, Class, Style)
order by ProductSubcategoryID, Class, Style


SELECT 1, ProductID, name as Nombre, Class, Color
FROM Production.Product
where (Class = 'H' and Color = 'Silver')
UNION
SELECT 2, ProductID, name, Class, Color
FROM Production.Product
where (Class = 'L' and Color = 'Black')

SELECT 'Normal' tipo, ProductSubcategoryID, Class, Style, count(*) total 
FROM Production.Product
group by ProductSubcategoryID, Class, Style
UNION
SELECT 'Total', null, 'T', 'T', count(*) total 
FROM Production.Product
UNION
SELECT 'Total cat',  ProductSubcategoryID, null, null, count(*) total 
FROM Production.Product
group by ProductSubcategoryID
UNION
SELECT 'Total estilo',  ProductSubcategoryID, Class, null, count(*) total 
FROM Production.Product
group by ProductSubcategoryID, Class

(
SELECT *
FROM Production.Product
where (Class = 'H' and Color = 'Silver')
UNION
SELECT *
FROM Production.Product
where (Class = 'L' and Color = 'Black')
)
EXCEPT
SELECT *
FROM Production.Product
where SafetyStockLevel = 500


SELECT c.Name cat, /*sc.Name SC,*/ pm.Name Modelo, u.name Unidad, w.Name Peso, p.*, u.*
FROM Production.Product p left join [Production].[UnitMeasure] u
	on p.SizeUnitMeasureCode = u.UnitMeasureCode
	left join [Production].[UnitMeasure] w
	on p.WeightUnitMeasureCode = w.UnitMeasureCode
	left join [Production].[ProductSubcategory] sc 
	on p.ProductSubcategoryID = sc.ProductSubcategoryID
	left join [Production].[ProductCategory] c
	on sc.ProductCategoryID = c.ProductCategoryID
	left join [Production].[ProductModel] pm
	on p.ProductModelID = pm.ProductModelID


SELECT ISNULL(cast([ProductSubcategoryID] as varchar), '(Sin subcategoria)') [Sub categoria], 
	COUNT(IIF(Class = 'L', Class, NULL)) Baja,
	SUM(IIF(Class = 'M', 1, 0)) Media, SUM(IIF(Class = 'H', 1, 0)) Alta,
	COUNT(class) Total
FROM Production.Product
GROUP BY [ProductSubcategoryID]
ORDER BY [ProductSubcategoryID]
go
WITH cte(p, h, m, l) as (
	SELECT * 
	FROM (
		SELECT [ProductSubcategoryID] p, class FROM Production.Product
	) origen PIVOT (
		count(class)
		FOR class
		IN ([H],[M], [L])
	) cruzada
)
SELECT *
FROM cte
UNPIVOT (
	Cuantos
	FOR
	Gama
	IN ([H],[M],[L])
) as T
		     
SELECT ProductSubcategoryID, 
	(SELECT max(Name) 
		from [Production].[ProductSubcategory] sc 
		where ProductSubcategoryID is not null and
			 sc.ProductSubcategoryID = ProductSubcategoryID) Categoria,
	color
FROM Production.Product
where ListPrice > ANY ( select ListPrice FROM [dbo].[GamaAlta])
--where color in (
--	SELECT Color
--	FROM Production.Product
--	where ProductSubcategoryID = 1
--)

		     
