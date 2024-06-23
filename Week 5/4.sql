DECLARE @source_database NVARCHAR(50) = 'ource_database_name'
DECLARE @target_database NVARCHAR(50) = 'target_database_name'


DECLARE @tables TABLE (table_name NVARCHAR(50), column_names NVARCHAR(4000))


INSERT INTO @tables
VALUES
    ('table1', 'column1, column2, column3'),
    ('table2', 'columnA, columnB'),
    ('table3', 'columnX, columnY, columnZ')

DECLARE @table_name NVARCHAR(50)
DECLARE @column_names NVARCHAR(4000)
DECLARE @sql NVARCHAR(4000)


DECLARE cur CURSOR FOR
SELECT table_name, column_names
FROM @tables

OPEN cur

FETCH NEXT FROM cur INTO @table_name, @column_names

WHILE @@FETCH_STATUS = 0
BEGIN
    
    SET @sql = 'IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = ''' + @table_name + ''' AND database_id = DB_ID(''' + @target_database + '''))
                BEGIN
                    CREATE TABLE ' @target_database + '.dbo.' + @table_name + '' + @column_names + ')
                END'

    
    EXEC sp_executesql @sql

    SET @sql = 'INSERT INTO ' @target_database + '.dbo.' + @table_name + '' + @column_names + ')
                SELECT ' @column_names + 'ROM ' @source_database + '.dbo.' + @table_name

   
    EXEC sp_executesql @sql

    FETCH NEXT FROM cur INTO @table_name, @column_names
END

CLOSE cur
DEALLOCATE cur
