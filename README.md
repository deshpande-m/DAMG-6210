# <p align="center"> Conglomerate Product Supply Control System </p>

| Name | NU ID |
| --- | --- |
| Butool Abidi | 001545948 |
| Dhankuwar Sisodiya | 001066439 |
| Mayank Deshpande | 001080496 |

## Problem Statement
As the world is turning into the impacts of COVID-19, online shopping has become the most convenient option for consumers and retailers alike.

E-commerce represents an advancement in this fast-growing world. Online purchases have gained more presence and curiosity. A prodigious amount of data is provisioned, scaled, and replicated daily. A predictive model is to be designed that can speculate and refine supply chain efficiency by analysing pricing, forecasting trends, and market analysis.

## Objectives
1. To develop easy management of inventory.
2. Ability to checkout products and place the order.
3. Implementation of transaction management to roll back if needed.
4. Ability to review products.
5. Find for recommendations and data analysis.

## ER Diagram
![Untitled (4)](https://user-images.githubusercontent.com/65121120/146120607-72fd63d7-09c0-4cfb-8c8e-474ae666d1f8.png)

## Technology Stack
Oracle PL/SQL

## Topics Covered
1. Tables
2. Views
3. Indexes
4. Triggers
5. Cursors
6. Stored Procedures
7. Functions
8. Packages

## Pre-Requisites
Oracle PL/SQL Workbench should already be installed to run the scripts

## Running Instructions
1. Create a USER
    ```
    create user inventory_admin identified by "DMDDFall2021";
    ```

2. Grant privileges to the USER

    ```
    GRANT EXECUTE ANY TYPE, EXECUTE ANY PROCEDURE, ALTER ANY PROCEDURE, CREATE ANY TABLE, UNLIMITED TABLESPACE, DROP ANY TRIGGER, CREATE ANY PROCEDURE, ALTER ANY INDEX, CREATE ANY INDEX, CREATE TABLE, CREATE SESSION, DROP ANY TYPE, CREATE ANY TRIGGER, CREATE SEQUENCE, DROP ANY INDEX, SELECT ANY TABLE, DROP ANY TABLE, CREATE ANY TYPE, ALTER ANY TRIGGER, ALTER ANY SEQUENCE, CREATE ANY SEQUENCE, UPDATE ANY TABLE, CREATE TRIGGER, DROP ANY PROCEDURE, DROP ANY SEQUENCE, CREATE ANY VIEW, DELETE ANY TABLE, INSERT ANY TABLE, ALTER ANY TABLE, READ ANY TABLE, DEBUG CONNECT SESSION, MERGE ANY VIEW, ALTER ANY TYPE, CREATE PROCEDURE, SELECT ANY SEQUENCE, DROP ANY VIEW, CREATE VIEW to inventory_admin;
    ```

3. Login with the created USER

Username: inventory_admin
Password: DMDDFall2021

4. Run the scripts in given order

    4.1. inventory_ddl_script.sql - Run this script in the oracle workbench to create tables, views, triggers, indexes and sequences

    4.2. inventory_dml_scripts.sql - Run this script to insert the data into various tables and to view transactions in action

    4.3. inventory_reports_script.sql - Run this script to gain insights of the system with various reports available to view/analyze