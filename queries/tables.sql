USE CortexDBWarehouse
GO

SET NOCOUNT ON

SELECT
    t.NAME AS TableName,    
    p.[Rows],
    count(c.name) as Columns,
    (sum(a.total_pages) * 8) / 1024 as TotalSpaceMB
FROM
    sys.tables t
INNER JOIN
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN
    sys.allocation_units a ON p.partition_id = a.container_id
INNER JOIN
    sys.columns c ON c.object_id = t.object_id
WHERE
    t.NAME NOT LIKE 'dt%' AND
    i.OBJECT_ID > 255 AND
    i.index_id <= 1
GROUP BY
    t.NAME, i.object_id, i.index_id, i.name, p.[Rows]
ORDER BY
    p.[Rows]
DESC

GO
