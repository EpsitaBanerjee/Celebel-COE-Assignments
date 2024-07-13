import json
azure_bom = {
    "Azure SQL Database": {
        "description": "Used for storing structured data from Oracle.",
        "monthly_incremental_data_size_gb": 30,
        "total_table_count": 20,
        "service_tier": "Standard",
        "compute_size": "S3",
        "storage_size_gb": 200 
    },
    "Azure Data Factory": {
        "description": "Used for ETL processes for Oracle and Salesforce data.",
        "service_tier": "Standard",
        "data_movement": {
            "monthly_incremental_data_size_gb": 30 + 50,
            "integration_runtime_hours": 100  
        }
    },
    "Salesforce Connector": {
        "description": "Used for connecting and ingesting data from Salesforce.",
        "monthly_incremental_data_size_gb": 50,
        "total_table_count": 120
    },
    "Azure Blob Storage": {
        "description": "Used for storing semi-structured files from FTP.",
        "monthly_data_size_gb": 5,
        "approximate_file_count_per_month": 20,
        "storage_tier": "Hot"
    },
    "Azure Synapse Analytics": {
        "description": "Used for data warehousing and analysis.",
        "monthly_incremental_data_size_gb": 30 + 50 + 5,
        "compute_size": "DW100c",
        "storage_size_gb": 500  
    }
}

detailed_description = """
Azure Bill of Materials (BoM):

1. **Azure SQL Database**
    - Description: Used for storing structured data from Oracle.
    - Monthly Incremental Data Size: 30 GB
    - Total Table Count: 20
    - Service Tier: Standard
    - Compute Size: S3
    - Storage Size: 200 GB

2. **Azure Data Factory**
    - Description: Used for ETL processes for Oracle and Salesforce data.
    - Service Tier: Standard
    - Data Movement: 
        - Monthly Incremental Data Size: 80 GB
        - Integration Runtime Hours: 100 hours

3. **Salesforce Connector**
    - Description: Used for connecting and ingesting data from Salesforce.
    - Monthly Incremental Data Size: 50 GB
    - Total Table Count: 120

4. **Azure Blob Storage**
    - Description: Used for storing semi-structured files from FTP.
    - Monthly Data Size: 5 GB
    - Approximate File Count Per Month: 20
    - Storage Tier: Hot

5. **Azure Synapse Analytics**
    - Description: Used for data warehousing and analysis.
    - Monthly Incremental Data Size: 85 GB
    - Compute Size: DW100c
    - Storage Size: 500 GB
"""

print(json.dumps(azure_bom, indent=4))

print(detailed_description)

with open('/mnt/data/azure_bom.json', 'w') as f:
    json.dump(azure_bom, f, indent=4)

with open('/mnt/data/azure_bom_description.txt', 'w') as f:
    f.write(detailed_description)
