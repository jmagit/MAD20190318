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
