import psycopg2
from datetime import datetime

# timing start
StartTime = datetime.now()

# connecting to the right database
con = psycopg2.connect(database='blsdata', user="postgres",
            password="CCS1.01!ack", host="localhost", port="5432")
Time1 = datetime.now()-StartTime
print("Database opened successfully: ", Time1)

# setting up a cursor
cur = con.cursor()

# selecting distinct states
cur.execute("SELECT state_name FROM fullmaster \
GROUP BY state_name \
ORDER BY state_name ASC")
StatesArray = cur.fetchall()
Time2 = datetime.now()-Time1-StartTime
print(StatesArray)
print("Array generated: ", Time2, Time2+Time1)

# selecting distinct data types
cur.execute("SELECT data_type_text FROM fullmaster \
GROUP BY data_type_text \
ORDER BY data_type_text ASC")
DataArray = cur.fetchall()
Time3 = datetime.now()-Time2-Time1-StartTime
#print(DataArray)
print("Array generated: ", Time3, Time3+Time2+Time1)

con.close()
