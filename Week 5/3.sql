DECLARE @source_database NVARCHAR(50) = 'ource_database_name'
DECLARE @target_database NVARCHAR(50) = 'target_database_name'

-- Create a table to store the table names
DECLARE @tables TABLE (table_name NVARCHAR(50))
INSERT INTO @tables
SELECT name
FROM sys.tables
WHERE database_id = DB_ID(@source_database)

DECLARE @table_name NVARCHAR(50)
DECLARE @sql NVARCHAR(4000)


DECLARE cur CURSOR FOR
SELECT table_name
FROM @tables

OPEN cur

FETCH NEXT FROM cur INTO @table_name

WHILE @@FETCH_STATUS = 0
BEGIN
    
    SET @sql = 'IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = ''' + @table_name + ''' AND database_id = DB_ID(''' + @target_database + '''))
                BEGIN
                    SELECT * INTO ' @target_database + '.dbo.' + @table_name + 'ROM ' @source_database + '.dbo.' + @table_name + '
                END
                ELSE
                BEGIN
                    TRUNCATE TABLE ' @target_database + '.dbo.' + @table_name + '
                    INSERT INTO ' @target_database + '.dbo.' + @table_name + 'ELECT * FROM ' @source_database + '.dbo.' + @table_name + '
                END'

  
    EXEC sp_executesql @sql

    FETCH NEXT FROM cur INTO @table_name
END

CLOSE cur
DEALLOCATE cur
