-- TASK8
--En fazla satış yapan 5 satış temsilcisini ve her temsilcinin satış sayısını ve toplam satış tutarını listeleyin.

SELECT  qh.BusinessEntityID, COUNT(qh.SalesQuota) 'Total Count', SUM(qh.SalesQuota) 'Total Quota'
FROM Sales.SalesPersonQuotaHistory qh
GROUP BY qh.BusinessEntityID
;

-- ++ Names
SELECT top 5 qh.BusinessEntityID, p.FirstName, COUNT(qh.SalesQuota) 'Total Count', SUM(qh.SalesQuota) 'Total Quota'
FROM Sales.SalesPersonQuotaHistory qh
LEFT JOIN Person.Person p ON qh.BusinessEntityID = p.BusinessEntityID
GROUP BY qh.BusinessEntityID, p.FirstName
order by [Total Count] desc, [Total Quota] desc
;