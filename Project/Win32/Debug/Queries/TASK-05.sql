-- Task 5 
-- Son 6 (x) ay içinde sipariş vermeyen müşterileri listeleyin.

SELECT c.CustomerID , pp.FirstName, pp.LastName
FROM Sales.Customer c
LEFT JOIN 
    Sales.SalesOrderHeader o ON o.CustomerID = c.CustomerID 
                            AND DATEADD(MONTH, -6, GETDATE()) < OrderDate
LEFT JOIN Person.Person pp ON c.PersonID = pp.BusinessEntityID
WHERE o.CustomerID IS NULL