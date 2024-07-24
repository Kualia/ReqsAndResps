-- TASK 15
-- Görev 15: Veritabanındaki tüm Indexlerin Adını, tablosunu ve sütunlarını listeleyin.

SELECT 
    i.name AS IndexName,
    OBJECT_NAME(i.object_id) AS TableName,
    COL_NAME(ic.object_id, ic.column_id) AS ColumnName
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
ORDER BY TableName, IndexName, ic.key_ordinal;