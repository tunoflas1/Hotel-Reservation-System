-- B103 Databases & Big Data
-- Hotel Reservation System

DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    nightly_rate DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    guest_count INT NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT UNIQUE NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

INSERT INTO Customers VALUES
(1, 'Uygar Tuna Oflas', 'uygartunaoflas@gmail.com', '491234567890'),
(2, 'Efe Cengiz', 'efecengiz@gmail.com', '491234567891'),
(3, 'Bartu Arslan', 'bartuarslan@gmail.com', '491234567892');

INSERT INTO Rooms VALUES
(1, '101', 'Single', 90.00, 'Available'),
(2, '205', 'Double', 140.00, 'Occupied'),
(3, '306', 'Suite', 230.00, 'Available');

INSERT INTO Bookings VALUES
(1, 1, 1, '2026-04-10', '2026-04-13', 1, 'Confirmed', 270.00),
(2, 2, 2, '2026-04-12', '2026-04-15', 2, 'Confirmed', 420.00),
(3, 3, 3, '2026-04-16', '2026-04-18', 2, 'Confirmed', 460.00);

INSERT INTO Payments VALUES
(1, 1, '2026-04-09', 'Card', 270.00),
(2, 2, '2026-04-11', 'Cash', 420.00),
(3, 3, '2026-04-15', 'Card', 460.00);

-- Basic retrieval
SELECT * FROM Customers;
SELECT * FROM Rooms;
SELECT * FROM Bookings;
SELECT * FROM Payments;

-- Booking details with joins
SELECT c.name, r.room_number, r.room_type, b.check_in_date, b.check_out_date, b.total_amount
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Rooms r ON b.room_id = r.room_id;

-- Count rooms by type
SELECT room_type, COUNT(*) AS total_rooms
FROM Rooms
GROUP BY room_type;

-- Total revenue
SELECT SUM(amount) AS total_revenue
FROM Payments;

-- Update example
UPDATE Rooms
SET status = 'Occupied'
WHERE room_id = 1;

-- Delete example
DELETE FROM Payments
WHERE payment_id = 3;
