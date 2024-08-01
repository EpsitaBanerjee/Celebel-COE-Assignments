import random  
import time  
import os  
from azure.eventhub import EventHubProducerClient, EventData  
from pyspark.sql.functions import col, when  
from pyspark.sql import SparkSession  
  
  
EVENT_HUB_CONNECTION_STRING = "Endpoint=sb://.servicebus.windows.net/;SharedAccessKeyName=;SharedAccessKey="  
OUTPUT_EVENT_HUB_CONNECTION_STRING = "Endpoint=sb://.servicebus.windows.net/;SharedAccessKeyName=;SharedAccessKey="  
POWER_BI_WORKSPACE_ID = ""  
POWER_BI_DATASET_ID = ""  
POWER_BI_TABLE_ID = ""  
POWER_BI_API_KEY = ""  
   
producer = EventHubProducerClient.from_connection_string(EVENT_HUB_CONNECTION_STRING, eventhub_name="")  
  

spark = SparkSession.builder.appName("EventHubStream").getOrCreate()  
  
  
event_hub_stream = spark.readStream.format("eventhub") \  
  .option("eventhub.connectionString", EVENT_HUB_CONNECTION_STRING) \  
  .option("eventhub.consumerGroup", "") \  
  .load()  
  
 
event_hub_stream_with_risk = event_hub_stream.withColumn("Risk", when(col("body").cast("int") > 80, "High").otherwise("Low"))  
  

event_hub_stream_with_risk.writeStream.format("eventhub") \  
  .option("eventhub.connectionString", OUTPUT_EVENT_HUB_CONNECTION_STRING) \  
  .option("eventhub.consumerGroup", "") \  
  .option("checkpointLocation", "") \  
  .start()  
  
 
while True:  
   random_number = random.randint(50, 100)  
   event_data = EventData(str(random_number))  
   producer.send_event(event_data)  
   time.sleep(2)  
  

stream_analytics_config = {  
   "inputs": [  
      {  
        "streamName": "EventHubInput",  
        "type": "EventHubStreamInput",  
        "eventHubName": "",  
        "eventHubNamespace": "",  
        "sharedAccessPolicyName": "",  
        "sharedAccessPolicyKey": "",  
        "consumerGroupName": ""  
      }  
   ],  
   "outputs": [  
      {  
        "streamName": "PowerBIOutput",  
        "type": "PowerBIOutput",  
        "powerBIWorkspaceId": POWER_BI_WORKSPACE_ID,  
        "powerBIDatasetId": POWER_BI_DATASET_ID,  
        "powerBITableId": POWER_BI_TABLE_ID,  
        "apiKey": POWER_BI_API_KEY  
      }  
   ],  
   "queries": [  
      {  
        "name": "CountRiskValues",  
        "query": "SELECT Risk, COUNT(*) AS Count FROM EventHubInput GROUP BY Risk"  
      }  
   ]  
}  
# Create a Stream Analytics job  
# (Note: this code is not implemented, as it requires the Azure Stream Analytics SDK)  
# stream_analytics_job =...  
# stream_analytics_job.create(stream_analytics_config)  
  
# Create a real-time dashboard in Power BI  
# (Note: this code is not implemented, as it requires the Power BI SDK)  
# power_bi_dashboard =...  
# power_bi_dashboard.create(stream_analytics_job)