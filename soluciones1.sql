SELECT *
FROM Production.Product
WHERE Weight >= 10 and Weight <=100

SELECT *
FROM Production.Product
WHERE Weight between 10 and 100


SELECT distinct Color
FROM Production.Product
WHERE Style = 'w'

SELECT *
FROM Production.Product
ORDER BY Weight DESC, Color ASC

SELECT *
FROM Production.Product
where Color in ( 'Black', 'Red', 'Blue' )

SELECT Weight
FROM Production.Product
where ProductNumber like 'bk%'

SELECT ProductNumber, name, ListPrice
FROM Production.Product
where ProductLine in ('R', 'M')

SELECT top 5 with ties ListPrice, ProductLine, Style, ProductID, name
FROM Production.Product
where ProductLine = 'S' and Style = 'U'
order by ListPrice desc

SELECT *
FROM Production.Product
where (Class = 'H' and Color = 'Silver')
OR
(Class = 'L' and Color = 'Black')

