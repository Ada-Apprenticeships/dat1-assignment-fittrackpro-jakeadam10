-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;

-- User Management Queries

-- 1. Retrieve all members
/* SELECT * 
FROM members */

-- 2. Update a member's contact information
UPDATE members
SET email = 'test.testicle@test.com',
    phone_number = '07777123099',
    emergency_contact_name = 'Charlotte Cartledge',
    emergency_contact_phone = '07888234234'
WHERE member_id = 1


-- 3. Count total number of members
/* SELECT COUNT(*) AS total_members
FROM members; */

-- 4. Find member with the most class registrations
-- TODO: Write a query to find the member with the most class registrations
/* SELECT member_id, COUNT(*) AS frequency
FROM members
GROUP BY member_id
ORDER BY frequency DESC
LIMIT 1; */


-- 5. Find member with the least class registrations
-- TODO: Write a query to find the member with the least class registrations

-- 6. Calculate the percentage of members who have attended at least one class
-- TODO: Write a query to calculate the percentage of members who have attended at least one class