
-- clinic_booking_system.sql

-- ---------------------------------------------
-- Clinic Booking System Database
-- Designed for managing patients, providers, consultations, and records
-- ---------------------------------------------

-- Drop existing database if needed
DROP DATABASE IF EXISTS clinic_booking_system;

-- Create database
CREATE DATABASE clinic_booking_system;
USE clinic_booking_system;

-- ---------------------------------------------
-- Table: Specializations
-- ---------------------------------------------
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    specialization_name VARCHAR(100) NOT NULL UNIQUE
);

-- ---------------------------------------------
-- Table: Healthcare Providers
-- ---------------------------------------------
CREATE TABLE healthcare_providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    specialization_id INT,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
);

-- ---------------------------------------------
-- Table: Patients
-- ---------------------------------------------
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    registration_date DATE NOT NULL
);

-- ---------------------------------------------
-- Table: Consultations
-- ---------------------------------------------
CREATE TABLE consultations (
    consultation_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    provider_id INT,
    consultation_date TIMESTAMP NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES healthcare_providers(provider_id)
);

-- ---------------------------------------------
-- Table: Patient Records
-- ---------------------------------------------
CREATE TABLE patient_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    `condition` VARCHAR(255),
    treatment VARCHAR(255),
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- ---------------------------------------------
-- Sample Data Insertion
-- ---------------------------------------------

-- Specializations
INSERT INTO specializations (specialization_name) VALUES 
('General Practitioner'),
('Cardiologist'),
('Dermatologist'),
('Physiotherapist');

-- Healthcare Providers
INSERT INTO healthcare_providers (first_name, middle_name, last_name, email, phone_number, specialization_id) VALUES 
('Grace', 'Oluwafunmi', 'Benson', 'grace.benson@clinic.com', '08030000001', 1),
('Henry', 'Tunde', 'Adeyemi', 'henry.adeyemi@clinic.com', '08030000002', 2),
('Sarah', 'Chinwe', 'Okafor', 'sarah.okafor@clinic.com', '08030000003', 3);

-- Patients
INSERT INTO patients (first_name, middle_name, last_name, email, phone_number, registration_date) VALUES 
('David', 'Olamide', 'Ogunleye', 'david.ogunleye@gmail.com', '08010000001', '2025-04-01'),
('Esther', 'Ifeoma', 'Balogun', 'esther.balogun@gmail.com', '08010000002', '2025-04-02');

-- Consultations
INSERT INTO consultations (patient_id, provider_id, consultation_date, status) VALUES 
(1, 1, '2025-04-15 09:00:00', 'Completed'),
(2, 2, '2025-04-16 10:30:00', 'Pending');

-- Patient Records
INSERT INTO patient_records (patient_id, `condition`, treatment) VALUES 
(1, 'Flu', 'Rest and hydration'),
(2, 'Back Pain', 'Physiotherapy');

-- ---------------------------------------------
-- End of File
-- ---------------------------------------------
