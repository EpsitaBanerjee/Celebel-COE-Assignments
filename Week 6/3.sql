 CREATE TABLE [dbo].[incremental_load_log] (  
    [last_run_time] datetime  
);  
  
CREATE PROCEDURE [dbo].[usp_incremental_load]  
AS  
BEGIN  
    DECLARE @lastRunTime datetime = (SELECT TOP 1 [last_run_time] FROM [dbo].[incremental_load_log] ORDER BY [last_run_time] DESC);  
    DECLARE @currentTime datetime = GETDATE();  
  
    SELECT *   
    INTO #temp   
    FROM [dbo].[source_table]   
    WHERE [modified_date] &gt; @lastRunTime AND [modified_date] &lt;= @currentTime;  
  
    INSERT INTO [dbo].[target_table] ([column1], [column2],...)  
    SELECT [column1], [column2],...   
    FROM #temp;  
    
    INSERT INTO [dbo].[incremental_load_log] ([last_run_time])   
    VALUES (GETDATE());  
END;  
   
EXEC sp_addjob @job_name = 'Incremental Load Job';  
EXEC sp_addjobstep @job_name = 'Incremental Load Job', @step_name = 'Run Stored Procedure',   
    @subsystem = 'TSQL',   
    @command = 'EXEC [dbo].[usp_incremental_load]';  
EXEC sp_addjobschedule @job_name = 'Incremental Load Job', @schedule_name = 'Daily Schedule',   
    @freq_type = 4, @freq_interval = 1, @active_start_time = '2023-02-20 02:00:00';  
