-- TASK 3
-- Her bir ürün kategorisi için ortalama satış
-- fiyatını ve toplam satış tutarını gösterin.

SELECT c.Name 'Category', 
    SUM(o.LineTotal)/SUM(o.OrderQty) 'Price per item', 
    SUM(o.LineTotal) 'Total' 
FROM Sales.SalesOrderDetail o
INNER JOIN Production.Product p
    ON o.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory sc
    ON sc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory c
    ON sc.ProductCategoryID = c.ProductCategoryID
GROUP BY(c.Name)
order by 'Total' DESC
;
