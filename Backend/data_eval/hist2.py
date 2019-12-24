import matplotlib.pyplot as plt
import numpy as np
import sys
import mysql.connector
from mysql.connector import Error


bin_num = []
weight = []
lat = []
long = []
hist_data = []
time = []
date = []
time_analysis = np.zeros(13)

def main():
    conn = None

    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='grievance_data',
                                       user='root',
                                       password='password')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM grievances")
        rows = cursor.fetchall()
        for row in rows:
            bin_num.append(row[1])
            weight.append(row[3])
            lat.append(float(row[6]))
            long.append(float(row[7]))
            date.append(int(row[4]))
            time.append(row[5])

        print(time)
        i = 0
        start = sys.argv[1]
        end = sys.argv[2]
        for x in time:
            if(start <= x and end >= x):
                time_analysis[int(time[i][0:2])-9] += weight[i]
            i+=1

        print(start)
        plt.bar(range(13),time_analysis)
        plt.savefig('./data_eval/hist2.png')

    except Error as e:
        print(rows)
    finally:
        cursor.close()
        conn.close()

if __name__=="__main__":
    main()
