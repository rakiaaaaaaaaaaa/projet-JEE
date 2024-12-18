-- SQL script for the Taj Hotel Booking System

-- Database creation
CREATE DATABASE TajHotelDB;
USE TajHotelDB;

-- Users table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(128) UNIQUE NOT NULL,
    password VARCHAR(128) NOT NULL,
    email VARCHAR(128) UNIQUE NOT NULL,
    role ENUM('Admin', 'Landlord', 'Customer') NOT NULL
);

-- Hotels table
CREATE TABLE Hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    location VARCHAR(128) NOT NULL,
    description TEXT,
    stars INT CHECK (stars BETWEEN 1 AND 5),
    approval_status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    landlord_id INT NOT NULL,
    FOREIGN KEY (landlord_id) REFERENCES Users(id) ON DELETE CASCADE
);

-- Rooms table
CREATE TABLE Rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    type VARCHAR(128) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    capacity INT NOT NULL,
    availability ENUM('Available', 'Unavailable') DEFAULT 'Available',
    FOREIGN KEY (hotel_id) REFERENCES Hotels(id) ON DELETE CASCADE
);

-- Bookings table
CREATE TABLE Bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Users(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Rooms(id) ON DELETE CASCADE
);

-- Sample data insertion
-- Admin user
INSERT INTO Users (username, password, email, role) 
VALUES ('admin', 'admin123', 'admin@tajhotel.com', 'Admin');

-- Sample landlords
INSERT INTO Users (username, password, email, role) 
VALUES ('landlord1', 'password1', 'landlord1@tajhotel.com', 'Landlord'),
       ('landlord2', 'password2', 'landlord2@tajhotel.com', 'Landlord');

-- Sample customers
INSERT INTO Users (username, password, email, role) 
VALUES ('customer1', 'custpass1', 'customer1@tajhotel.com', 'Customer'),
       ('customer2', 'custpass2', 'customer2@tajhotel.com', 'Customer');

-- Sample hotels
INSERT INTO Hotels (name, location, description, stars, approval_status, landlord_id) 
VALUES ('Taj Palace', 'Mumbai', 'Luxury 5-star hotel in Mumbai.', 5, 'Approved', 1),
       ('Ocean View Resort', 'Goa', 'Beachfront resort with stunning views.', 4, 'Pending', 2);

-- Sample rooms
INSERT INTO Rooms (hotel_id, type, price, capacity, availability) 
VALUES (1, 'Deluxe Room', 150.00, 2, 'Available'),
       (1, 'Suite', 300.00, 4, 'Available'),
       (2, 'Standard Room', 100.00, 2, 'Unavailable');

-- Sample bookings
INSERT INTO Bookings (customer_id, room_id, check_in_date, check_out_date, status)
VALUES (3, 1, '2024-12-20', '2024-12-25', 'Confirmed'),
       (4, 3, '2024-12-22', '2024-12-28', 'Pending');
