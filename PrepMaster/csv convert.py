import csv

csvfile = open('XXX.txt', "r")
in_txt = csv.reader(csvfile, delimiter='\t', quotechar='"')

out_csv = csv.writer(open('YYY.csv', 'w+'))
out_csv.writerows(in_txt)
