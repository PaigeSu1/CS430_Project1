# CS 430 – Project 1 – Fall 2026
Team: Amarachi Okogbue, Diana Lam, Paige Su, Yash Rajput

## System Overview

Our project allows users to search up different businesses and the services they offer. Our database contains information about businesses in Kirksville (including name, address, website, and references). Each service is classified into one service category. This allows users to search by services rather than only businesses. Every record is linked to a source which tells them where the data came from. Our project’s intended users include Kirksville locals, college students, and residents from surrounding smaller towns in the northeast Missouri area. 

## MySQL Version

8.0.46

## Run Commands

Run these from the project root. Replace `<user>` with your MySQL username (you will be prompted for the password). No network access or credentials are needed.

**Database name:** `local_services` (created by `00_schema.sql`)

### 1. Build the database
```bash
mysql -u <user> -p < sql/00_schema.sql
mysql -u <user> -p local_services < sql/01_load.sql
mysql -u <user> -p local_services < sql/02_views.sql
```

### 2. Run the queries (Q1–Q6)
```bash
mysql -u <user> -p local_services < sql/03_queries.sql
```

### 3. Run the validation tests (T1–T4)
```bash
mysql -u <user> -p local_services < tests/T1.sql
mysql -u <user> -p local_services < tests/T2.sql
mysql -u <user> -p local_services < tests/T3.sql
mysql -u <user> -p local_services < tests/T4.sql
```

### 4. Clean rebuild (reset)
`00_schema.sql` drops and recreates only the `local_services` database, so repeating steps 1–3 gives the same counts with no duplicate rows.

## Tables and Keys Summary
| Table | Purpose | Primary key | Foreign keys |
|-------|---------|-------------|--------------|
| Business | Used for businesses, name, address, city, website, and identifying sources. | business_id | source_id → source |
| Service Category | 7 service categories (education, healthcare, utility, community services, insurance, financial services, retail) | category_id | |
| Service | Cataloged service types each tied to exactly one category. | service_id | category_id → service_category |
| Business Service | Associative table with many to many relationships with business & Service, with each row sourced to one offering. | (business_id, service_id) | business_id → business, service_id → service, source_id → source |
| Source | Used for each cited webpage/dataset, publisher, title, url, collection date, raw file path. | source_id | |

## Table Columns
| Table | Columns |
|---------|-------------|
| Business | business_id, business_name, address, city, website, source_id, raw_row_ref |
| Service Category | category_id, category_name |
| Service | service_id, service_name, category_id |
| Business Service | business_id, service_id, source_id, raw_row_ref |
| Source | source_id, publisher, url, dataset title, collection_date, raw_file_path |

**Business**
- business_id: unique ID for a business
- business_name: a business' name
- address: physical street address of a business
- city: the city a business is located in
- website: provider's website
- source_id: source that supports the business's name and location
- raw_row_ref: row ID in the raw CSV

**Service Category**
- category_id: unique ID for a service type/category
- category_name: the name of a category of service

**Service**
- service_id: unqiue ID for service
- service_name: name for service
- category_id: category a service belongs to

**Business Service**
- business_id: business that offers the service
- service_id: service the business offers
- source_id: source that supports the offering
- raw_row_ref: row ID in the raw CSV

**Source**
- source_id: unique ID for the source 
- publisher: organization that published the information
- url: exact URL of a business' page
- dataset title: title of data shown by the publisher
- collection_date: date the source was accessed
- raw_file_path: location of the saved raw capture

## Contributions

Amarachi Okogbue
- Report
- Debugging
- raw data file creation 

Diana Lam
- Report
- Debugging
- Read Me

Paige Su
- Report
- Debugging
- ER Model
- Normalization

Yash Rajput
- Report
- Debugging
- SQL code
