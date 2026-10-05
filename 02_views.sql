-- 02_views.sql
-- Reusable directory view required for Q6

USE local_services;

CREATE OR REPLACE VIEW directory_view AS
SELECT
    business_id,
    business_name,
    address,
    city,
    website
FROM business;
