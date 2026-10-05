-- 01_load.sql
-- Run after 00_schema.sql
-- Expected folder structure:
-- project/
--   sql/01_load.sql
--   data/clean/source.csv
--   data/clean/service_category.csv
--   data/clean/service.csv
--   data/clean/business.csv
--   data/clean/business_service.csv
--
-- Start MySQL with LOCAL INFILE enabled if needed.

USE local_services;

-- 1. Source
LOAD DATA LOCAL INFILE 'data/clean/source.csv'
INTO TABLE source
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(source_id, publisher, page_title, url, @collection_date, raw_file_path)
SET collection_date = STR_TO_DATE(@collection_date, '%Y-%m-%d');

-- 2. Service Category
LOAD DATA LOCAL INFILE 'data/clean/service_category.csv'
INTO TABLE service_category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(category_id, category_name);

-- 3. Service
LOAD DATA LOCAL INFILE 'data/clean/service.csv'
INTO TABLE service
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(service_id, service_name, category_id);

-- 4. Business
LOAD DATA LOCAL INFILE 'data/clean/business.csv'
INTO TABLE business
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(business_id, business_name, address, city, @website, source_id, raw_row_ref)
SET website = NULLIF(TRIM(@website), '');

-- 5. Business Service
LOAD DATA LOCAL INFILE 'data/clean/business_service.csv'
INTO TABLE business_service
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(business_id, service_id, source_id, raw_row_ref);
