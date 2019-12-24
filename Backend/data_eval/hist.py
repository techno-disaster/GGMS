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
day_analysis = np.zeros(13)
month_analysis = np.zeros(31)
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
        print(len(rows))
        for row in rows:
            bin_num.append(row[1])
            weight.append(row[3])
            lat.append(float(row[6]))
            long.append(float(row[7]))
            date.append(int(row[4]))
            time.append(int(row[5][0:1]))

        i = 0
        key = int(sys.argv[1])
        for x in date:
            if(key == 32):
                month_analysis[date[i]] += weight[i]
            elif(x == key):
                day_analysis[time[i]-9] += weight[i]
            i+=1


        if(key == 32):
            plt.bar(range(31),month_analysis)
        else:
            plt.bar(range(13),day_analysis)
        print('atsatststx')
        plt.savefig('./data_eval/hist.png')

    except Error as e:
        print(rows)
    finally:
        cursor.close()
        conn.close()

if __name__=="__main__":
    main()
