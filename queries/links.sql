USE CortexDBWarehouse

SET NOCOUNT ON

SELECT
    l.LinkID as id,
    l.Name as name,
    l.Description as description,
    l.RoadDescription as road,
    n1.NodeID as start_node,
    n1.latitude as start_latitude,
    n1.longitude as start_longitude,
    n1.name as start_name,
    n1.description as start_description,
    n2.NodeID as end_node,
    n2.latitude as end_latitude,
    n2.longitude as end_longitude,
    n2.name as end_name,
    n2.description as end_description,
    l.LinkLength as length,
    l.MaximumLinkSpeed as max_speed,
    l.SpeedAtFreeFlow as free_speed,
    l.Commissioned as is_commissioned,
    l.CommissionedDate as operating_since

FROM
    cfg.Links as l
INNER JOIN
    cfg.Nodes as n1 ON l.StartNodeID = n1.NodeID
INNER JOIN
    cfg.Nodes as n2 ON l.EndNodeID = n2.NodeID

GO
