from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession.builder \
    .appName("Load, Flatten, and Write JSON to Parquet") \
    .getOrCreate()
json_path = "/mnt/data/my_dataset.json" 
df = spark.read.json(json_path)
flattened_df = df.selectExpr(
    "col1",
    "col2",
    "nested_field.field1 AS nested_field_field1",
  
)
parquet_output_path = "/mnt/data/flattened_output.parquet"  
flattened_df.write.mode("overwrite").parquet(parquet_output_path)

table_name = "flattened_table"
spark.sql(f"CREATE TABLE IF NOT EXISTS {table_name} USING PARQUET LOCATION '{parquet_output_path}'")

flattened_df.printSchema()

flattened_df.show(5)
spark.stop()