# Database-Systems-Group-Project-ByteMe

# CS306 Project Step1 Document

### Group Name: Byte Me

### Group Members:

Alpay Naçar - 31133
Anıl Şen - 29556
Bahadır Yazıcı - 30643
Cenker Yakışır - 28831
Hasan Fırat Yılmaz - 29002

### Github link: https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe
### Topic: Suicide
### Description: 


![](https://github.com/cenkeryak/Database-Systems-Group-Project-ByteMe/blob/a85781dcab5fc861ffc7c99d061a9073bd66596e/ER%20Model.png)
This document is prepared for the database systems course project, and it includes the steps we passed while obtaining the data and what we are planning to do with this dataset.

In this first step of the project, we gathered data from the website https://ourworldindata.org/ related to suicide which is under the topic of health. separated the dataset from the flat design into smaller portions based on the entity sets, the relationship sets, and the attributes. We then cleaned and removed duplicates from the final sets and created our CSV files which we uploaded to our repository. We then created an ER diagram to depict the entities, relationships, and attributes, identifying and explaining the constraints and custom constructs. 

We also provided a project description which includes the title of our project and explains what our database application will be, what data we are storing, and which world problems we are addressing. We also provided a link to our repository. Our project aims to create a database application that stores data related to our chosen topic and address the world problems associated with it. The data and database application will be used to gain insights about the chosen topic and help bring about solutions for the world problems.

ER diagram
explanations (Identify your CSV files and how you separated them from the flat design. Please briefly explain the cleaning steps you took, such as removing duplicates from your final sets, etc.)

### Countries Entity

Attributes: 1.Country Name 2.Country Code

This entity is referred to as a country and is in a relationship with all other entities. Therefore, it plays a crucial role in setting the whole database system.


### Continents Entity:

Relationship: Continents "include" countries
Attributes: 1.Continent Name 2.Continent Code

This entity represents continents that have their name and their unique codes. This entity is in a relationship with “Countries Entity” within the framework of inclusion.


### Mental Health Entity:

Relationship: Countries "have people with issues in" mental health
Attributes: 1.Year 2.Disorder types 

This entity has attributes of year, disorder types and their prevalence. This is a weak entity whose owner entity is countries. The relationship is: Countries "have people with issues in" mental health. The data related to this entity is stored into a CSV file named "prevalence by specific mental disorders and substance use disorder". To make the CSV file consistent, we removed the rows that do not include prevalence values. In addition to that, the value of "prevalence of mental issues in general"(the last column) is not initially included in that CSV file and originates from another dataset, but is merged with the main dataset. However, in this merging process some cells didn't have values because of incomplete data in one of the dataset. This issue is fixed by providing a NULL value for those cells.


### Life Parametrics Entity:

Relationship: Countries “possess” life parametrics
Attributes: 1. Year 2. Life Satisfaction 3. Life Expectancy
 
In the process of the formation of this entity, firstly our focus is put on gathering life satisfaction data in which several rows having blank iso codes were deleted and thus making the consistency throughout the CSV document. Furthermore, with the intention of putting more descriptive attributes, life expectancy data is collected and merged with the satisfaction part of the data based on their matching iso codes and years. As a result of this process, a list of country names, iso codes, life expectancy, life satisfaction and the corresponding years are gathered in one dataset. This life parametrics entity, which is a weak entity, is expected to be in a relationship with the country entity which is called as ‘have’.

### Suicide Entity:

Relationship: Countries "have people committed" suicide
Attributes: 1.Year 2.Death Share 3.Death Rate 4.Female:Male Ratio

This entity has attributes of year, male:female ratio, death share and rate. This is a weak entity whose owner entity is countries. The relationship is: Countries "have people committed" suicide. The data related to this entity is stored into a CSV file named "suicide". The data is merged with three datasets. However, in this merging process some cells didn't have values because of incomplete data in one of the dataset. This issue is fixed by providing a NULL value for those cells.


### Alcohol and Drug Disorder Entity:

Relationship: Countries "have people with disorder of" alcohol and drug usage
Attributes: 1.Year 2. Alcohol Disorder (percentage) 3. Drug disorder (percentage)

This entity has attributes of year, alcohol disorder and drug disorder. These attributes are represented by percentage in population. This entity is a weak entity Since prevalence is represented with respect to countries. The relationship is: Countries "have people with disorder of" alcohol and drug usage. The entity with the relationship is stored in a CSV file named as " share-with-alcohol-vs-drug-use-disorder.csv". To make the CSV file consistent, we removed the rows that do not include prevalence value of neither alcohol disorder nor drug disorder. Also, the Continent column is removed from the dataset since we keep that information in the Continents dataset already. The alcohol-vs-drug-disorder dataset will be used to determine is there any correlation between suicide prevalence with the alcohol disorder or drug disorder. If so, we will decide whether it is causation or not.

### Financial Status Entity

Relationship: Countries "have" financial status
Attributes: 1.Year 2. Gini coefficient 3. Gross Domestic Product (GDP)

This entity has attributes of year, Gini coefficient, and gross domestic product. This entity is a weak entity. The relationship is: Countries "have" financial status. The entity with the relationship is stored in a CSV file named "financial-status.csv". To be able to reach this version of this data, first deleted unnecessary rows from poverty-explorer.csv. To make the CSV file consistent, we removed the rows that do not include the gross domestic product value or Gini coefficient reported. The financial status dataset will be used to determine if there is any correlation between the financial conditions of people and the rate of them committing suicide.




