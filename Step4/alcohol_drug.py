
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

import mysql.connector
from mysql.connector import errorcode

def connectionCreator():
    try:
        cnx = mysql.connector.connect(user="root",password="cs306course",database="cs306")
        print("Connection established with the database")
        return cnx
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exist")
        else:
            print(err)
        return None
    else:
        cnx.close()
        return None


mydb = connectionCreator()


country1 = input("Please enter the first country to display: ")
country2 = input("Please enter the second country to display: ")


query1 = "SELECT C.countryName,A1.year, A1.alcoholrate, A1.drugrate, S.rate AS suicide_rate FROM alcoholanddrugdisorder A1 INNER JOIN countries C ON C.isoCode = A1.CountryIsoCode INNER Join suicide S ON S.IsoCode = A1.CountryIsoCode AND S.year = A1.year  WHERE C.countryName = \"{}\" OR C.countryName = \"{}\";".format(country1,country2)

table1 = pd.read_sql(query1,mydb)

mydb.close()

#print(table1)


fig, ax1 = plt.subplots(2,figsize=(8, 10))
fig.tight_layout(pad=5.0)


fig.suptitle("Comparison of {} and {}".format(country1.capitalize(),country2.capitalize()),fontweight='bold')

sns.barplot(data=table1, x="year", y="alcoholrate",ax=ax1[0],hue="countryName")
sns.barplot(data=table1, x="year", y="drugrate",ax=ax1[1],hue="countryName")
ax1[0].set_xticklabels(ax1[0].get_xticklabels(), rotation=45,horizontalalignment='right')
ax1[1].set_xticklabels(ax1[1].get_xticklabels(), rotation=45,horizontalalignment='right')

ax1[0].set_title("Alcohol Usage vs Suicide")
ax1[1].set_title("Drug Usage vs Suicide")

ax2_1 = ax1[0].twinx()
ax2_2 = ax1[1].twinx()


sns.stripplot(data=table1,x="year",y="suicide_rate",ax=ax2_1,hue="countryName",size=7,linewidth=2,edgecolor='r')
ax2_1.set_xticklabels(ax2_1.get_xticklabels(), rotation=45,horizontalalignment='right')
ax2_1.spines['right'].set_color('red')
ax2_1.tick_params(axis='y', colors='red')
ax2_1.yaxis.label.set_color('red')

sns.stripplot(data=table1,x="year",y="suicide_rate",ax=ax2_2,hue="countryName",size=7,linewidth=2,edgecolor='r')
ax2_2.set_xticklabels(ax2_2.get_xticklabels(), rotation=45,horizontalalignment='right')
ax2_2.spines['right'].set_color('red')
ax2_2.tick_params(axis='y', colors='red') 
ax2_2.yaxis.label.set_color('red')

sns.move_legend(ax1[0], "upper right")
sns.move_legend(ax1[1], "upper right")
sns.move_legend(ax2_1, "upper right")
sns.move_legend(ax2_2, "upper right")

ax1[1].set(ylim=(0, 5))
ax1[0].set(ylim=(0, 5.5))

plt.show()
