-- Task 5 
-- Son 6 (x) ay içinde sipariş vermeyen müşterileri listeleyin.

SELECT c.CustomerID , pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN 
    (SELECT * FROM Sales.SalesOrderHeader WHERE DATEDIFF(MONTH, OrderDate, GETDATE()) < 144) o
    ON o.CustomerID = c.CustomerID
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
WHERE o.CustomerID IS NULl

-- v2++
SELECT c.CustomerID , pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN 
    Sales.SalesOrderHeader o ON o.CustomerID = c.CustomerID 
                            AND DATEADD(MONTH, -144, GETDATE()) < OrderDate
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
WHERE o.CustomerID IS NULl

-- v3
SELECT c.CustomerID, pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID 
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
GROUP BY c.CustomerID, pp.FirstName, pp.LastName
HAVING MAX(COALESCE(soh.DueDate, 0)) < DATEADD(MONTH, -144, getdate()) and pp.FirstName is NULL




select * from
(
SELECT c.CustomerID , pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN 
    Sales.SalesOrderHeader o ON o.CustomerID = c.CustomerID 
                            AND DATEADD(MONTH, -144, GETDATE()) < OrderDate
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
WHERE o.CustomerID IS NULl
) ab 
EXCEPT
(
SELECT c.CustomerID, pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID 
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
GROUP BY c.CustomerID, pp.FirstName, pp.LastName
HAVING MAX(COALESCE(soh.DueDate, 0)) < DATEADD(MONTH, -144, getdate())
)

select DATEDIFF(month, soh.OrderDate, GETDATE()), * from sales.SalesOrderHeader soh where CustomerID IN
(25363,25371,25393,25864,25875,25883,25892,26316,27027,27043,28512,28519,28529,28540,28547,28798,28818,28832,28834,28836,28837,28848,29013,29135,29763,29883);



-- Task 5.2
DECLARE @last_x_month2 INT;
SET @last_x_month2 = 144;

SELECT * FROM
((SELECT distinct CustomerID FROM Sales.Customer)
EXCEPT
(SELECT distinct CustomerID FROM Sales.SalesOrderHeader WHERE DATEDIFF(MONTH, OrderDate, GETDATE()) < @last_x_month2) 
) sub_table
JOIN Sales.Customer c ON c.CustomerID = sub_table.CustomerID;


