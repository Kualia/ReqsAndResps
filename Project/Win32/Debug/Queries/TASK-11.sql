-- TASK11
-- Görev 11: En fazla indirim alan 10 müşteriyi ve her müşterinin aldığı toplam indirim tutarını listeleyin.

SELECT TOP 10 soh.CustomerID, p.FirstName, p.LastName, SUM(sod.OrderQty * UnitPrice) 'Total discount'
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderDetailID = soh.SalesOrderID
JOIN Sales.SpecialOffer so ON so.SpecialOfferID = sod.SpecialOfferID
LEFT JOIN Person.Person p ON p.BusinessEntityID = soh.CustomerID
GROUP BY soh.CustomerID, p.FirstName, p.LastName
ORDER BY 'Total discount' DESC