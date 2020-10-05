import psycopg2

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
print("Database opened successfully")

# setting up a cursor
cur = con.cursor()

# drop the table from previous tests
cur.execute("DROP TABLE IF EXISTS testtable")
con.commit()
print("Table dropped successfully")

# create a new table
cur.execute('''CREATE TABLE testtable
    (series_id     INT     PRIMARY KEY     NOT NULL,
     Month         TEXT    NOT NULL,
     Year          TEXT    NOT NULL,
     Value         NUMERIC NOT NULL);''')
con.commit()
print("Table created successfully")

# insert data into the new table
cur.execute("INSERT INTO testtable \
(series_id, Month, Year, Value) \
VALUES (1023, '03', '2009', 9.8)");
cur.execute("INSERT INTO testtable \
(series_id, Month, Year, Value) \
VALUES (1024, '11', '2009', 4.5)");
cur.execute("INSERT INTO testtable \
(series_id, Month, Year, Value) \
VALUES (1025, '02', '2010', 11.1)");
cur.execute("INSERT INTO testtable \
(series_id, Month, Year, Value) \
VALUES (1026, '12', '2011', 0.6)");
cur.execute("INSERT INTO testtable \
(series_id, Month, Year, Value) \
VALUES (1027, '08', '1999', 3.9)");
con.commit()
print("Record(s) inserted successfully", "\n")

# retrieving all the records from the table
cur.execute("SELECT series_id, Month, Year, Value FROM testtable")
rows = cur.fetchall()

for row in rows:
    print("series_id =", row[0])
    print("Month =", row[1])
    print("Year =", row[2])
    print("Value =", row[3], "\n")

print("Data retrieved successfully")

# updating a single row
cur.execute("UPDATE testtable SET Month='07' WHERE series_id=1023")
con.commit()
print("Total updated rows:", cur.rowcount, "\n")

cur.execute("SELECT series_id, Month, Year, Value FROM testtable ORDER BY series_id ASC")
rows = cur.fetchall()

for row in rows:
    print("series_id =", row[0])
    print("Month =", row[1])
    print("Year =", row[2])
    print("Value =", row[3], "\n")

print("Data updated successfully")

# deleting a single row
cur.execute("DELETE FROM testtable WHERE series_id=1026")
con.commit()
print("Total deleted rows:", cur.rowcount, "\n")

cur.execute("SELECT series_id, Month, Year, Value FROM testtable ORDER BY series_id ASC")
rows = cur.fetchall()

for row in rows:
    print("series_id =", row[0])
    print("Month =", row[1])
    print("Year =", row[2])
    print("Value =", row[3], "\n")

print("Data deleted successfully", "\n")

cur.execute("SELECT * FROM testtable ORDER BY series_id ASC")
print(cur.fetchall())

con.close()
