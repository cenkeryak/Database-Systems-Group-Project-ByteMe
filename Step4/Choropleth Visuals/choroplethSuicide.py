from recitation.connect import connectionCreator
from recitation.cursor_utils import *
import pandas as pd
import numpy as np
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import folium
import branca.colormap as cm

# connect db
mydb = connectionCreator()
cursor = mydb.cursor()

# get data from db
query = """SELECT * FROM suicide"""
cursor.execute(query)
countriesTable = cursor.fetchall()
countries = {}
for country in countriesTable:
    iso = country[0]
    if iso == 'GRL':
        continue
    query = """SELECT countryName FROM countries WHERE isoCode = '{}'""".format(iso)
    cursor.execute(query)
    name = cursor.fetchall()[0][0]
    query = """SELECT AVG(rate) as avgSuicideRate
               FROM suicide
               WHERE isoCode = '{}'
               GROUP BY isoCode
               ORDER BY avgSuicideRate""".format(iso)
    cursor.execute(query)
    sui = cursor.fetchall()[0][0]
    countries[iso] = [name,sui] # name, avgSuicideRate
    if sui == 0:
        print(iso)

data = {'isoCode': [], 'countryName': [], 'avgSuicideRate': []}
for i in countries:
    data['isoCode'].append(i)
    data['countryName'].append(countries[i][0])
    data['avgSuicideRate'].append(countries[i][1])
    print(countries[i][0], countries[i][1])
df = pd.DataFrame(data)

world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
merged = world.merge(df, left_on='iso_a3', right_on='isoCode')
map = folium.Map(location=[0, 0], zoom_start=2)

# visual
folium.Choropleth(  
    geo_data=merged,
    name='Suicide',
    data=df,
    columns=['isoCode', 'avgSuicideRate'],
    key_on='feature.properties.iso_a3',
    fill_color='Reds',
    fill_opacity=0.7,
    line_opacity=0.2,
    legend_name='Suicide Rate',
    nan_fill_color='gray',
    nan_fill_opacity=0.9,
    bins=8
).add_to(map)
folium.LayerControl().add_to(map)

map.save('SuicideRateMap.html')
