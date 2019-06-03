USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    d.VRN as vehicle,
    d.CameraID as camera,
    d.Timestamp as timestamp,
    d.VRNConfidence as confidence,
    d.TimestampError as timestamp_error,
    d.PlateNotRead as was_read,
    dir.Description as direction

FROM
    data.NumberPlateData as d
INNER JOIN
    static.VehicleDirectionType as dir ON d.VehicleDirectionID = dir.VehicleDirectionTypeID
WHERE
    d.Timestamp >= "{{ start }}" AND d.Timestamp < "{{ end }}"

GO
