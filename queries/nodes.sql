USE CortexDBWarehouse
SET NOCOUNT ON

SELECT
    n.NodeID as id,
    n.Name as name,
    n.Description as description,
    n.Latitude as latitude,
    n.Longitude as longitude,
    t.Name as type_name,
    t.Description as type
    
FROM
    cfg.Nodes as n
INNER JOIN
    static.NodesDirectionType as t ON n.NodesDirectionTypeId = t.NodesDirectionTypeId

GO
