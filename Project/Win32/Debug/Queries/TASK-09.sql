-- TASK 9
-- Görev 9: Farklı ülkelerden gelen müşterilerin siparişlerinin ortalama tutarını karşılaştırın.

SELECT COALESCE(cr.Name, 'UNKNOWN') 'Country', AVG(sod.TotalDue) 'Average Total Due'
FROM      Sales.SalesOrderHeader sod
LEFT JOIN Sales.Customer c ON sod.CustomerID = c.CustomerID
LEFT JOIN Person.BusinessEntityAddress bea ON bea.BusinessEntityID = c.CustomerID
LEFT JOIN Person.Address a ON bea.AddressID = a.AddressID
LEFT JOIN Person.StateProvince sp ON sp.StateProvinceID = a.StateProvinceID
LEFT JOIN Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY COALESCE(cr.Name, 'UNKNOWN')
ORDER BY 'Average Total Due' DESC
;