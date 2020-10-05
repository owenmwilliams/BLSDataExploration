import psycopg2
from datetime import datetime
from psycopg2 import sql

# timing start
StartTime = datetime.now()

# connecting to the right database
con = psycopg2.connect(database='postgres', host="localhost", port="5433")
Time1 = datetime.now()-StartTime
print("Database opened successfully: ", Time1)

# setting up a cursor
cur = con.cursor()

# get all column names
cur.execute("SELECT column_name FROM information_schema.columns \
            WHERE table_schema = 'public' \
            AND table_name   = 'fullmaster' \
            ;")
ColumnsArray = cur.fetchall()
print("Array generated: ", datetime.now() - StartTime)

# adjust columns array to determine the columns to pull unique values on
NewColumnsArray = [x[0] for x in ColumnsArray]
NewNewColumnsArray = [x for x in NewColumnsArray if not x.endswith('code',0,20)]

# setup master list to pull all unique values
MasterList = []

# iterable list pull - to iterate through pulling unique filter values from database
for i in range(len(NewNewColumnsArray)):
    Column = NewNewColumnsArray[i]
    query = sql.SQL("SELECT {0} FROM fullmaster GROUP BY {0} ORDER BY {0}")\
        .format(sql.SQL(', ').join([sql.Identifier(Column)]))
    cur.execute(query)
    currentlist = cur.fetchall()
    MasterList.append(Column)
    MasterList.append(currentlist)
    print(Column, "list generated:", datetime.now() - StartTime)
print("MasterList generated: ", datetime.now() - StartTime)

print("\n", len(MasterList), " fields in MasterList", "\n", NewNewColumnsArray)

con.close()
