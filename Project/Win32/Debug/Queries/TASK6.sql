-- TASK 6
-- Stoğu tükenen veya azalan ürünleri listeleyin.

-- SELECT top (1000) inv.TotalQuantity, p.* 
-- FROM Production.Product p 
-- INNER JOIN (SELECT ProductID, SUM(Quantity) 'TotalQuantity' 
--             FROM Production.ProductInventory 
--             GROUP BY ProductID) inv
--         ON inv.TotalQuantity < p.SafetyStockLevel

SELECT pp.ProductID, pp.Name, SUM(Quantity) 'Total Amount', pp.SafetyStockLevel
FROM Production.ProductInventory pi
JOIN Production.Product pp on pi.ProductID = pp.ProductID
GROUP BY pp.ProductID, pp.SafetyStockLevel, pp.Name
HAVING SUM(Quantity) < SafetyStockLevel;
