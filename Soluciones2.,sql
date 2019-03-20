select ((ListPrice - StandardCost) / IIF(ListPrice > 0, ListPrice, 1)) * 100 Porcentaje
from Production.Product
order by Porcentaje desc

SELECT BirthDate, DATEDIFF(YEAR, BirthDate, cast(GETDATE() as date)) Años,
YEAR(GETDATE()) - YEAR(BirthDate) 
- IIF(MONTH(GETDATE()) < MONTH(BirthDate) OR 
	(MONTH(GETDATE()) = MONTH(BirthDate) AND DAY(GETDATE()) <= DAY(BirthDate)), 1, 0)
AS Edad
FROM [HumanResources].[Employee]
WHERE MONTH(BirthDate) = 3 AND DAY(BirthDate) = 21

select UPPER(name) Producto,
cast(ListPrice * case style 
when 'M' then 1.2
when 'W' then 1.1
else 1
end as Money) [Nuevo precio] --, ListPrice 
from Production.Product

select 
REPLACE(
 IIF(ProductLine IS NULL, ' ', LEFT(ProductLine, 1))
+ IIF(Class IS NULL, ' ', LEFT(Class, 1))
+ IIF(Style IS NULL, ' ', LEFT(Style, 1))
+ UPPER(LEFT(Name, 3))
+ IIF(Color IS NULL, ' ', LEFT(Color, 1))
+ FORMAT(ProductID, '000000') 
, ' ', 'X') as Código
from Production.Product
