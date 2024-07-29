-- TASK12
-- Görev 12: En karlı 10 ürünü ve her ürünün kar marjını ve toplam kar tutarını listeleyin.

SELECT TOP 5 p.ProductID, p.Name
    ,count(LineTotal)
    ,SUM(sod.LineTotal * (100-TaxRate)/100 - pch.StandardCost * OrderQty) [TotalProfit]
    ,SUM(sod.LineTotal * (100-TaxRate)/100 - pch.StandardCost * OrderQty) / SUM(LineTotal) * 100 [Margin]
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderDetailID -- Territory -> Stateprovince -> tax 
JOIN Person.StateProvince sp ON sp.TerritoryID = soh.TerritoryID -- Stateprovince -> tax
JOIN Sales.SalesTaxRate str ON str.StateProvinceID = sp.StateProvinceID -- Tax
JOIN Production.Product p ON sod.ProductID = p.ProductID --Product name
LEFT JOIN Production.ProductCostHistory pch ON sod.ProductID = pch.ProductID --Product cost
                                            AND sod.ModifiedDate BETWEEN pch.StartDate and COALESCE(pch.EndDate, GETDATE())
GROUP BY p.ProductID, p.Name
ORDER BY [TotalProfit] DESC, [Margin] DESC
;
