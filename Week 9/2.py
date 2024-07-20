import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import os
from azure.storage.filedatalake import DataLakeServiceClient
from pyspark.sql import SparkSession


start_date = datetime(2018, 1, 1)
end_date = datetime(2020, 10, 23)


current_date = start_date
local_path = "/path/to/data"

while current_date <= end_date:

    df = pd.DataFrame({
        "Date": [current_date.strftime("%Y-%m-%d")],
        "Value": [np.random.random()]
    })
    

    filename = f"TSK_{current_date.strftime('%Y%m%d')}.parquet"
    folder = current_date.strftime('%Y%m')
    full_path = os.path.join(local_path, folder)
    
    
    os.makedirs(full_path, exist_ok=True)
    

    df.to_parquet(os.path.join(full_path, filename))

    current_date += timedelta(days=1)



def upload_to_adls(account_name, account_key, local_path, file_system_name):
    service_client = DataLakeServiceClient(account_url=f"https://{account_name}.dfs.core.windows.net", credential=account_key)
    file_system_client = service_client.get_file_system_client(file_system_name)
    
    for root, dirs, files in os.walk(local_path):
        for name in files:
            file_path = os.path.join(root, name)
            relative_path = os.path.relpath(file_path, local_path)
            file_client = file_system_client.get_file_client(relative_path)
            
            with open(file_path, "rb") as data:
                file_client.upload_data(data, overwrite=True)


upload_to_adls('<account_name>', '<account_key>', '/path/to/data', '<file_system_name>')


def read_parquet_files(spark, start_date, end_date, adls_path):
    start = datetime.strptime(start_date, "%Y-%m-%d")
    end = datetime.strptime(end_date, "%Y-%m-%d")
    
    current = start
    dfs = []
    
    while current <= end:
        folder = current.strftime("%Y%m")
        file = f"TSK_{current.strftime('%Y%m%d')}.parquet"
        path = f"{adls_path}/{folder}/{file}"
        try:
            df = spark.read.parquet(path)
            dfs.append(df)
        except Exception as e:
            print(f"File not found: {path}, Exception: {e}")
        current += timedelta(days=1)
    
    if dfs:
        return dfs[0].unionAll(dfs[1:])
    else:
        return spark.createDataFrame([], schema=[])

spark = SparkSession.builder.appName("ReadParquets").getOrCreate()
adls_path = "abfss://<file_system_name>@<account_name>.dfs.core.windows.net/data"
start_date = "2019-01-01"
end_date = "2019-01-31"
result_df = read_parquet_files(spark, start_date, end_date, adls_path)
result_df.show()