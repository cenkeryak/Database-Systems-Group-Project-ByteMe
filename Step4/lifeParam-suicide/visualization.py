from connect import connectionCreator
import pandas as pd
import seaborn as sns

import matplotlib.pyplot as plt

mydb=connectionCreator()

query="""SELECT countryName,AVG(lifeSatisfaction) as avgLifeSat,AVG(lifeExpectancy) AS avgLifeExp,AVG(rate) AS avgSuicideRate FROM
 (suicide NATURAL JOIN countriespossesslifeparametrics) NATURAL JOIN countries
GROUP BY countryName"""

df=pd.read_sql(query,mydb)

countries = df["countryName"]
# Birth rate per 1000 population
life_satisfaction = df["avgLifeSat"]
# Life expectancy at birth, years
life_expectancy = df["avgLifeExp"]
# Per person income fixed to US Dollars in 2000
suicide_rate = df["avgSuicideRate"]

correlation_coefficient = np.corrcoef(life_satisfaction, life_expectancy)[0, 1]
print("Correlation between life satisfaction and life expectancy: ",correlation_coefficient)
correlation_coefficient2 = np.corrcoef(life_satisfaction,suicide_rate)[0, 1]
print("Correlation between life satisfaction and suicide rate: ",correlation_coefficient2)
correlation_coefficient3 = np.corrcoef(life_expectancy,suicide_rate)[0, 1]
print("Correlation between life expectancy and suicide rate: ",correlation_coefficient3)



fig = plt.figure()
ax = fig.add_subplot(111)

scatter = ax.scatter(life_satisfaction, life_expectancy, c=suicide_rate, s=20*suicide_rate, alpha=0.5, cmap='viridis')  # Specify the desired colormapax.set_xlim(2, 10)
ax.set_ylim(40, 100)
ax.set_xlabel('Life Satisfaction Scale 0-10')
ax.set_ylabel('Life expectancy')

for x, y, s, country in zip(life_satisfaction, life_expectancy, suicide_rate, countries):
    ax.text(x, y, country,va="center",ha="center",fontsize=6)

cbar = plt.colorbar(scatter)
cbar.set_label('Suicide Rate')

plt.show()




