--LICENSE

--BSD 2-Clause License

--Copyright (c) 2024, Omkar Sabnis, Raaj Mutreja, Souurabh Gavhane

--Redistribution and use in source and binary forms, with or without
---modification, are permitted provided that the following conditions are met:

--1. Redistributions of source code must retain the above copyright notice, this
 --  list of conditions and the following disclaimer.

--2. Redistributions in binary form must reproduce the above copyright notice,
--   this list of conditions and the following disclaimer in the documentation
--   and/or other materials provided with the distribution.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
--AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
--IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
--FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
--DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
--SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
--CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
--OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
---OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

----------------------------------------------------------------------------------------------------------------------------------------------


--IST 659 Project - Syracuse Housing Project
--Group Members: Omkar Sabnis, Raaj Mutreja, Souurabh Gavhane
--Group No: 25

--Caution: The down up script if run altogether won't work after the tables are UP. 
--Caution: So please execute the drop foreign constraints first, then execute drop tables twice. Then the UP script will work properly.
----------------------------------------------------------------------------------------------------------------------------------------------

--DOWN

--Drop Foreign Constraints
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_users_tenants_userid')
    alter table users_tenants drop CONSTRAINT fk_users_tenants_userid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_users_tenants_tenantid')
    alter table users_tenants drop CONSTRAINT fk_users_tenants_tenantid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_users_buyers_userid')
    alter table users_buyers drop CONSTRAINT fk_users_buyers_userid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_users_buyers_buyerid')
    alter table users_buyers drop CONSTRAINT fk_users_buyers_buyerid 

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_properties_property_landlordid')
    alter table properties drop CONSTRAINT fk_properties_property_landlordid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_properties_rentalproperties_propertyid')
    alter table properties_rentalproperties drop CONSTRAINT fk_properties_rentalproperties_propertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_properties_rentalproperties_rentalpropertyid')
    alter table properties_rentalproperties drop CONSTRAINT fk_properties_rentalproperties_rentalpropertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_properties_propertiesforsale_propertyid')
    alter table properties_propertiesforsale drop CONSTRAINT fk_properties_propertiesforsale_propertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_properties_propertiesforsale_salepropertyid')
    alter table properties_propertiesforsale drop CONSTRAINT fk_properties_propertiesforsale_salepropertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'features_feature_propertyid')
    alter table features drop CONSTRAINT fk_features_feature_propertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_displays_display_propertyid')
    alter table displays drop CONSTRAINT fk_displays_display_propertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_displays_display_websiteid')
    alter table displays drop CONSTRAINT fk_displays_display_websiteid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_reviews_review_propertyid')
    alter table reviews drop CONSTRAINT fk_reviews_review_propertyid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_reviews_review_websiteid')
    alter table reviews drop CONSTRAINT fk_reviews_review_websiteid

if exists (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    where CONSTRAINT_NAME = 'fk_expenses_expense_propertiesforsale_expenseid')
    alter table expenses drop CONSTRAINT fk_expenses_expense_propertiesforsale_expenseid
go

----------------------------------------------------------------------------------------------------------------------------------------------

--Drop Tables
drop table if exists users
drop table if exists tenants
drop table if exists users_tenants
drop table if exists buyers
drop table if exists users_buyers
drop table if exists landlords
drop table if exists properties
drop table if exists rentalproperties
drop table if exists properties_rentalproperties
drop table if exists propertiesforsale 
drop table if exists properties_propertiesforsale
drop table if exists features 
drop table if exists featuredescs
drop table if exists retailwebsites
drop table if exists displays
drop table if exists reviews
drop table if exists expenses
go

----------------------------------------------------------------------------------------------------------------------------------------------

--UP

--Create Tables 

CREATE TABLE users (
users_userid int NOT NULL,
users_user_fname varchar (255) NOT NULL, 
users_user_lname varchar (255) NOT NULL, 
users_user_city varchar (255) NOT NULL, 
users_user_country varchar (255) NOT NULL, 
users_user_dob date,
users_user_gender varchar (255) NOT NULL, 
users_user_email varchar (255) NOT NULL, 
users_user_contact varchar(255) NOT NULL, 
users_user_minbudget int,
users_user_maxbudget int,
users_user_usertype varchar(2) NOT NULL
CONSTRAINT pk_users_user_id primary key(users_userid)
constraint u_users_user_email unique (users_user_email)
)
go

CREATE TABLE tenants(
tenants_tenant_userid int NOT NULL, 
tenants_tenant_orgname varchar(255) NOT NULL,
tenants_tenant_age int NOT NULL,
CONSTRAINT pk_tenants_tenant_userid PRIMARY KEY(tenants_tenant_userid)
)
go

create table users_tenants(
    users_tenants_userid int not null,
    users_tenants_tenantid int not null
)
go

