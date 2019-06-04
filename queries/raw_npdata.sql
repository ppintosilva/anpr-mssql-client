USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    d.VRN as vehicle,
    d.CameraID as camera,
    d.Timestamp as timestamp,
    d.VRNConfidence as confidence

FROM
    data.NumberPlateData as d
WHERE
    d.Timestamp >= "{{ start }}" AND d.Timestamp < "{{ end }}"

GO
