import os
from datetime import datetime
import pandas as pd
from azure.storage.blob import BlobServiceClient
import pyodbc

storage_account_name = 'your_storage_account_name'
storage_account_key = 'your_storage_account_key'
container_name = 'your_container_name'

server = 'your_server.database.windows.net'
database = 'your_database'
username = 'your_username'
password = 'your_password'
driver = '{ODBC Driver 17 for SQL Server}'

blob_service_client = BlobServiceClient(
    account_url=f"https://{storage_account_name}.blob.core.windows.net",
    credential=storage_account_key
)
container_client = blob_service_client.get_container_client(container_name)

conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}'
conn = pyodbc.connect(conn_str)

def process_cust_mstr_file(blob_name, file_path):
    df = pd.read_csv(file_path)
    date_str = os.path.basename(blob_name).split('_')[-1].split('.')[0]
    date_formatted = datetime.strptime(date_str, '%Y%m%d').date()
    df['Date'] = date_formatted
    df.to_sql('CUST_MSTR', conn, if_exists='append', index=False)

def process_ecom_order_file(blob_name, file_path):
    df = pd.read_csv(file_path)
    df.to_sql('H_ECOM_Orders', conn, if_exists='append', index=False)

def process_student_marks_file(blob_name, file_path):
    df = pd.read_csv(file_path, sep='-')
    date_str = blob_name.split('-')[-1].strip().split('.')[0]
    date_formatted = datetime.strptime(date_str, '%Y%m%d').date()
    df['Date'] = date_formatted
    df.to_sql('student_marks', conn, if_exists='append', index=False)
    
def process_all_files():
    for blob in container_client.list_blobs():
        blob_name = blob.name
        file_path = os.path.join('/tmp', blob_name)
        
        if blob_name.startswith('CUST_MSTR') and blob_name.endswith('.csv'):
            with open(file_path, 'wb') as f:
                blob_client = container_client.get_blob_client(blob_name)
                f.write(blob_client.download_blob().readall())
            process_cust_mstr_file(blob_name, file_path)
            os.remove(file_path)
        
        elif blob_name == 'ECOM_ORDER.csv':
            with open(file_path, 'wb') as f:
                blob_client = container_client.get_blob_client(blob_name)
                f.write(blob_client.download_blob().readall())
            process_ecom_order_file(blob_name, file_path)
            os.remove(file_path)
        
        elif 'student_marks' in blob_name and blob_name.endswith('.txt'):
            with open(file_path, 'wb') as f:
                blob_client = container_client.get_blob_client(blob_name)
                f.write(blob_client.download_blob().readall())
            process_student_marks_file(blob_name, file_path)
            os.remove(file_path)
        
        else:
    
            print(f"Ignoring file: {blob_name}")

process_all_files()

conn.close()