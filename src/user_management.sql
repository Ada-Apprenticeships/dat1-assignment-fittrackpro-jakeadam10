-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;

-- User Management Queries

-- 1. Retrieve all members

SELECT member_id, first_name, last_name, email, join_date
FROM members; 


-- 2. Update a member's contact information

UPDATE members
SET email = 'emily.jones.updated@email.com',
    phone_number = '555-9876'
WHERE member_id = 5; 



-- 3. Count total number of members

SELECT COUNT(*) AS total_members
FROM members;


-- 4. Find member with the most class registrations

WITH registration_counts AS (
    SELECT member_id, COUNT(*) AS registration_count
    FROM class_attendance
    GROUP BY member_id 
)

SELECT m.member_id, m.first_name, m.last_name, rc.registration_count
FROM registration_counts rc
JOIN members m ON rc.member_id = m.member_id
WHERE rc.registration_count = ( 
    SELECT MAX(registration_count)      -- outputs the highest registration count
    FROM registration_counts
); 


-- 5. Find member with the least class registrations

WITH registration_counts AS (
    SELECT member_id, COUNT(*) AS registration_count
    FROM class_attendance
    GROUP BY member_id
)

SELECT m.member_id, m.first_name, m.last_name, rc.registration_count
FROM registration_counts rc
JOIN members m ON rc.member_id = m.member_id
WHERE rc.registration_count = (
    SELECT MIN(registration_count)  -- outputs the lowest registration count
    FROM registration_counts
); 


-- 6. Calculate the percentage of members who have attended at least one class

SELECT ROUND(CAST(attended_members.count AS FLOAT) * 100 / total_members.Count, 2) AS percentage_attended --Rounded to 2 decimal places to follow professional conventions

FROM ( SELECT COUNT(DISTINCT member_id) AS count 
       FROM class_attendance 
       WHERE attendance_status = 'Attended') AS attended_members,

     ( SELECT COUNT(DISTINCT member_id) AS count 
       FROM class_attendance) AS total_members; 

