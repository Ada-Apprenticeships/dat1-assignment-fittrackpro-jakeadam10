-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
/*
SELECT 
    class_id, 
    description AS class_name, 
    name AS instructor_name
FROM classes; 
*/


-- 2. Find available classes for a specific date
/*
SELECT 
    c.class_id, 
    c.name, 
    cs.start_time, 
    cs.end_time, 
    (c.capacity - COUNT(ca.member_id)) AS available_spots
FROM classes c

JOIN class_schedule cs ON c.class_id = cs.class_id
LEFT JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id AND 
        ca.attendance_status = 'Registered'
WHERE DATE(cs.start_time) = '2025-02-01'
GROUP BY cs.schedule_id;
*/


-- 3. Register a member for a class
/*
INSERT INTO class_attendance (schedule_id, member_id, attendance_status) 
VALUES (3, 11, 'Registered'); 
*/


-- 4. Cancel a class registration
/*
UPDATE class_attendance
SET attendance_status = 'Deregistered' -- Picked appropriate status + Updated schema
WHERE member_id = 2 AND schedule_id = 7;
*/


-- 5. List top 3 most popular classes
/*
SELECT 
    c.class_id, 
    c.name AS class_name, 
    COUNT(ca.member_id) AS registration_count
FROM classes c

JOIN class_schedule cs ON c.class_id = cs.class_id
JOIN class_attendance ca ON cs.schedule_id = ca.schedule_id

GROUP BY c.class_id
ORDER BY registration_count DESC
LIMIT 3;
*/

-- 6. Calculate average number of classes per member
/*
SELECT ROUND(AVG(class_count), 2) AS avg_classes_per_member
FROM (
    SELECT COUNT(DISTINCT schedule_id) AS class_count
    FROM class_attendance
    GROUP BY member_id
) AS member_classes;
*/