alter table users_tenants
    add constraint fk_users_tenants_userid foreign key (users_tenants_userid)
    references users (users_userid)
go

alter table users_tenants
    add constraint fk_users_tenants_tenantid foreign key (users_tenants_tenantid)
    references users (users_userid)
go

create table buyers (
buyers_buyer_userid int NOT NULL,
buyers_buyer_minarea int not null, 
buyers_buyer_maxarea int not null
constraint pk_buyers_buyer_userid primary key (buyers_buyer_userid)
)
go

create table users_buyers(
    users_buyers_userid int not null,
    users_buyers_buyerid int not null
)
go

alter table users_buyers
add constraint fk_users_buyers_userid foreign key (users_buyers_userid)
    references users (users_userid)
go

alter table users_buyers
add constraint fk_users_buyers_buyerid foreign key (users_buyers_buyerid)
    references buyers (buyers_buyer_userid)
go

CREATE TABLE landlords (
landlords_landlordid int NOT NULL, 
landlords_landlord_fname varchar(255) NOT NULL,
landlords_landlord_lname varchar(255) NOT NULL, 
landlords_landlord_email varchar(255) NOT NULL, 
landlords_landlord_contact varchar (20) NOT NULL
constraint pk_landlords_landlordid primary key (landlords_landlordid)
constraint u_landlords_landlord_email unique (landlords_landlord_email)
)
go

Create Table properties (
properties_property_propertyid int NOT NULL,
properties_property_plotnumber int NOT NULL, 
properties_property_floornumber int,
properties_property_streetname varchar(255) NOT NULL,
properties_property_zip int NOT NULL,
properties_property_totalarea int, 
properties_property_propertybuiltdate date,
properties_property_propertytype varchar(2) NOT NULL,
properties_property_landlordid int,
constraint properties_property_propertyid primary key (properties_property_propertyid)
)
go

alter table properties
    add CONSTRAINT fk_properties_property_landlordid Foreign Key (properties_property_landlordid)
    REFERENCES landlords (landlords_landlordid)

go

Create Table rentalproperties (
rentalproperties_rentalproperty_propertyid int NOT NULL,
rentalproperties_rentalproperty_leasestartdate date NOT NULL, 
rentalproperties_rentalproperty_leaseenddate date NOT NULL, 
rentalproperties_rentalproperty_leaseterm int NOT NULL, 
rentalproperties_rentalproperty_monthlyrent int NOT NULL, 
rentalproperties_rentalproperty_securitydeposit int NOT NULL
constraint pk_rentalproperties_rentalproperty_propertyid primary key (rentalproperties_rentalproperty_propertyid)
)
go

create table properties_rentalproperties(
    properties_rentalproperties_propertyid int not null,
    properties_rentalproperties_rentalpropertyid int not null
)
go

alter table properties_rentalproperties
    add constraint fk_properties_rentalproperties_propertyid foreign key (properties_rentalproperties_propertyid)
    references properties (properties_property_propertyid)
go
alter table properties_rentalproperties
    add constraint fk_properties_rentalproperties_rentalpropertyid foreign key (properties_rentalproperties_rentalpropertyid)
    references rentalproperties (rentalproperties_rentalproperty_propertyid)
go

Create Table propertiesforsale (
propertiesforsale_property_propertyid int NOT NULL, 
propertiesforsale_property_price int NOT NULL,
propertiesforsale_property_negotiable varchar(1),
propertiesforsale_property_expenseid int not null
constraint pk_propertiesforsale_property_propertyid primary key (propertiesforsale_property_propertyid),
constraint u_propertiesforsale_property_expenseid unique (propertiesforsale_property_expenseid)
)
go

create table properties_propertiesforsale (
    properties_propertiesforsale_propertyid int not null,
    properties_propertiesforsale_salepropertyid int not null,
)
go
alter table properties_propertiesforsale
    add constraint fk_properties_propertiesforsale_propertyid foreign key (properties_propertiesforsale_propertyid)
    references properties (properties_property_propertyid)
go
alter table properties_propertiesforsale
    add constraint fk_properties_propertiesforsale_salepropertyid foreign key (properties_propertiesforsale_salepropertyid)
    references propertiesforsale (propertiesforsale_property_propertyid)
go

Create Table features (
features_feature_featureid int NOT NULL, 
features_feature_featurename varchar(255),
features_feature_value int not null,
features_feature_propertyid int,
constraint pk_features_feature_featureid primary key (features_feature_featureid)
)
go

alter table features
    add constraint fk_features_feature_propertyid foreign key (features_feature_propertyid)
    references properties (properties_property_propertyid)
GO

Create Table featuredescs (
featuredescs_featuredesc_featuredescid int NOT NULL,
featuredescs_featuredesc_featurename varchar(255),
featuredescs_featuredesc_description varchar(255)
constraint pk_featuredescs_featuredesc_featuredescid primary key (featuredescs_featuredesc_featuredescid)
)
go

