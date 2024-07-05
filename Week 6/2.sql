-- Step 1: Set Up an FTP/SFTP Server
-- Manual step: Install and configure FTP/SFTP server software

-- Step 2: Note down the FTP/SFTP Server Settings
-- Manual step: Note server details like IP, port, username, password, and folder path

-- Step 3: Create a Self-Hosted Integration Runtime (SHIR)
CREATE INTEGRATION RUNTIME
    Name = 'YourSHIRName',
    Type = 'Self-Hosted';

-- Install the SHIR on the local or virtual machine hosting the FTP/SFTP server

-- Step 4: Create a Linked Service for the FTP/SFTP Server
CREATE LINKED SERVICE
    Name = 'FTPSftpLinkedService',
    Type = 'FTP', -- or 'SFTP'
    ConnectionDetails = {
        ServerName = 'YourServerNameOrIP',
        PortNumber = 21, -- or 22 for SFTP
        Username = 'YourUsername',
        Password = 'YourPassword',
        FolderPath = 'Your/Folder/Path'
    };

-- Step 5: Create a Dataset for the FTP/SFTP Files
CREATE DATASET
    Name = 'FtpSftpDataset',
    Type = 'File',
    LinkedServiceName = 'FTPSftpLinkedService',
    FilePath = 'Your/Folder/Path',
    FileFormat = 'CSV'; -- or 'JSON', 'Parquet', etc.

-- Step 6: Create a Pipeline
CREATE PIPELINE
    Name = 'DataExtractionPipeline';

ADD ACTIVITY TO PIPELINE
    PipelineName = 'DataExtractionPipeline',
    ActivityName = 'CopyDataActivity',
    ActivityType = 'Copy Data',
    SourceDataset = 'FtpSftpDataset',
    SinkDataset = 'DestinationDataset'; -- Define your destination dataset as needed

-- Step 7: Configure the Copy Data Activity
CONFIGURE COPY DATA ACTIVITY
    ActivityName = 'CopyDataActivity',
    Source = 'FtpSftpDataset',
    Sink = 'DestinationDataset',
    Mapping = {
        SourceColumns = [Column1, Column2, Column3],
        SinkColumns = [Column1, Column2, Column3]
    };

-- Step 8: Schedule the Pipeline
CREATE TRIGGER
    TriggerName = 'DailyTrigger',
    PipelineName = 'DataExtractionPipeline',
    Frequency = 'Daily',
    StartTime = '2023-06-01T00:00:00Z';

-- Step 9: Monitor and Troubleshoot
-- Use the ADF portal to monitor and troubleshoot pipeline runs
MONITOR PIPELINE
    PipelineName = 'DataExtractionPipeline';
