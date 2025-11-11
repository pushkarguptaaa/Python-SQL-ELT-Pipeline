# Netflix ELT Pipeline — Data Cleaning and Dimensional Modeling (SQL + Python)

This project implements an end-to-end ELT (Extract → Load → Transform) pipeline using the Netflix dataset.  
The goal is to convert a raw CSV file into a fully cleaned, standardized, and analytics-ready dimensional model using SQL and Python.

The workflow replicates a real-world data engineering process:  
raw data → staging → cleaning → modeling → final star schema.

---

## Project Overview

This project focuses on:

- Cleaning and preprocessing the raw Netflix dataset  
- Standardizing inconsistent fields (dates, durations, genres, countries)  
- Handling duplicates and missing values  
- Designing a star schema with fact and dimension tables  
- Validating cleaned data using Python (pandas)

The final deliverable is a clean SQL database structured for BI dashboards and analytics.

---

## Tech Stack

- SQL (SQLite or SQL Server)  
- Python (pandas, Jupyter Notebook)  
- CSV dataset  
- SQL staging and modeling scripts  
- DB Browser or any SQL GUI 