Create Table retailwebsites (
retailwebsites_retailwebsite_websiteid int NOT NULL, 
retailwebsites_retailwebsite_websitename varchar(255), 
retailwebsites_retailwebsite_contact varchar (20),
constraint pk_retailwebsites_retailwebsite_websiteid primary key (retailwebsites_retailwebsite_websiteid),
constraint u_retailwebsites_retailwebsite_websitename unique (retailwebsites_retailwebsite_websitename)
)
go

Create Table displays (
displays_display_displayid int NOT NULL, 
displays_display_displaydate date,
displays_display_availibility varchar(4), 
displays_display_price int,
displays_display_rent int,
displays_display_propertyid INT,
displays_display_websiteid int,
constraint pk_displays_display_displayid primary key (displays_display_displayid)
)
go

alter table displays
    add constraint fk_displays_display_propertyid foreign key (displays_display_propertyid)
    references properties (properties_property_propertyid)

alter table displays
    add constraint fk_displays_display_websiteid foreign key (displays_display_websiteid)
    references retailwebsites (retailwebsites_retailwebsite_websiteid)
go

Create Table reviews (
reviews_review_reviewid int NOT NULL, 
reviews_review_rating decimal(5,2),
reviews_review_comments varchar(255),
reviews_review_websiteid int,
reviews_review_propertyid int,
CONSTRAINT pk_reviews_review_reviewid primary key (reviews_review_reviewid)
)
go

alter table reviews
    add constraint fk_reviews_review_propertyid foreign key (reviews_review_propertyid)
    references properties (properties_property_propertyid)

alter table reviews
    add constraint fk_reviews_review_websiteid foreign key (reviews_review_websiteid)
    references retailwebsites (retailwebsites_retailwebsite_websiteid)
go

Create Table expenses (
expenses_expense_expenseid int NOT NULL, 
expenses_expense_ptax int,
expenses_expense_hoacharges int,
expenses_expense_propertiesforsale INT,
CONSTRAINT pk_expenses_expense_expenseid primary key (expenses_expense_expenseid),
CONSTRAINT u_expenses_expense_propertiesforsale UNIQUE (expenses_expense_propertiesforsale)
)
go

alter table expenses
    add constraint fk_expenses_expense_propertiesforsale_expenseid foreign key (expenses_expense_propertiesforsale)
    references propertiesforsale (propertiesforsale_property_expenseid)
go

----------------------------------------------------------------------------------------------------------------------------------------------

--Inserting data into retailwebsites table 

Insert into retailwebsites Values (1,'Orange Housing','315-545-4675')
Insert into retailwebsites Values (2,'Zillow','315-856-3376')
Insert into retailwebsites Values(3,'Syracuse Quality Living','315-346-6112')

Select * from retailwebsites


--Inserting data into landlords table

Insert into landlords Values(1,'Becky','Xin','bxin@gmail.com','315-378-6733')

Insert into landlords Values(2,'Dave','Hornstein','dahornstein@gmail.com','315-436-4733')

Insert into landlords Values(3,'Joan','Grant','jgrant@gmail.com','315-413-4949')

Insert into landlords Values(4,'Brad','Stalter','bradStal@gmail.com','315-565-7689')

Insert into landlords Values(5,'Stacy','Romano','stromano@gmail.com','315-634-2778')

Insert into landlords Values(6,'Azan','Hosein','ahosein@gmail.com','315-776-4487')

Insert into landlords Values(7,'Robert','Frank','rfrank@gmail.com','315-386-4629')

Insert into landlords Values(8,'Sean','Corcoran','scorcor@gmail.com','315-721-6733')

Insert into landlords Values(9,'Ryan','Mone','rmone@gmail.com','315-267-2418')

Insert into landlords Values(10,'Erica','Ramos','eramos@gmail.com','315-298-9933')

Select * from landlords


-- Inserting data into properties table

Insert into properties Values(1, 710, 1, 'South Beech', 13210, 1000, '1910', 'R', 1)

Insert into properties Values(2, 716, 1, 'South Beech', 13210, 1500, '1903', 'R', 2)

Insert into properties Values(3, 514, 2, 'Clarendon', 13210, 1250, '1990', 'R', 3)

Insert into properties Values(4, 1021, 2, 'Lancaster', 13210, 1050, '1965', 'R', 4)

Insert into properties Values(5, 440, 2, 'Westcott', 13210, 1300, '1948', 'R', 5)

Insert into properties Values(6, 543, 1, 'Columbus', 13210, 800, '1969', 'R', 6)

Insert into properties Values(7, 555, 1, 'Columbus', 13210, 750, '1985', 'R', 7)

Insert into properties Values(8, 620, 2, 'Westcott', 13210, 1200, '1936', 'R', 8)

Insert into properties Values(9, 1110, 1, 'Lexington', 13210, 1400, '1974', 'R', 9)

