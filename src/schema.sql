-- FitTrack Pro Database Schema

-- Initial SQLite setup
.open fittrackpro.db
.mode column

-- Enable foreign key support
PRAGMA foreign_key = ON;

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

-- Locations table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK(LENGTH(name) <= 255),
    address VARCHAR(255) NOT NULL CHECK(LENGTH(address) <= 255),
    phone_number VARCHAR(255) NOT NULL CHECK(LENGTH(phone_number) <= 255),
    email VARCHAR(255) NOT NULL CHECK(email LIKE '%@%.%' AND LENGTH(email) <= 255),
    opening_hours VARCHAR(255) CHECK(LENGTH(opening_hours) <= 255)
);

-- Members table
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL CHECK(LENGTH(first_name) <= 255),
    last_name VARCHAR(255) NOT NULL CHECK(LENGTH(last_name) <= 255),
    email VARCHAR(255) NOT NULL CHECK(LENGTH(email) <= 255),
    phone_number VARCHAR(255) NOT NULL CHECK(LENGTH(phone_number) <= 255),
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL,
    emergency_contact_name VARCHAR(255) NOT NULL CHECK(LENGTH(emergency_contact_name) <= 255),
    emergency_contact_phone VARCHAR(255) NOT NULL CHECK(LENGTH(emergency_contact_phone) <= 255)
);

-- Staff table
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(255) NOT NULL CHECK(LENGTH(first_name) <= 255),
    last_name VARCHAR(255) NOT NULL CHECK(LENGTH(last_name) <= 255),
    email VARCHAR(255) NOT NULL CHECK(LENGTH(email) <= 255),
    phone_number VARCHAR(255) NOT NULL CHECK(LENGTH(phone_number) <= 255),
    position VARCHAR(255) NOT NULL CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance') AND LENGTH(position) <= 255),
    hire_date DATE NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Equipment table
CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK(LENGTH(name) <= 255),
    type VARCHAR(255) NOT NULL CHECK(type IN ('Cardio', 'Strength') AND LENGTH(type) <= 255),
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Classes table
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL CHECK(LENGTH(name) <= 255),
    description TEXT NOT NULL,
    capacity INTEGER NOT NULL CHECK(capacity > 0),
    duration INTEGER NOT NULL CHECK(duration > 0),
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Class schedule table
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL CHECK(end_time > start_time),
    FOREIGN KEY (class_id) REFERENCES classes(class_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Memberships table
CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL CHECK(LENGTH(type) <= 255),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL CHECK(end_date >= start_date),
    status VARCHAR(255) NOT NULL CHECK(status IN ('Active', 'Inactive') AND LENGTH(status) <= 255),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Attendance table
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME CHECK(check_out_time >= check_in_time),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Class attendance table
CREATE TABLE class_attendance (
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    attendance_status VARCHAR(255) NOT NULL CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended', 'Deregistered') AND LENGTH(attendance_status) <= 255),
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Payments table
CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK(amount > 0),
    payment_date DATE NOT NULL,
    payment_method VARCHAR(255) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash') AND LENGTH(payment_method) <= 255),
    payment_type VARCHAR(255) NOT NULL CHECK(payment_type IN ('Monthly membership fee', 'Day pass') AND LENGTH(payment_type) <= 255),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Personal training sessions table
CREATE TABLE personal_training_sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL CHECK(end_time > start_time),
    notes TEXT,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- Member health metrics table
CREATE TABLE member_health_metrics (
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    measurement_date DATE NOT NULL,
    weight DECIMAL(5, 2) NOT NULL CHECK(weight > 0),
    body_fat_percentage DECIMAL(5, 2),
    muscle_mass DECIMAL(5, 2),
    bmi DECIMAL(4, 2) NOT NULL CHECK(bmi > 0),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-- Equipment maintenance log table
CREATE TABLE equipment_maintenance_log (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL,
    maintenance_date DATE NOT NULL,
    description TEXT NOT NULL,
    staff_id INTEGER NOT NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- After creating the tables, you can import the sample data using:
-- `.read data/sample_data.sql` in a sql file or `npm run import` in the terminal