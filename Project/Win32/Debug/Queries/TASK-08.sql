-- TASK8
--En fazla satış yapan 5 satış temsilcisini ve her temsilcinin satış sayısını ve toplam satış tutarını listeleyin.

SELECT TOP 5 p.BusinessEntityID, p.FirstName
    , COUNT(soh.SalesOrderID) [Sales Count]
    , SUM(soh.SubTotal) [Total Sales Price]
FROM Sales.SalesOrderHeader soh
LEFT JOIN Person.Person p ON soh.SalesPersonID = p.BusinessEntityID
GROUP BY p.BusinessEntityID, p.FirstName
ORDER BY [Sales Count] desc, [Total Sales Price]
