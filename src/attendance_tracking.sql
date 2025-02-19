-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;


-- Attendance Tracking Queries

-- 1. Record a member's gym visit
/*
INSERT INTO attendance (member_id, location_id, check_in_time, check_out_time)
VALUES (7, 1, DATETIME('now'), NULL);
*/

-- 2. Retrieve a member's attendance history
/*
SELECT 
    DATE(check_in_time) AS visit_date, 
    TIME(check_in_time) AS check_in_time, 
    TIME(check_out_time) AS check_out_time
FROM attendance
WHERE member_id = 5
ORDER BY visit_date;
*/

-- 3. Find the busiest day of the week based on gym visits
/* 
SELECT 
    STRFTIME('%w', check_in_time) AS day_of_week, 
    COUNT(*) AS visit_count
FROM attendance
GROUP BY day_of_week
ORDER BY visit_count DESC
LIMIT 1;
*/

-- 4. Calculate the average daily attendance for each location
/*
SELECT 
    l.name AS location, 
    printf('%0.2f', ROUND(AVG(daily_count), 2)) AS avg_daily_attendance --rounds to EXACTLY 2dp for uniformity and professional consistency

FROM (
    SELECT location_id, DATE(check_in_time) AS visit_date, COUNT(*) AS daily_count
    FROM attendance
    GROUP BY location_id, visit_date
    ) AS daily_attendance
JOIN locations l ON daily_attendance.location_id = l.location_id
GROUP BY location;
*/