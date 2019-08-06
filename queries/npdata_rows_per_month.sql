USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    count(d.Timestamp) as observations,
    CAST(MONTH(d.Timestamp) AS VARCHAR(2)) + '/' + CAST(YEAR(d.Timestamp) AS VARCHAR(4))

FROM
    data.NumberPlateData as d

GROUP BY
    CAST(MONTH(d.Timestamp) AS VARCHAR(2)) + '/' + CAST(YEAR(d.Timestamp) AS VARCHAR(4))

GO
