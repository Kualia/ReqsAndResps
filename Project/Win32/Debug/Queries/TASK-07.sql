-- TASK 7
-- Her bir satış temsilcisi için ortalama 
-- satış fiyatını ve toplam satış tutarını gösterin.
 
SELECT soh.SalesPersonID, p.FirstName, p.LastName, AVG(SubTotal) 'Average Sale Price', SUM(SubTotal) 'Total Sale Price' 
FROM Sales.SalesPerson sp
LEFT JOIN Sales.SalesOrderHeader soh ON soh.SalesPersonID = sp.BusinessEntityID
LEFT JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID 
GROUP BY soh.SalesPersonID, p.FirstName, p.LastName
ORDER BY soh.SalesPersonID;
