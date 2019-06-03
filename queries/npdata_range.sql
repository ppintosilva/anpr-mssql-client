USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    min(d.Timestamp) as start_date,
    max(d.Timestamp) as end_date

FROM
    data.NumberPlateData as d

GO
