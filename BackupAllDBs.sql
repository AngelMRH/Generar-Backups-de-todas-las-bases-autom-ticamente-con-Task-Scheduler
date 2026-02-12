DECLARE @name NVARCHAR(128)
DECLARE @path NVARCHAR(256)
DECLARE @fileName NVARCHAR(256)
DECLARE @fileDate NVARCHAR(20)
DECLARE @sql NVARCHAR(MAX)

SET @path = 'C:\RespaldoSQL\'

SELECT @fileDate = CONVERT(VARCHAR(20), GETDATE(), 112)

DECLARE db_cursor CURSOR READ_ONLY FOR  
SELECT name 
FROM sys.databases
WHERE database_id > 4  -- solo bases de usuario
AND state_desc = 'ONLINE'

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    SET @fileName = @path + @name + '_' + @fileDate + '.bak'

    SET @sql = 'BACKUP DATABASE [' + @name + '] 
                TO DISK = ''' + @fileName + ''' 
                WITH INIT, STATS = 10'

    PRINT @sql   -- para ver qué ejecuta
    EXEC(@sql)

    FETCH NEXT FROM db_cursor INTO @name  
END  

CLOSE db_cursor  
DEALLOCATE db_cursor
