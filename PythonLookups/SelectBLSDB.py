import psycopg2

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
print("Database opened successfully")

# setting up a cursor
cur = con.cursor()



# selecting distinct data
cur.execute("SELECT period, data_type_text, value FROM fullmaster \
WHERE year='2010' AND seasonalcode='S' AND state_name='Alabama' AND area_name='Statewide' AND industry_name='Total Nonfarm'\
ORDER BY period ASC")
rows = cur.fetchall()

print(rows)

con.close()
