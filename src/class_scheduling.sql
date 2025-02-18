-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

-- Class Scheduling Queries

-- 1. List all classes with their instructors
/* SELECT class_id, description AS class_name, name AS instructor_name
FROM classes; */

-- 2. Find available classes for a specific date
/* SELECT c.class_id, c.name, cs.start_time, cs.end_time, c.capacity
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id
WHERE SUBSTR(start_time, 1, 10) = '2025-02-01'; */


-- 3. Register a member for a class
-- TODO: Write a query to register a member for a class
/* INSERT INTO class_attendance (schedule_id, member_id, attendance_status) 
VALUES (3, 11, 'Registered'); */


-- 4. Cancel a class registration
/* UPDATE class_attendance
SET attendance_status = 'Deregistered' -- Picked appropriate status + Updated schema
WHERE member_id = 2 AND schedule_id = 7; */


-- 5. List top 3 most popular classes
-- TODO: Write a query to list top 3 most popular classes

/*
SELECT c.class_id, c.name AS class_name, SUM(rc.reg_count) AS reg_count 
FROM classes c
JOIN class_schedule cs ON c.class_id = cs.class_id 
JOIN (
    SELECT schedule_id, COUNT(*) AS reg_count 
    FROM class_attendance
    GROUP BY schedule_id
    ) rc ON cs.schedule_id = rc.schedule_id 
GROUP BY c.class_id, c.name 
ORDER BY reg_count DESC
LIMIT 3;  
*/

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member

SELECT ROUND(AVG(classes_by_mem),2) as Avg_class_per_member_2dp
FROM (
    SELECT member_id, COUNT(*) as classes_by_mem
    FROM class_attendance
    GROUP BY member_id
    )

