-- 03_queries.sql
-- Six required queries, Q1-Q6

USE local_services;

-- Q1
-- Parameter: name fragment = 'Bank'
-- Meaning: businesses whose names contain the selected fragment.
SELECT
    business_id,
    business_name,
    city
FROM business
WHERE business_name LIKE '%Bank%'
ORDER BY business_name, business_id;

-- Q2
-- Parameters: city = 'Kirksville', service = 'Personal Banking'
-- Meaning: businesses in Kirksville with a recorded Personal Banking offering.
SELECT DISTINCT
    b.business_name AS provider,
    s.service_name AS service,
    src.url AS source_url,
    bs.raw_row_ref
FROM business AS b
JOIN business_service AS bs
    ON b.business_id = bs.business_id
JOIN service AS s
    ON bs.service_id = s.service_id
JOIN source AS src
    ON bs.source_id = src.source_id
WHERE b.city = 'Kirksville'
  AND s.service_name = 'Personal Banking'
ORDER BY b.business_name;

-- Q3
-- Parameter: minimum provider count = 2
-- Meaning: services with at least two distinct recorded providers.
SELECT
    s.service_name,
    COUNT(DISTINCT bs.business_id) AS provider_count
FROM service AS s
JOIN business_service AS bs
    ON s.service_id = bs.service_id
GROUP BY s.service_id, s.service_name
HAVING COUNT(DISTINCT bs.business_id) >= 2
ORDER BY provider_count DESC, s.service_name;

-- Q4
-- Parameter: service = 'Personal Banking'
-- Meaning: businesses with no recorded Personal Banking offering.
-- Important: this means "not recorded" in this dataset, not proof that the
-- business does not actually provide the service.
SELECT
    b.business_id,
    b.business_name
FROM business AS b
WHERE NOT EXISTS (
    SELECT 1
    FROM business_service AS bs
    JOIN service AS s
        ON bs.service_id = s.service_id
    WHERE bs.business_id = b.business_id
      AND s.service_name = 'Personal Banking'
)
ORDER BY b.business_name, b.business_id;

-- Q5
-- Parameter: selected business ID = 1
-- Meaning: list every service type; matched_business_id is 1 when the
-- selected business has that offering, otherwise NULL.
SELECT
    s.service_id,
    s.service_name,
    bs.business_id AS matched_business_id
FROM service AS s
LEFT JOIN business_service AS bs
    ON s.service_id = bs.service_id
   AND bs.business_id = 1
ORDER BY s.service_name, s.service_id;

-- Q6
-- Meaning: businesses in the reusable directory view with no recorded website.
SELECT
    business_id,
    business_name,
    city
FROM directory_view
WHERE website IS NULL
ORDER BY business_name, business_id;
