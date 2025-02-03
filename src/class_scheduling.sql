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
-- TODO: Write a query to cancel a class registration
UPDATE class_attendance
SET attendance_status = 'Deregistered'
WHERE member_id = 2 AND schedule_id = 7;


-- 5. List top 5 most popular classes
-- TODO: Write a query to list top 5 most popular classes

-- 6. Calculate average number of classes per member
-- TODO: Write a query to calculate average number of classes per member