-- TASK 15
-- Görev 15: Veritabanındaki tüm Indexlerin Adını, tablosunu ve sütunlarını listeleyin.

SELECT 
    i.name AS IndexName,
    OBJECT_NAME(i.object_id) AS TableName,
    COL_NAME(ic.object_id, ic.column_id) AS ColumnName
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
ORDER BY TableName, IndexName, ic.key_ordinal;

-- SELECT *
-- FROM sys.indexes i
-- INNER JOIN sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id;

-- select top 10 * from  sys.indexes;
-- select top 10 * from  sys.index_columns;

-- SELECT *
-- FROM sys.indexes i
-- INNER JOIN sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id;

-- SELECT *
-- FROM sys.indexes i
-- INNER JOIN sys.index_columns ic on i.object_id = ic.object_id and i.index_id = ic.index_id;

-- select COL_NAME(36, 1)
