-- step :1 Log in to your Azure Databricks workspace.
-- step :2 Click on the "New notebook" button to create a new notebook.
-- step :3 In the new notebook, click on the "SQL" tab.
-- step :4 Paste the below code into the SQL editor.
CREATE TRIGGER trg_dim
ON CustomerDim
AFTER INSERT
AS
BEGIN
    DECLARE @currentDate DATE = GETDATE();
    UPDATE CustomerDim
    SET EffectiveEndDate = DATEADD(DAY, -1, @currentDate),
        IsCurrent = 0
    FROM CustomerDim CD
    INNER JOIN inserted I ON CD.CustomerID = I.CustomerID
    WHERE CD.IsCurrent = 1
      AND (CD.CustomerName <> I.CustomerName OR CD.Address <> I.Address)
      AND CD.EffectiveEndDate = '9999-12-31';

    INSERT INTO CustomerDim (CustomerID, CustomerName, Address, EffectiveStartDate, EffectiveEndDate, IsCurrent)
    SELECT I.CustomerID, I.CustomerName, I.Address, @currentDate, '9999-12-31', 1
    FROM inserted I;
END;

GO
-- Test the trigger with sample inserts
INSERT INTO CustomerDim (CustomerID, CustomerName, Address)
VALUES 
(1, 'John Doe', 'Ajmer'),
(4, 'David Richard', 'Mumbai'),
(3, 'Bob Smith', 'Chennai'),
(5, 'Eva Dsouza', 'Mumbai');
-- step :5 Click on the "Run" button to run the code.
-- step :6 The trigger will be created and will start executing automatically whenever a new record is inserted into the CustomerDim table.