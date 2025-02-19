-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;


-- Staff Management Queries

-- 1. List all staff members by role
/*
SELECT staff_id, first_name, last_name, position AS role
FROM staff
ORDER BY role;
*/

-- 2. Find trainers with one or more personal training session in the next 30 days
/*
SELECT 
    s.staff_id, 
    s.first_name || ' ' || s.last_name AS trainer_name, --concatonates first and last name with a space
    COUNT(p.session_date) AS session_count
FROM personal_training_sessions p
JOIN staff s ON p.staff_id = s.staff_id
WHERE s.position = 'Trainer' AND p.session_date BETWEEN DATE('now') AND DATE('now', '+30 days')
GROUP BY s.staff_id;
*/