Insert into properties Values(10, 258, 2, 'Ackerman', 13210, 900, '2000', 'R', 10)

Insert into properties Values(11, 700, 1, 'Westcott', 13210, 1570, '1910', 'S', 1)

Insert into properties Values(12, 111, 3, 'Westcott', 13210, 1070, '1980', 'S', 2)

Insert into properties Values(13, 490, 2, 'Clarendon', 13210, 800, '2005-05-04', 'S', 3)

Insert into properties Values(14, 1090, 2, 'Lancaster', 13210, 500, '2007-05-04', 'S', 4)

Insert into properties Values(15, 220, 1, 'Westcott', 13210, 2000, '1880-05-04', 'S', 5)

Insert into properties Values(16, 320, 1, 'Westcott', 13210, 2050, '1890-05-04', 'S', 6)

Insert into properties Values(17, 420, 1, 'Westcott', 13210, 1150, '1990-05-04', 'S', 7)

Insert into properties Values(18, 490, 3, 'Westcott', 13210, 1750, '1992-05-04', 'S', 8)

Insert into properties Values(19, 900, 2, 'Westcott', 13210, 1700, '1995-05-04', 'S', 9)

Insert into properties Values(20, 970, 2, 'Westcott', 13210, 1480, '1998-05-04', 'S', 10)

Insert into properties Values(21, 870, 2, 'Westcott', 13210, 1080, '1998-05-04', 'R', 1)

Insert into properties Values(22, 333, 3, 'Westcott', 13210, 1880, '1999-04-04', 'R', 2)

Insert into properties Values(23, 343, 3, 'Ackerman', 13210, 2280, '2000-04-04', 'R', 2)

Insert into properties Values(24, 943, 2, 'Basset', 13210, 1080, '2001-04-04', 'R', 3)

Insert into properties Values(25, 43, 2, 'Basset', 13210, 1080, '2003-06-04', 'R', 4)

Insert into properties Values(26, 123, 2, 'Westcott', 13210, 3080, '2003-07-04', 'S', 5)

Insert into properties Values(27, 3, 2, 'Westcott', 13210, 1600, '2000-06-08', 'S', 6)

Insert into properties Values(28, 738, 2, 'Basset', 13210, 2040, '1993-06-04', 'S', 7)

Insert into properties Values(29, 803, 2, 'Ackerman', 13210, 1000, '1801-06-04', 'S', 8)

Insert into properties Values(30, 582, 2, 'Lexington', 13210, 1090, '1903-06-04', 'S', 9)

Select * from properties


-- Inserting data into rentalproperties table

Insert into rentalproperties Values(1,'08-01-2023','08-01-2024',12,385,1200)

Insert into rentalproperties Values(2,'08-05-2023','08-05-2024',12,400,1500)

Insert into rentalproperties Values(3,'07-31-2023','07-31-2024',12,440,2000)

Insert into rentalproperties Values(4,'08-02-2023','01-31-2024',6,350,1000)

Insert into rentalproperties Values(5,'08-04-2023','01-31-2024',6,450,2000)

Insert into rentalproperties Values(6,'08-01-2023','08-01-2024',12,325,900)
 
Insert into rentalproperties Values(7,'08-10-2023','08-10-2024',12,350,1000)

Insert into rentalproperties Values(8,'07-25-2023','07-25-2024',12,500,2500)

Insert into rentalproperties Values(9,'07-27-2023','07-27-2024',12,475,2250)

Insert into rentalproperties Values(10,'07-01-2023','12-31-2024',6,430,1800)

Insert into rentalproperties Values(11,'01-01-2023','06-30-2024',6,440,2000)

Insert into rentalproperties Values(12,'07-05-2023','07-04-2024',12,490,800)

Insert into rentalproperties Values(13,'09-06-2023','03-05-2024',6,520,1500)

Insert into rentalproperties Values(14,'02-01-2023','01-31-2024',12,380,2000)

Insert into rentalproperties Values(15,'10-11-2023','04-10-2024',6,600,1800)

Select * from rentalproperties


-- Inserting data into propertiesforsale table

Insert into propertiesforsale Values(1,80000,'Y',1)

Insert into propertiesforsale Values(2,90000,'Y',2)

Insert into propertiesforsale Values(3,75000,'N',3)

Insert into propertiesforsale Values(4,85000,'Y',4)

Insert into propertiesforsale Values(5,65000,'N',5)

Insert into propertiesforsale Values(6,95000,'Y',6)

Insert into propertiesforsale Values(7,100000,'Y',7)

Insert into propertiesforsale Values(8,85000,'Y',8)

Insert into propertiesforsale Values(9,60000,'N',9)

Insert into propertiesforsale Values(10,65000,'N',10)

Insert into propertiesforsale Values(11,58000,'N',11)

