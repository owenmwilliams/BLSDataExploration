import psycopg2

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
print("Database opened successfully")

# setting up a cursor
cur = con.cursor()

# current table state
cur.execute("SELECT * FROM testtable ORDER BY series_id ASC")
print(cur.fetchall())

cur.execute("DELETE FROM testtable WHERE series_id=1026")
con.commit()

con.close()
