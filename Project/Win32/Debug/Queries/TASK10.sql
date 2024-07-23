-- TASK 10
-- Görev 10: Her bir sipariş yöntemi için ortalama sipariş tutarını ve sipariş sayısını gösterin.

SELECT soh.ShipMethodID, sm.Name
    ,SUM(sod.LineTotal) / COUNT(soh.SalesOrderID) 'Average Order Cost'
    ,COUNT(soh.SalesOrderID) 'Order Count' 
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
JOIN Purchasing.ShipMethod sm ON sm.ShipMethodID = soh.ShipMethodID 
GROUP BY soh.ShipMethodID, sm.Name;