Insert into propertiesforsale Values(12,75000,'N',12)

Insert into propertiesforsale Values(13,88000,'Y',13)

Insert into propertiesforsale Values(14,105000,'Y',14)

Insert into propertiesforsale Values(15,92000,'Y',15)

Select * from propertiesforsale


-- Inserting data into users table

Insert into users
Values(1,'Omkar','Sabnis','Syracuse','USA','1999-03-14','Male','oasabnis@syr.edu','315- 440-2418',300,500,'S')
 

Insert into users
Values(2,'Raaj','Mutreja','Syracuse','USA','1996-03-01','Male','rkmutreja@syr.edu','315-440-5567',300,550,'S')

Insert into users
Values(3,'Souurabh','Gavhane','Syracuse','USA','1996-05-14','Male','sugavhande@syr.edu','315- 440-3367',350,525,'S')

Insert into users
Values(4,'Ankita','Nagar','Syracuse','USA','1980-05-10','Female','anagar@syr.edu','315- 476-3898',200,500,'S')

Insert into users
Values(5,'Sachin','Palli','Syracuse','USA','1976-01-20','Male','palli@syr.edu','315-657-9485',200,400,'S')

Insert into users
Values(6,'Shreya','Chowdhary','Syracuse','USA','2004-05-01','Female','schowdhary@gmail.com','315-454- 6634',200,500,'S')

Insert into users
Values(7,'Savni','Ankalikar','Syracuse','USA','1950-01-30','Female','sankaikar@gmail.com','667-445-9485',200,600,'S')

Insert into users
Values(8,'Kirti','Hassani','Syracuse','USA','1987-09-19','Female','khassani@syr.edu','315-223-5488',250,550,'S')

Insert into users
Values(9,'Ritesh','Maverick','Syracuse','USA','1969-07-13','Male','army@syr.edu','315-445-3667',300,520,'S')

Insert into users
Values(10,'Ananya','Bhupathli','Syracuse','USA','1995-05-08','Female','abhupathali@syr.edu','315-221-4533',300,600,'S')

Insert into users
Values(11,'Chris','Adams','Boston','USA','1983-07-17','Male','chadams@gmail.com','617-221-3533',70000,90000,'B')

Insert into users
Values(12,'Loki','Ferguson','Boston','USA','1999-03-15','Male','lferguson@gmail.com','617-556-7634',65000,85000,'B')

Insert into users
Values(13,'Jazz','Kerry','Texas','USA','1999-03-16','Female','jazzkerry@gmail.com','915-554-4533',75000,90000,'B')

Insert into users
Values(14,'Luiana','Williams','Maryland','USA','1997-05-15','Female','lwilliams@gmail.com','667-445- 6745',75000,100000,'B')

Insert into users
Values(15,'Josua','Patterson','Syracuse','USA','1958-08-18','Male','jpatterson@gmail.com','315-445- 4699',60000,75000,'B')

Insert into users
Values(16,'Jack','Samuel','California','USA','1978-09-01','Male','jacks@gmail.com','315-444-7679',60000,85000,'B')

Insert into users
Values(17,'Annie','Hattway','New York','USA','1999-10-11','Female','ann@gmail.com','315-544-7779',90000,105000,'B') 

Insert into users 
Values(18,'Harley','Davidson','Colorado','USA','1991-01-01','Female','harldavid@gmail.com','315-484- 1979',80000,95000,'B')

Insert into users
Values(19,'Jennifer','Aniston','Denver','USA','1974-09-10','Female','jena@gmail.com','315-443-0009',60000,70000,'B')

Insert into users
Values(20,'Sean','Sam','Pittsburgh','USA','1999-03-19','Male','sean@gmail.com','315-242-7119',70000,125000,'B') 

Select * from users


-- Inserting data into buyers

Insert into buyers Values(1,'1050','2500')

Insert into buyers Values(2,'1500','3000')

Insert into buyers Values(3,'2000','3500')

Insert into buyers Values(4,'3000','3500')

Insert into buyers Values(5,'2000' ,'3000')
 
Insert into buyers Values(6,'1500','3750')

Insert into buyers Values(7, '2500','3500')

Insert into buyers Values(8, '1575','2575')

Insert into buyers Values(9,'2050','3500')

Insert into buyers Values(10,'2750','3575')

Select * from buyers


-- Inserting data into tenants table

Insert into tenants Values(1,'Syracuse University',24)

Insert into tenants Values(2,'Syracuse University',25)

Insert into tenants Values(3,'Syracuse University',24)

Insert into tenants Values(4,'Syracuse University',24)

Insert into tenants Values(5,'Syracuse University',26)

Insert into tenants Values(6,'Syracuse University',23)
 
Insert into tenants Values(7,'Syracuse University',23)

Insert into tenants Values(8,'Syracuse University',21)

Insert into tenants Values(9,'Syracuse University',24)

