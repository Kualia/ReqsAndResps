-- TASK12
-- Görev 12: En karlı 10 ürünü ve her ürünün kar marjını ve toplam kar tutarını listeleyin.

SELECT TOP 10 sod.ProductID, p.name
    ,SUM(sod.LineTotal - pch.StandardCost * OrderQty) 'TotalProfit'
    ,100 * SUM(sod.LineTotal - pch.StandardCost * OrderQty) / SUM(LineTotal) 'Margin'
FROM Sales.SalesOrderDetail sod
JOIN Production.ProductCostHistory pch ON sod.ProductID = pch.ProductID 
                                    AND sod.ModifiedDate BETWEEN pch.StartDate and COALESCE(pch.EndDate, GETDATE())
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY sod.ProductID, p.Name
ORDER BY 'TotalProfit' DESC, 'Margin' DESC
;
