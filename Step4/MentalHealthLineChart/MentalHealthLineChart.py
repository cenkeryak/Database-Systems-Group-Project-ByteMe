import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

import mysql.connector
from mysql.connector import errorcode

def connectionCreator():
    try:
        cnx = mysql.connector.connect(user="root",password="650118",database="step_3")
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

print("=============================================")

mydb = connectionCreator()

inputIsoCode = input("Enter the isoCode of the country: ")
query = "SELECT havingpeoplewithmentaldisorders.year, countryName, isoCode, drugUsePrevalence, mentalDisordersPrevalence,  rate as SuicideRateToTotalPopulation FROM havingpeoplewithmentaldisorders NATURAL JOIN countries NATURAL JOIN suicide WHERE isoCode = \"{}\";".format(inputIsoCode)
query_correlation = """SELECT countryName, isoCode, AVG(rate) as avgSuicideRate ,AVG(drugUsePrevalence) as avgDrugUse, AVG(mentalDisordersPrevalence) as avgMentalDisorders
                    FROM havingpeoplewithmentaldisorders NATURAL JOIN countries NATURAL JOIN suicide
                    GROUP BY isoCode;"""

df = pd.read_sql(query, mydb)
df_corr = pd.read_sql(query_correlation, mydb)

mydb.close()

# Testing table whether it is giving intented result or not!
#print(df)

countryName = df["countryName"][0]
year = df["year"]
drugUsePrevalence = df["drugUsePrevalence"]
mentalDisordersPrevalence = df["mentalDisordersPrevalence"]
suicideShare = df["SuicideRateToTotalPopulation"]

# To calculate correlation between them
avgSuicideRate = df_corr["avgSuicideRate"]
avgDrugUse = df_corr["avgDrugUse"]
avgMentalDisorders = df_corr["avgMentalDisorders"]


correlation_coefficient_drugMental = np.corrcoef(avgDrugUse, avgMentalDisorders)[0, 1]
print("Correlation between drug use and mental disorders: ",round(correlation_coefficient_drugMental, 4))
correlation_coefficient_drugSuicide = np.corrcoef(avgDrugUse,avgSuicideRate)[0, 1]
print("Correlation between drug use and suicide rate: ",round(correlation_coefficient_drugSuicide,4))
correlation_coefficient_mentalSuicide = np.corrcoef(avgMentalDisorders,avgSuicideRate)[0, 1]
print("Correlation between mental disorders and suicide rate: ",round(correlation_coefficient_mentalSuicide,4))


fig= plt.figure(figsize=(12, 10))
plt.plot(year, drugUsePrevalence, label = "Drug Use", linestyle = "solid")
plt.plot(year, mentalDisordersPrevalence, label = "Mental Disorders", linestyle = "solid")
plt.plot(year, suicideShare, label = "Suicide Rate", linestyle = "solid")

# Customize the chart
plt.title(countryName)
plt.xlabel('Year')
plt.ylabel('Prevalence')
plt.yticks(range(21))
plt.legend(loc='upper right', bbox_to_anchor=(1, 1.10))

# Add dashes to the y-axis at every 3rd tick
plt.grid(axis='y', which='major', linestyle='dashed', linewidth=0.5)

plt.suptitle('The Relationship Between Drug Use, Mental Health Disorders and Suicide Rate', fontweight='bold')

# Save the figure as a PNG file
plt.savefig('MentalHealtSuicideAndDrugUse.png', bbox_inches='tight')

# Show the chart (optional)
plt.show()