Insert into tenants Values(10,'Syracuse University',24)

Select * from tenants


-- Inserting data into features table

Insert into features Values(1,'Parking',2,12)
Insert into features Values(2,'Parking',1,15)
Insert into features Values(3,'Parking',1,13)
Insert into features Values(4,'Parking',2,16)
Insert into features Values(5,'Parking',3,17)
Insert into features Values(6,'Parking',2,18)
Insert into features Values(7,'Parking',1,19)
Insert into features Values(8,'Parking',1,28)
Insert into features Values(9,'Parking',2,29)
Insert into features Values(10,'Parking',3,30)
Insert into features Values (11,'Heating',1,1)
Insert into features Values(12,'Heating',1,2)
Insert into features Values(13,'Heating',1,3)
Insert into features Values(14,'Heating',1,4)
Insert into features Values(15,'Heating',1,5)
Insert into features Values(16,'Heating',1,6)
Insert into features Values(17,'Heating',1,7)
Insert into features Values(18,'Heating',1,8)
Insert into features Values(19,'Heating',1,9)
Insert into features Values(20,'Heating',1,10)
Insert into features Values(21,'Heating',1,11)
Insert into features Values(22,'Heating',1,12)
Insert into features Values(23,'Heating',1,13)
Insert into features Values(24,'Heating',1,14)
Insert into features Values(25,'Heating',1,15)
Insert into features Values(26,'Heating',1,16)
Insert into features Values(27,'Heating',1,17)
Insert into features Values(28,'Heating',1,18)
Insert into features Values(29,'Heating',1,19)
Insert into features Values(30,'Heating',1,20)
Insert into features Values(31,'Heating',1,21)
Insert into features Values(32,'Heating',1,22)
Insert into features Values(33,'Heating',1,23)
Insert into features Values(34,'Heating',1,24)
Insert into features Values(35,'Heating',1,25)
Insert into features Values(36,'Heating',1,26)
Insert into features Values(37,'Heating',1,27)
Insert into features Values(38,'Heating',1,28)
Insert into features Values(39,'Heating',1,29)
Insert into features Values(40,'Heating',1,30)
Insert into features Values(41,'Laundary',3,26)
Insert into features Values(42,'Laundary',3,23)
Insert into features Values(43,'Laundary',3,16)
Insert into features Values(44,'Laundary',3,28)
Insert into features Values(45,'Laundary',3,15)
Insert into features Values(46,'Laundary',2,22)
Insert into features Values(47,'Laundary',2,18)
Insert into features Values(48,'Laundary',2,19)
Insert into features Values(49,'Laundary',2,11)
Insert into features Values(50,'Laundary',3,26)
Insert into features Values(51,'Laundary',3,20)
Insert into features Values(52,'Laundary',2,9)
Insert into features Values(53,'Laundary',2,5)
Insert into features Values(54,'Laundary',2,17)
Insert into features Values(55,'Laundary',1,21)
Insert into features Values(56,'Laundary',1,4)
Insert into features Values(57,'Laundary',1,13)

Select * from features


--Inserting data into featuerdescs table

Insert into featuredescs
Values
(1,'Parking','Details about whether the apartment has space reserved for parking and if yes how many slots are available'),
(2,'Heating','Details about the Heating system and of the house and whether the heater is present in the house or not'), 
(3,'Laundary','Details about the Laundry system of the house and the number of laundry units present in that particular house')

Select * from featuredescs


--Inserting data into display table

Insert into displays(displays_display_displayid,displays_display_displaydate,
displays_display_availibility,displays_display_rent, displays_display_propertyid, displays_display_websiteid)
Values
(1,'11-25-2021','Y',400,1,1),
(2,'11-26-2021','Y',450,2,1),
(3,'11-24-2021','Y',500,3,1),
(4,'11-28-2021','Y',400,4,1),
(5,'11-29-2021','N',500,5,1),
(6,'11-27-2021','Y',400,6,1),
(7,'11-30-2021','Y',400,7,1),
(8,'11-25-2021','N',600,8,1),
(9,'11-26-2021','Y',550,9,1),
(10,'11-28-2021','Y',520,10,1),
(11,'11-29-2021','Y',520,21,1),
(12,'12-03-2021','N',600,22,1),
(13,'12-04-2021','Y',600,23,1),
(14,'12-07-2021','Y',450,24,1),
(15,'12-03-2021','Y',650,25,1),
(31,'11-25-2021','Y',385,1,2),
(32,'11-29-2021','N',450,5,2),
(33,'11-27-2021','Y',325,6,2),
(34,'11-30-2021','Y',350,7,2),
(35,'11-25-2021','N',500,8,2),
(36,'11-26-2021','Y',475,9,2),
(37,'11-28-2021','Y',430,10,2),
(38,'11-29-2021','Y',440,21,2),
(39,'12-03-2021','N',490,22,2),
(40,'12-04-2021','Y',520,23,2),
(41,'12-03-2021','N',550,22,3),
(42,'12-04-2021','Y',575,23,3),
(43,'12-07-2021','Y',500,24,3),
(44,'12-03-2021','Y',675,25,3)

