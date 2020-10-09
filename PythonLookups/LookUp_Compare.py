import psycopg2
from datetime import datetime
from psycopg2 import sql

# timing start
StartTime = datetime.now()

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
print("Database opened successfully")

# setting up a cursor
cur = con.cursor()
Time1 = datetime.now()-StartTime
print(Time1)

# selecting from a joined table
cur.execute("""SELECT "year", "value", sscc.state_name, sdtcc.data_type_text 
FROM sm_alldata_csv sac 
JOIN sm_state_code_csv sscc ON SUBSTRING(sac.series_id, 4, 2) = sscc."﻿state_code" 
JOIN sm_data_type_code_csv sdtcc ON SUBSTRING(sac.series_id, 19, 2) = sdtcc."﻿data_type_code" 
WHERE SUBSTRING(sac.series_id, 4, 2) = '31' AND SUBSTRING(sac.series_id, 19, 2) = '11'
ORDER BY sac."value";""")
JoinLookupArray = cur.fetchall()
print(JoinLookupArray)
Time2 = datetime.now()-Time1-StartTime
print("Array generated: ", Time2)

# selecting from a master table
cur.execute("""SELECT "year", value, state_name, data_type_text 
FROM fullmaster f 
WHERE statecode = '31' AND datacode = '11'
ORDER BY value;""")
MasterLookupArray = cur.fetchall()
print(MasterLookupArray)
Time3 = datetime.now()-Time2-Time1-StartTime
print("Array generated: ", Time3)
