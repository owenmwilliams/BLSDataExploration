import psycopg2
from datetime import datetime
from psycopg2 import sql

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
print("Database opened successfully")

# setting up a cursor
cur = con.cursor()

# selecting all column and table names in the data
cur.execute("""
SELECT table_name, COLUMN_NAME
  FROM information_schema.columns
 WHERE table_name LIKE 'sm_%' 
   AND (data_type='text' OR data_type='character varying');""")
MenuTable = cur.fetchall()
print(MenuTable)