Insert into displays(displays_display_displayid,displays_display_displaydate,
displays_display_availibility,displays_display_price, displays_display_propertyid, displays_display_websiteid)
Values
(16,'11-26-2021','Y',80000,11,2),
(17,'11-27-2021','Y',90000,12,2),
(18,'11-25-2021','Y',75000,13,2),
(19,'11-28-2021','Y',85000,14,2),
(20,'11-29-2021','Y',65000,15,2),
(21,'11-25-2021','N',95000,16,2),
(22,'11-30-2021','Y',100000,17,2),
(23,'11-22-2021','Y',85000,18,2),
(24,'12-06-2021','Y',60000,19,2),
(25,'12-16-2021','Y',65000,20,2),
(26,'12-10-2021','Y',58000,26,2),
(27,'12-08-2021','N',75000,27,2),
(28,'12-09-2021','Y',88000,28,2),
(29,'12-13-2021','Y',105000,29,2),
(30,'12-19-2021','Y',92000,30,2),
(45,'11-29-2021','Y',70000,15,3),
(46,'11-25-2021','N',97000,16,3),
(47,'11-30-2021','Y',105000,17,3),
(48,'11-22-2021','Y',89000,18,3),
(49,'12-06-2021','Y',70000,19,3),
(50,'12-16-2021','Y',68000,20,3),
(51,'12-10-2021','Y', 58000,26,3),
(52,'12-08-2021','N', 75000, 27,3)

Select * from displays


--Inserting data into reviews table

Insert into reviews
Values (1,'2','unhygenic house, not cooperative landlord','1','1')

Insert into reviews
Values (2,'3','decent house, not cooperative landlord','2','2')
 
Insert into reviews
Values (3,'4','nice house, cooperative landlord','2','3')

Insert into reviews
Values (4,'3','lot of robbery','3','4')

Insert into reviews
Values (5,'4','good house, cooperative landlord','1','5')

Insert into reviews
Values (6,'3.5','decent house, cooperative landlord, bad heater','3','6')

Insert into reviews
Values (7,'4.5','good house','2','7')

Insert into reviews
Values (8,'4.5','good house, cooperative landlord','2','8')

Insert into reviews
Values (9,'2.5','decent house, not good neighburhood','1','9')

Insert into reviews
Values (10,'4','good house, near to university','3','10')

Insert into reviews
Values (11,'4','good house, near to market','2','11')

Insert into reviews
Values (12,'5','good house, near to university, cooperative landlord','2','12')

Insert into reviews
Values (13,'4.5','recently renovated good house','3','13')

Insert into reviews
Values (14,'3.8','good house','1','14')

Insert into reviews
Values (15,'3.5',' issues with heater, rest good house','1','15')

Insert into reviews
Values (16,'4.2','beautiful house','2','16')

Insert into reviews
Values (17,'4',' parking issues, rest good house','3','17')

Insert into reviews
Values (18,'3.8',' not so friendly neighborhood, rest good house','2','18')

Insert into reviews
Values (19,'4','good house','3','19')

Insert into reviews
Values (20,'4',' decent house','1','20')
 
Insert into reviews
Values (21,'4.5',' beautiful house with good heating system','2','21')

Insert into reviews
Values (22,'4.8',' good neighborhood, near to the university, helpful landlord','2','22')

Insert into reviews
Values (23,'3.5','ok ok house','3','23')

Insert into reviews
Values (24,'3',' average house','1', '24')

Insert into reviews
Values (25,'2.8',' bad house','1','25')

Insert into reviews
Values (26,'3.5',' beautiful house with few instances of robbery','2','26')

Insert into reviews
Values (27,'4.3','great house with good locality','2','27')

Insert into reviews
Values (28,'2.7',' creepy house','1','28')

Insert into reviews
Values (29,'3.3',' parking is an issue','3','29')

Insert into reviews
Values (30,'2.5','not good neighbourhood','1','30')

Select * from reviews


--Inserting data into expenses table

Insert into expenses 
VALUES
(1, 6000,350,1),
(2, 5000,550,2),
(3, 4000,750,3),
(4, 2000,650,4),
(5, 3000,550,5),
(6, 8000,250,6),
(7, 7000,150,7),
(8, 4000,450,8),
(9, 9000,950,9),
(10, 3000,850,10),
(11, 2000,650,11),
(12, 9000,550,12),
(13, 1000,450,13),
(14, 6000,250,14),
(15, 6000,150,15)

select * from expenses

-- Inserting data into properties_rentalproperties table to ensure proper functioning of PK-FK pair table
insert into properties_rentalproperties values 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(21,11),
(22,12),
(23,13),
(24,14),
(25,15)

