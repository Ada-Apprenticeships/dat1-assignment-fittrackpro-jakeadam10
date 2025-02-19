-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support

PRAGMA foreign_key = ON;

-- Payment Management Queries

-- 1. Record a payment for a membership

INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (11, 50, datetime('now', 'localtime'), 'Credit Card', 'Monthly membership fee');   --records payment with current datetime


-- 2. Calculate total revenue from membership fees for each month of the last year

SELECT 
      CAST(STRFTIME('%m', payment_date) AS INTEGER) AS payment_month, -- extracts month from payment_date
      SUM(amount) AS total_revenue
FROM payments
WHERE payment_type = 'Monthly membership fee' AND 
      STRFTIME('%Y', payment_date) = STRFTIME('%Y', DATE('now', '-1 year')) --extracts data from the previous year
GROUP BY payment_month
ORDER BY payment_month; 




-- 3. Find all day pass purchases

SELECT payment_id, amount, payment_date, payment_method
FROM payments
WHERE payment_type = 'Day pass';
