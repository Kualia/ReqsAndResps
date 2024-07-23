-- TASK 4
-- En çok satan 10 ürünü ve her ürünün satış
-- sayısını ve toplam satış tutarını listeleyin.

-- FAIL 
SELECT TOP(10) o.ProductID, COUNT(*) 'OrderCount', SUM(o.LineTotal) 'Sum'
FROM Sales.SalesOrderDetail o
GROUP BY (o.ProductID)
ORDER BY OrderCount DESC;
;

-- TASK 4 + names
SELECT p.Name, orders.* FROM 
    (select  o.ProductID, COUNT(*) 'OrderCount', SUM(o.LineTotal) 'Sum'
    from Sales.SalesOrderDetail o
    group by (o.ProductID)
    ) orders
INNER JOIN Production.Product p
ON orders.ProductID = p.ProductID
ORDER BY OrderCount DESC;

-- TASK 4 + Names
--