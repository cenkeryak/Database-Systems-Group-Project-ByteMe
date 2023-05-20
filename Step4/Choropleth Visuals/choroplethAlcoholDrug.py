from recitation.connect import connectionCreator
from recitation.cursor_utils import *
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
    query = """SELECT AVG(alcoholRate) as avgAlcohol, AVG(drugRate) as avgDrug, AVG(alcoholRate)+AVG(drugRate) as sumAlcoholDrug
               FROM alcoholanddrugdisorder 
               WHERE isoCode = '{}'
               GROUP BY isoCode""".format(iso)
    cursor.execute(query)
    rates = cursor.fetchall()
    if len(rates) > 0:
        countries[iso] = [name,float(rates[0][0]),float(rates[0][1]), float(rates[0][2])] # name, avgGdp, avgGini
    
data = {'isoCode': [], 'countryName': [], 'avgAlcohol': [], 'avgDrug': [], 'alcoholDrug': []}
for i in countries:
    data['isoCode'].append(i)
    data['countryName'].append(countries[i][0])
    data['avgAlcohol'].append(countries[i][1])
    data['avgDrug'].append(countries[i][2])
    data['alcoholDrug'].append(countries[i][3])
df = pd.DataFrame(data)

world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
merged = world.merge(df, left_on='iso_a3', right_on='isoCode')
mapAlcohol = folium.Map(location=[0, 0], zoom_start=2)
mapDrug = folium.Map(location=[0, 0], zoom_start=2)
mapAD = folium.Map(location=[0, 0], zoom_start=2)

# Alcohol visual
folium.Choropleth(
    geo_data=merged,
    name='Alcohol',
    data=df,
    columns=['isoCode', 'avgAlcohol'],
    key_on='feature.properties.iso_a3',
    fill_color='Reds',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Alcohol Rate',
    nan_fill_color='black',
    bins=8
).add_to(mapAlcohol)
folium.LayerControl().add_to(mapAlcohol)
mapAlcohol.save('mapAlcohol.html')

# Drug visual
folium.Choropleth(
    geo_data=merged,
    name='Drug',
    data=df,
    columns=['isoCode', 'avgDrug'],
    key_on='feature.properties.iso_a3',
    fill_color='Reds',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Drug Rate',
    nan_fill_color='black',
    bins=8
).add_to(mapDrug)
folium.LayerControl().add_to(mapDrug)
mapDrug.save('mapDrug.html')

# AD (Alcohol+Drug) visual
folium.Choropleth(
    geo_data=merged,
    name='Alcohol and Drug',
    data=df,
    columns=['isoCode', 'alcoholDrug'],
    key_on='feature.properties.iso_a3',
    fill_color='Reds',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Alcohol+Drug Rate',
    nan_fill_color='gray',
    bins=8
).add_to(mapAD)
folium.LayerControl().add_to(mapAD)
mapAD.save('mapAD.html')


