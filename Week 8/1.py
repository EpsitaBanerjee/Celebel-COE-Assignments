from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, to_date, current_timestamp

spark = SparkSession.builder \
    .appName("NYC Taxi Data Analysis") \
    .getOrCreate()
data_path = "/mnt/data/yellow_tripdata_2020-01.parquet"

taxi_df = spark.read.parquet(data_path)

taxi_df.printSchema()

taxi_df = taxi_df.withColumn("Revenue", col("fare_amount") + col("extra") + col("mta_tax") + col("improvement_surcharge") + col("tip_amount") + col("tolls_amount") + col("total_amount"))

passenger_count_by_area = taxi_df.groupBy("PULocationID") \ .agg(sum("passenger_count").alias("total_passengers")) \.orderBy("total_passengers", ascending=False)


passenger_count_by_area.show()
average_earnings = taxi_df.groupBy("VendorID") \ .agg({"total_amount": "avg"}) \.orderBy("avg(total_amount)", ascending=False) \.limit(2)


average_earnings.show()

payment_mode_count = taxi_df.groupBy("payment_type") \ .count() \ orderBy("count", ascending=False)


payment_mode_count.show()

particular_date = "2020-01-01" 
date_filtered_data = taxi_df.filter(to_date(col("tpep_pickup_datetime")) == particular_date)

vendor_earnings = date_filtered_data.groupBy("VendorID") \ .agg(sum("total_amount").alias("total_earnings"),sum("passenger_count").alias("total_passengers") sum("trip_distance").alias("total_distance")) \.orderBy("total_earnings", ascending=False) \.limit(2)

vendor_earnings.show()

passenger_count_by_route = taxi_df.groupBy("PULocationID", "DOLocationID") \ .agg(sum("passenger_count").alias("total_passengers")) \ orderBy("total_passengers", ascending=False) \ limit(1)

passenger_count_by_route.show()

time_window = 10  
recent_data = taxi_df.filter((current_timestamp() - col("tpep_pickup_datetime")) <= time_window)

top_pickup_locations = recent_data.groupBy("PULocationID") \ .agg(sum("passenger_count").alias("total_passengers")) \ .orderBy("total_passengers", ascending=False)

top_pickup_locations.show()