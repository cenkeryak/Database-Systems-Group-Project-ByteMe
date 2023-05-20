![drug](https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe/assets/108605025/5b00ec3d-52ce-4b53-bd17-5e172187805e)
![gdp](https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe/assets/108605025/bce08eee-ac7a-43d9-8ed4-30373f1c08d2)
<a name="br1"></a>CS306 Project Step 4 Document

**Group Name:** Byte Me

**Group Members:**

*Alpay Naçar* - 31133
*Anıl Şen* - 29556

*Bahadır Yazıcı* - 30643
*Cenker Yakışır* - 28831
*Hasan Fırat Yılmaz* - 29002

**Github link: <https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe>**

1-Life Parametrics x Suicide Relationship

The initial aim was to form a common area for both suicide data and life parametrics data. In this
sense, years data existing for both of these gathered and the others were omitted with the use
of “NATURAL JOIN”. Once the desired form was achieved, “NATURAL JOIN” method was
applied once more with *countries* table, so that the names of the countries were in our hands to
be used for making visualization more understandable rather than iso codes.

After the data of these two were put in a proper shape, an averaging process started for
interpreting data as a whole instead of interpreting as separate year points. Hence, the table
was grouped by country names and the average of suicide rates, life expectancy and life
satisfaction was taken.

From this point on, scatter plot was decided on with the hope of showing the relation between
three variables and identifying data patterns if there is any. In this plot, x and y axes were
assigned to average life satisfaction and average life expectancy respectively. Moreover, to put
average suicide rates into the picture, sizes and color coding were used. The larger size implies
the larger suicide rates and this feature was supported with the colors, where colors’ meaning
were represented through the legend used in the plot. Also, while plotting the data, it was the
case that all countries available in our data had life expectancy greater than 40 and life
satisfaction greater than 3. Therefore; the ranges, 0-40 for y axis and 0-3 for x axis, were
trimmed out in order to put more focus on the real ranges.

When it comes to identifying the patterns for our scatter plot, we found that there is a correlation
between life expectancy and life satisfaction, whose correlation coefficient is




<a name="br2"></a>0.79608989870765. This value can be considered as a strong positive correlation. Then, we
analyzed the correlation between individual life parametrics and suicide rates, which was the
ultimate aim. It turned out that there is a weak negative correlation between life expectancy and
suicide rates, whose correlation coefficient is -0.2718401009515671. Furthermore, there is a
very weak negative correlation between life satisfaction and suicide rates, whose correlation
coefficient is -0.09808785820782981. Although this was not expected, we do not get any
contradictory results that countries having higher life expectancy and satisfaction compared to
the others, are in a range in which suicide rates are low. In addition to that, the highest suicide
rate is observed in a country named “Lesotho” where the life expectancy and satisfaction values
are so close to the values that are the lowest values obtained for life expectancy and
satisfaction in our data.

2- Alcohol-Drug X Suicide Relationship

The relationship is between alcohol-drug rates and suicide rates is examined for 2 given input
countries for comparison. Program asks for the 2 countries from the user. Then, alcohol-drug



<a name="br3"></a>table and suicide table is joined by NATURAL JOIN. Also countries table is joined by NATURAL
JOIN to use country name instead of iso codes.

There are 2 sub graph, these 2 sub graphs consist barchart to represent alcohol or drug rate,
and scatter plot to represent suicide rate. The color of the dots and columns represent the
respective country in the legend.

In these graphs, we can see that change in alcohol rate or drug rate has effect on suicidal rate
or not. Also, we can compare those 2 countries.




<a name="br4"></a>3-Mental Health Disorders x Drug Use x Suicide Relationship

The figure below illustrates the relationship among drug use, the prevalence of mental health
disorders, and suicide rates for the specified isoCode of the country in the code. This
relationship figure can be obtained for any country listed in the countries table. To achieve this, I
utilized a natural join operation with the suicide table and the havingpeoplewithmentaldisorders
table to retrieve the suicide rate, drug use rate, and mental disorders prevalence within a single
query. Additionally, I performed another natural join operation with the countries table to obtain
the corresponding country name based on the isoCode.

Furthermore, I executed a separate query to calculate the average values of these three
attributes and determine the correlation between them, encompassing all countries in the
countries list. The correlation coefficient between drug use and mental disorders was found to
be 0.4067, indicating a positive moderate correlation. Moreover, the correlation coefficient
between drug use and suicide rate was determined to be 0.1907, suggesting a weak positive
correlation between drug use and suicide rate. Lastly, the correlation coefficient between mental
disorders and suicide rate was found to be -0.0955, which is considered a negligible small
value, indicating no significant correlation between mental disorders and suicide rate.




<a name="br5"></a>4-Suicide Rate and Share

The treemap below is an illustration of the suicide data which represents the countries’s average
suicide rate(per 100k person) and share produced by aggregate functions. The table is
produced with the help of the libraries pandas and squarify. The countries are categorized and
colored to five broad headings by the average suicide rate. The field it occupies images the
average share of the country.

5- Drug usage x GDP per capita

In this step of the project, we tried to observe the potential relationship between a country's
GDP per capita and its drug usage. Our goal is to uncover any correlation or pattern that may
exist between these two entities. To do that, we used the data we prepared in previous steps.

To initiate our investigation, we acquired data on GDP per capita and drug usage from our
MySQL database. Utilizing Python, we established a connection to the database and executed
SQL queries to extract the relevant information. To simplify the process, we took average
numbers for each country. In the end, used pandas library for manipulating and preparing the
data for subsequent analysis.

I decided to create a choropleth visualization to show countries' GDP per capita and their drug
usage rates (Screenshots of visuals are right below). And by looking at these visuals we can




<a name="br6"></a>say that there is strong correlation between these two entities. Countries highlighted in one of
the visualizations are generally highlighted on the other visualization too.
