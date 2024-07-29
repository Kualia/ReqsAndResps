-- TASK 1
-- Veritabanında bulunan tüm müşterileri listeleyin ve her 
-- müşterinin sipariş sayısını ve siparişlerin toplam tutarını gösterin.

SELECT top 10 c.CustomerID,
    c.PersonID,
    p.FirstName,
    p.LastName,
    COUNT(o.TotalDue) 'OrderCount', 
    COALESCE(SUM(o.TotalDue), 0) 'Sum'
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader o ON c.CustomerID = o.CustomerID
LEFT JOIN Person.Person p ON p.BusinessEntityID = c.PersonID 
GROUP BY c.CustomerID, c.PersonID, p.FirstName, p.LastName
ORDER BY 'Sum' DESC, c.CustomerID
;