import mysql.connector
from mysql.connector import errorcode
import pandas as pd
import matplotlib.pyplot as plt
import squarify
from connect import connectionCreator
from cursor_utils import *



def dataFetcher():
    cnx = connectionCreator()
    if cnx is None:
        print("Failed to connect to the database")
        return None

    query = """
    SELECT c.countryName, c.isoCode, AVG(s.rate) as avg_suicide_rate, AVG(s.share) as avg_suicide_share
    FROM Countries c
    JOIN Suicide s ON c.isoCode = s.IsoCode
    GROUP BY c.isoCode, c.countryName
    ORDER BY avg_suicide_rate DESC
    """

    df = pd.read_sql_query(query, cnx)
    cnx.close()
    return df


import numpy as np

def dataPlotter(df):
    labels = df.apply(lambda x: str(x['countryName']) + "\n (" + str(round(x['avg_suicide_rate'], 2)) + ")", axis=1)
    sizes = df['avg_suicide_share']
    color_range = ["#2cba00","#a3ff00", "#fff400", "#ffa700", "#ff0000"]  # distinct colors
    categories = ['Lows', 'Low-mids', 'Midranges', 'High-mids', 'Highs']  # categories

    df['labels'] = labels
    df['sizes'] = sizes

    df['categories'] = pd.qcut(df['avg_suicide_rate'], q=5, labels=categories)
    df['color'] = df['categories'].map(dict(zip(categories, color_range)))

    squarify.plot(sizes=df['sizes'], label=df['labels'], color=df['color'], alpha=.6, edgecolor='white', linewidth=2)

    # Create a Rectangle patch for each category to show in the legend
    import matplotlib.patches as mpatches
    legend_patches = [mpatches.Patch(color=color, label=category) for category, color in zip(categories, color_range)]
    plt.legend(handles=legend_patches)

    plt.axis('off')
    plt.show()


# def main():
#     df = dataFetcher()
#     if df is not None:
#         dataPlotter(df)


# if _name_ == "_main_":
#     main()


df = dataFetcher()
if df is not None:
    dataPlotter(df)