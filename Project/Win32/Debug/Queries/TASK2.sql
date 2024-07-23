-- TASK 2
-- En çok sipariş veren 10 müşteriyi ve her müşterinin 
-- sipariş sayısını ve siparişlerin toplam tutarını listeleyin.

SELECT TOP(10) o.CustomerID, COUNT(*) 'OrderCount', SUM(o.TotalDue) 'Sum'
FROM Sales.SalesOrderHeader o
GROUP BY o.CustomerID
ORDER BY 'OrderCount' desc, 'Sum'
;

-- TASK 2 + names
SELECT TOP(10) o.CustomerID, p.FirstName, p.LastName, COUNT(*) 'OrderCount', SUM(o.TotalDue) 'Sum'
FROM Sales.SalesOrderHeader o
LEFT JOIN Person.Person p on p.BusinessEntityID = o.CustomerID
GROUP BY o.CustomerID, p.FirstName, p.LastName
ORDER BY 'OrderCount' desc, 'Sum'
;