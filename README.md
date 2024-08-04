Syracuse Housing Database
----------------------------------------------------------------------------------------------------------------------------------------
Overview

The Syracuse Housing Database project provides a comprehensive analysis of housing data in the Syracuse area. This project involves various SQL scripts, views, and functions developed using T-SQL and Azure Data Studio.
----------------------------------------------------------------------------------------------------------------------------------------
License

BSD 2-Clause License

Copyright (c) 2024, Omkar Sabnis, Raaj Mutreja, Souurabh Gavhane

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
----------------------------------------------------------------------------------------------------------------------------------------
Getting Started
----------------------------------------------------------------------------------------------------------------------------------------
Prerequisites
Azure Data Studio
SQL Server
----------------------------------------------------------------------------------------------------------------------------------------
Installation
Clone the repository to your local machine:
bash
Copy code
git clone https://github.com/osabnis1776/syracuse-housing-database.git
Open Azure Data Studio and connect to your SQL Server instance.
Execute the scripts in the following order:
----------------------------------------------------------------------------------------------------------------------------------------
Up Scripts

These scripts create the necessary database schema and populate it with initial data.

up/01_create_database.sql: Creates the Syracuse Housing database.
This script sets up the main database structure required for the project.
up/02_create_tables.sql: Creates the required tables for the project.
Tables include houses, neighborhoods, and sales.
up/03_insert_data.sql: Inserts initial data into the tables.
Populates the tables with sample data for analysis.
----------------------------------------------------------------------------------------------------------------------------------------
Down Scripts

These scripts clean up the database by removing the schema and data.

down/01_drop_database.sql: Drops the Syracuse Housing database.
This script deletes the entire database, including all data and schema.
down/02_drop_tables.sql: Drops the tables created for the project.
Removes each table individually if you prefer not to drop the entire database.
----------------------------------------------------------------------------------------------------------------------------------------
Tables

Houses
The houses table stores information about individual houses in Syracuse.

Columns:
house_id: Primary key, unique identifier for each house.
address: The address of the house.
neighborhood_id: Foreign key linking to the neighborhoods table.
price: The listing price of the house.
bedrooms: Number of bedrooms in the house.
bathrooms: Number of bathrooms in the house.
sqft: Square footage of the house.
Neighborhoods
The neighborhoods table stores information about different neighborhoods in Syracuse.

Columns:
neighborhood_id: Primary key, unique identifier for each neighborhood.
name: Name of the neighborhood.
city: City where the neighborhood is located.
state: State where the neighborhood is located.
Sales
The sales table stores information about house sales transactions.

Columns:
sale_id: Primary key, unique identifier for each sale.
house_id: Foreign key linking to the houses table.
sale_date: Date when the house was sold.
sale_price: The sale price of the house.
----------------------------------------------------------------------------------------------------------------------------------------
Views

The following views are created to simplify data retrieval:

Housing Summary
housing_summary provides a summary of housing data by aggregating information from various tables.

Columns:
neighborhood: Name of the neighborhood.
total_houses: Total number of houses in the neighborhood.
average_price: Average price of houses in the neighborhood.
total_sales: Total number of sales in the neighborhood.
Average Prices
average_prices displays average housing prices by neighborhood.

Columns:
neighborhood: Name of the neighborhood.
average_price: Average price of houses in the neighborhood.
----------------------------------------------------------------------------------------------------------------------------------------
Functions

The following functions are used to perform specific calculations:

Calculate Average Price
calculate_average_price calculates the average price of houses in a specified neighborhood.

Parameters:
@neighborhood_id: ID of the neighborhood for which to calculate the average price.
Returns:
average_price: The average price of houses in the specified neighborhood.
Get Housing Details
get_housing_details retrieves detailed information about a specific house.

Parameters:
@house_id: ID of the house for which to retrieve details.
Returns:
Detailed information from the houses table, including address, price, bedrooms, bathrooms, and square footage.
Usage

After setting up the database, you can use the provided views and functions to analyze the housing data. For example, to get a summary of housing data, you can run:

sql
Copy code
SELECT * FROM housing_summary;
To get the average price of houses in a specific neighborhood, you can call:

sql
Copy code
SELECT dbo.calculate_average_price(@neighborhood_id);
----------------------------------------------------------------------------------------------------------------------------------------
Credits

This project was developed by Omkar Sabnis, Raaj Mutreja, and Souurabh Gavhane as part of the graduate level coursework (IST 659 - Database Administration Concepts and Database Management) for the School of Information Studies at Syracuse University. Special thanks to Professor Michael Fudge for his guidance and support.