select * from properties_rentalproperties

--Inserting data into properties_propertiesforsale table to ensure proper functioning of PK-FK pair table
insert into properties_propertiesforsale values
(11,1),
(12,2),
(13,3),
(14,4),
(15,5),
(16,6),
(17,7),
(18,8),
(19,9),
(20,10),
(26,11),
(27,12),
(28,13),
(29,14),
(30,15)

select * from properties_propertiesforsale

--Inserting data into users_tenants table to ensure proper functioning of PK-FK pair table
insert into users_tenants values 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10)

select * from users_tenants

--Inserting data into users_buyers table to ensure proper functioning of PK-FK pair table
insert into users_buyers values 
(11,1),
(12,2),
(13,3),
(14,4),
(15,5),
(16,6),
(17,7),
(18,8),
(19,9),
(20,10)

select * from users_buyers

----------------------------------------------------------------------------------------------------------------------------------------------

-- View 1 Average rental and list of rentals
go
drop view if exists view_rental 
go

create view view_rental as  
    with rent as (
        select cast(sum(rentalproperties_rentalproperty_monthlyrent) as decimal(6,2))/cast(count(rentalproperties_rentalproperty_monthlyrent) 
        as decimal(6,2)) as overall_rent
        from rentalproperties    
    )
    SELECT
        properties_property_plotnumber as Plot, properties_property_streetname as Street, properties_property_totalarea as Area, 
        rentalproperties_rentalproperty_monthlyrent as Rent, overall_rent as [Average Rent],
        landlords_landlord_fname as Landlord, landlords_landlord_contact as Contact  

    from rent, rentalproperties
    join properties_rentalproperties on rentalproperties_rentalproperty_propertyid = properties_rentalproperties_rentalpropertyid
    join properties on properties_property_propertyid = properties_rentalproperties_propertyid
    join landlords on landlords_landlordid = properties_property_landlordid
    where properties_property_propertytype='R'
GO

select * from view_rental
go

--View 2 Negotiable Apartments for sale and along their rating
go
drop view if exists view_sale_rating

go
create view view_sale_rating
AS
select properties_property_plotnumber as Plot, properties_property_streetname as Street, 
    properties_property_propertybuiltdate as [Built Date], properties_property_totalarea as Area,
    propertiesforsale_property_price as Price, propertiesforsale_property_negotiable as Negotiable,
    reviews_review_rating as Rating, reviews_review_comments as Comments
from properties

    join properties_propertiesforsale on properties_property_propertyid=properties_propertiesforsale_propertyid
    join propertiesforsale on propertiesforsale_property_propertyid=properties_propertiesforsale_salepropertyid
    join reviews on properties_property_propertyid=reviews_review_propertyid
where propertiesforsale_property_negotiable = 'Y'
go

select * from view_sale_rating
go

--View 3 Shows the total expense of the property for the first year including its purchase
go
drop view if exists view_property_expense

go
create view view_property_expense
As
select properties_property_plotnumber as Plot, properties_property_streetname as Street, properties_property_floornumber as Floor, 
propertiesforsale_property_price + expenses_expense_ptax + expenses_expense_hoacharges as [Total Expense]
from properties
join properties_propertiesforsale on properties_property_propertyid=properties_propertiesforsale_propertyid
join propertiesforsale on propertiesforsale_property_propertyid=properties_propertiesforsale_salepropertyid
join expenses on expenses_expense_propertiesforsale = propertiesforsale_property_propertyid
go

select * from view_property_expense
go

----------------------------------------------------------------------------------------------------------------------------------------------

--User Defined function to search by street (Example shown by searching for 'Westcott')
drop function if exists f_street_search
GO

create function f_street_search(
    @search varchar(50)
) returns table as  
return 
    select properties_property_streetname as Street, properties_property_plotnumber as Plot, properties_property_floornumber as Floor,
     properties_property_totalarea as Area,properties_property_propertybuiltdate as [Date]
    from properties cross apply string_split(properties_property_streetname,' ') where value= @search
GO

select * from f_street_search('Westcott')
go

--User Defined function to search by landlord (Example shown by searching for 'Becky')
drop function if exists f_landlord_search
go

create function f_landlord_search(
    @search varchar(50)
) returns table as  
return 
    select landlords_landlord_fname + ' ' + landlords_landlord_lname as Name, landlords_landlord_email as Email, landlords_landlord_contact as Phone,
    properties_property_plotnumber as Plot, properties_property_streetname as Street, properties_property_floornumber as Floor
    from landlords    
    join properties on landlords_landlordid = properties_property_landlordid
    cross apply string_split(cast(landlords_landlord_fname + ' ' + landlords_landlord_lname as varchar(50)),' ') where value= @search 
go

select * from f_landlord_search('Becky')
go