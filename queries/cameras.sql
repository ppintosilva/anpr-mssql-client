USE CortexDBWarehouse
SET NOCOUNT ON

SELECT
    c.CameraID as id,
    c.Name as name,
    c.Description as description,
    c.Latitude as latitude,
    c.longitude as longitude,
    c.Commissioned as is_commissioned,
    t.Description as type,
    c.CommissionedDate as operating_since
FROM
    cfg.Cameras as c
INNER JOIN
    static.CameraType as t ON c.CameraTypeID = t.CameraTypeID

GO
