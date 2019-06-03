USE CortexDBWarehouse;
GO

SET NOCOUNT ON

EXEC sp_tables
   @table_name = '%',
   @table_owner = '{{ owner }}',
   @table_qualifier = 'CortexDBWarehouse';
