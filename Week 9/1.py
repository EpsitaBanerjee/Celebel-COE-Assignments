from pyspark.sql import SparkSession
from pyspark.sql.functions import row_number, col, first, when
from pyspark.sql.window import Window

spark = SparkSession.builder.appName("CustomerDeduplication").getOrCreate()
customer_df = spark.read.csv("/path/to/customer_data.csv", header=True, inferSchema=True)
window_spec = Window.partitionBy("Name", "Address").orderBy("CustomerID")
customer_df = customer_df.withColumn("row_num", row_number().over(window_spec))


customer_df = customer_df.withColumn("MasterID", when(col("row_num") == 1, col("CustomerID")))

window_spec_ff = Window.partitionBy("Name", "Address").orderBy("CustomerID").rowsBetween(Window.unboundedPreceding, Window.currentRow)
customer_df = customer_df.withColumn("MasterID", first("MasterID", ignorenulls=True).over(window_spec_ff))

customer_df = customer_df.drop("row_num")
jdbc_url = "jdbc:sqlserver://<server_name>:<port>;databaseName=<database_name>"
table_name = "<table_name>"
user = "<username>"
password = "<password>"
customer_df.write \
    .format("jdbc") \
    .option("url", jdbc_url) \
    .option("dbtable", table_name) \
    .option("user", user) \
    .option("password", password) \
    .mode("overwrite") \
    .save()

print("Data written back to Azure SQL successfully.")