USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    count(d.Timestamp) as observations,
    CAST(MONTH(d.Timestamp) AS VARCHAR(2)) + '-' + CAST(YEAR(d.Timestamp) AS VARCHAR(4)) AS sdate

FROM
    data.NumberPlateData as d

GROUP BY
    sdate

GO
