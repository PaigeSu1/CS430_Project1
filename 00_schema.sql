-- 00_schema.sql
-- MySQL schema for Project 1: Local Service and Business Intelligence Database

CREATE DATABASE IF NOT EXISTS local_services;
USE local_services;

-- Clean rebuild
SET FOREIGN_KEY_CHECKS = 0;
DROP VIEW IF EXISTS directory_view;
DROP TABLE IF EXISTS business_service;
DROP TABLE IF EXISTS business;
DROP TABLE IF EXISTS service;
DROP TABLE IF EXISTS service_category;
DROP TABLE IF EXISTS source;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE source (
    source_id VARCHAR(20) PRIMARY KEY,
    publisher VARCHAR(150) NOT NULL,
    page_title VARCHAR(200) NOT NULL,
    url VARCHAR(1000) NOT NULL,
    collection_date DATE NOT NULL,
    raw_file_path VARCHAR(255) NOT NULL
);

CREATE TABLE service_category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE service (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(150) NOT NULL UNIQUE,
    category_id VARCHAR(10) NOT NULL,
    CONSTRAINT fk_service_category
        FOREIGN KEY (category_id)
        REFERENCES service_category(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE business (
    business_id INT PRIMARY KEY,
    business_name VARCHAR(200) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    website VARCHAR(1000) NULL,
    source_id VARCHAR(20) NOT NULL,
    raw_row_ref VARCHAR(50) NOT NULL,
    CONSTRAINT fk_business_source
        FOREIGN KEY (source_id)
        REFERENCES source(source_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE business_service (
    business_id INT NOT NULL,
    service_id INT NOT NULL,
    source_id VARCHAR(20) NOT NULL,
    raw_row_ref VARCHAR(50) NOT NULL,
    PRIMARY KEY (business_id, service_id),
    CONSTRAINT fk_bs_business
        FOREIGN KEY (business_id)
        REFERENCES business(business_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_bs_service
        FOREIGN KEY (service_id)
        REFERENCES service(service_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_bs_source
        FOREIGN KEY (source_id)
        REFERENCES source(source_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
