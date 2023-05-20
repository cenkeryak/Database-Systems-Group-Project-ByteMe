from connect import connectionCreator
from cursor_utils import *
import pandas as pd
import numpy as np
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import folium

# connect db
mydb = connectionCreator()
cursor = mydb.cursor()

# get data from db
query = """SELECT * FROM countrieshavefinancialstatus"""
cursor.execute(query)
countriesTable = cursor.fetchall()
countries = {}
for country in countriesTable:
    iso = country[0]
    query = """SELECT countryName FROM countries WHERE isoCode = '{}'""".format(iso)
    cursor.execute(query)
    name = cursor.fetchall()[0][0]
    query = """SELECT AVG(GDP) as avgGdp, AVG(giniCoefficient) as avgGini 
               FROM countrieshavefinancialstatus 
               WHERE isoCode = '{}'
               GROUP BY isoCode""".format(iso)
    cursor.execute(query)
    fin = cursor.fetchall()
    countries[iso] = [name,float(fin[0][0]),float(fin[0][1])] # name, avgGdp, avgGini
data = {'isoCode': [], 'countryName': [], 'avgGdp': [], 'avgGini': [], 'financeScore': []}
for i in countries:
    data['isoCode'].append(i)
    data['countryName'].append(countries[i][0])
    data['avgGdp'].append(int(countries[i][1]))
    data['avgGini'].append(countries[i][2])
    data['financeScore'].append(int(countries[i][1]*countries[i][2]))
df = pd.DataFrame(data)

world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
merged = world.merge(df, left_on='iso_a3', right_on='isoCode')
mapGDP = folium.Map(location=[0, 0], zoom_start=2)
mapGini = folium.Map(location=[0, 0], zoom_start=2)
mapGG = folium.Map(location=[0, 0], zoom_start=2)

# GDP visual
folium.Choropleth(
    geo_data=merged,
    name='gdpScore',
    data=df,
    columns=['isoCode', 'avgGdp'],
    key_on='feature.properties.iso_a3',
    fill_color='Greens',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='GDP Score',
    nan_fill_color='black',
    bins=7,
).add_to(mapGDP)
folium.LayerControl().add_to(mapGDP)
mapGDP.save('mapGDP.html')

# Gini visual
folium.Choropleth(
    geo_data=merged,
    name='giniScore',
    data=df,
    columns=['isoCode', 'avgGini'],
    key_on='feature.properties.iso_a3',
    fill_color='YlOrRd',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Gini Score',
    nan_fill_color='black',
    bins=12
).add_to(mapGini)
folium.LayerControl().add_to(mapGini)
mapGini.save('mapGini.html')

# GG (Gini*GDP) visual
folium.Choropleth(
    geo_data=merged,
    name='financeScore',
    data=df,
    columns=['isoCode', 'financeScore'],
    key_on='feature.properties.iso_a3',
    fill_color='Greens',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Finance Score',
    nan_fill_color='gray',
    bins=12
).add_to(mapGG)
folium.LayerControl().add_to(mapGG)
mapGG.save('mapGG.html')


