-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;

-- Equipment Management Queries

-- 1. Find equipment due for maintenance

SELECT equipment_id, name, next_maintenance_date
FROM equipment
WHERE CAST((JulianDay(next_maintenance_date) - JulianDay('now')) AS INTEGER) < 30 --finds time difference in days
ORDER BY next_maintenance_date;


-- 2. Count equipment types in stock (UNSURE WHAT IS WANTED SO WILL DO TWO) 

-- Version 1

SELECT type, COUNT(*) AS count
FROM equipment
GROUP BY type;

-- Version 2

SELECT 
    SUBSTR(name, 1, LENGTH(name) - 2) AS equipment_type, --gets equipment name without number at the end
    COUNT(*) AS count
FROM equipment
GROUP BY equipment_type;


-- 3. Calculate average age of equipment by type (in days)

SELECT 
    SUBSTR(name, 1, LENGTH(name) - 2) AS equipment_type,    --gets equipment name without number at the end
    AVG(CAST(( JulianDay('now') - JulianDay(purchase_date)) As INTEGER)) AS avg_age_days    --gets average days in number of days
FROM equipment
GROUP BY equipment_type
ORDER BY avg_age_days DESC; 
