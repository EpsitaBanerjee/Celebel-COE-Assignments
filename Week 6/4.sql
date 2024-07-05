DECLARE @last_day_of_month DATE = EOMONTH(GETDATE());  
DECLARE @last_saturday_of_month DATE = DATEADD(DAY, -1 * ((DATEPART(WEEKDAY, @last_day_of_month) + 1) % 7), @last_day_of_month);  
  
IF (DATEPART(WEEKDAY, @last_saturday_of_month) = 7)  
    EXEC your_procedure_name;  