{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww29200\viewh17740\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 INSERT INTO banks (bank_id, bank_name, branch_name, branch_code, ifsc_code, created_at)\
VALUES\
(1, 'HDFC Bank', 'MG Road', 'BR001', 'HDFC0001', NOW()),\
(2, 'ICICI Bank', 'Kothrud', 'BR002', 'ICIC0002', NOW()),\
(3, 'SBI Bank', 'Hadapsar', 'BR003', 'SBI0003', NOW()),\
(4, 'Axis Bank', 'Camp', 'BR004', 'AXIS0004', NOW()),\
(5, 'Kotak Bank', 'Viman Nagar', 'BR005', 'KOTAK0005', NOW());\
\
INSERT INTO customers (customer_id, full_name, gender, age, dob, email, phone, address, bank_id, credit_score, created_at)\
VALUES\
(1, 'Amit Sharma', 'Male', 28, '1997-05-14', 'amit@gmail.com', '9876543210', 'Delhi, India', 1, 720, NOW()),\
(2, 'Priya Verma', 'Female', 32, '1993-08-21', 'priya@gmail.com', '8765432109', 'Mumbai, India', 2, 680, NOW()),\
(3, 'Rohit Singh', 'Male', 40, '1985-11-02', 'rohit@gmail.com', '7654321098', 'Bangalore, India', 1, 750, NOW()),\
(4, 'Neha Kapoor', 'Female', 26, '1999-01-15', 'neha@gmail.com', '6543210987', 'Pune, India', 3, 710, NOW()),\
(5, 'Karan Mehta', 'Male', 35, '1990-06-30', 'karan@gmail.com', '9123456780', 'Hyderabad, India', 4, 690, NOW()),\
(6, 'Sneha Iyer', 'Female', 30, '1994-03-11', 'sneha@gmail.com', '9988776655', 'Chennai, India', 5, 730, NOW()),\
(7, 'Vikram Rao', 'Male', 45, '1979-09-09', 'vikram@gmail.com', '8899776655', 'Ahmedabad, India', 2, 650, NOW()),\
(8, 'Pooja Nair', 'Female', 29, '1996-12-22', 'pooja@gmail.com', '7799665544', 'Kolkata, India', 3, 705, NOW()),\
(9, 'Ankit Desai', 'Male', 33, '1992-04-10', 'ankit@gmail.com', '6677889900', 'Surat, India', 1, 740, NOW()),\
(10, 'Riya Kulkarni', 'Female', 27, '1998-07-07', 'riya@gmail.com', '8877665544', 'Jaipur, India', 4, 700, NOW());\
\
INSERT INTO cards (card_id, customer_id, bank_id, card_number, expiry_date, cvv, card_limit, is_active, created_at, card_type)\
VALUES\
(1, 1, 1, '4111111111111111', '2027-05-01', 123, 200000, TRUE, NOW(), 'Credit'),\
(2, 1, 1, '4111222233334444', '2026-11-01', 234, 150000, TRUE, NOW(), 'Debit'),\
(3, 2, 2, '5111111111111111', '2028-03-01', 321, 180000, TRUE, NOW(), 'Credit'),\
(4, 3, 1, '6111222233334444', '2027-12-01', 456, 250000, TRUE, NOW(), 'Credit'),\
(5, 4, 3, '7111222233334444', '2026-08-01', 789, 100000, TRUE, NOW(), 'Debit'),\
(6, 5, 4, '8111222233334444', '2029-09-01', 987, 300000, TRUE, NOW(), 'Credit'),\
(7, 6, 5, '9111222233334444', '2027-01-01', 654, 220000, TRUE, NOW(), 'Credit'),\
(8, 7, 2, '4222333344445555', '2028-10-01', 741, 120000, TRUE, NOW(), 'Debit'),\
(9, 8, 3, '5333444455556666', '2026-07-01', 852, 140000, TRUE, NOW(), 'Credit'),\
(10, 9, 1, '6444555566667777', '2029-05-01', 963, 160000, TRUE, NOW(), 'Credit'),\
(11, 10, 4, '7555666677778888', '2028-02-01', 159, 180000, TRUE, NOW(), 'Debit'),\
(12, 2, 2, '8666777788889999', '2027-06-01', 357, 130000, TRUE, NOW(), 'Credit'),\
(13, 3, 1, '9777888899990000', '2026-03-01', 258, 190000, TRUE, NOW(), 'Credit'),\
(14, 6, 5, '3888999900001111', '2028-09-01', 147, 175000, TRUE, NOW(), 'Debit'),\
(15, 4, 3, '4999000011112222', '2029-12-01', 369, 200000, TRUE, NOW(), 'Credit');\
\
INSERT INTO merchants (merchant_id, merchant_name, category, city, country, created_at)\
VALUES\
(1, 'Amazon', 'E-commerce', 'Mumbai', 'India', NOW()),\
(2, 'Flipkart', 'E-commerce', 'Bengaluru', 'India', NOW()),\
(3, 'Big Bazaar', 'Retail', 'Delhi', 'India', NOW()),\
(4, 'Zomato', 'Food Delivery', 'Pune', 'India', NOW()),\
(5, 'Swiggy', 'Food Delivery', 'Hyderabad', 'India', NOW()),\
(6, 'Myntra', 'Fashion', 'Bengaluru', 'India', NOW()),\
(7, 'BookMyShow', 'Entertainment', 'Mumbai', 'India', NOW()),\
(8, 'Uber', 'Transport', 'Chennai', 'India', NOW());\
\
INSERT INTO locations (location_id, city, state, country, address, latitude, longitude)\
VALUES\
(1, 'Mumbai', 'Maharashtra', 'India', '123 Marine Drive', 19.0760, 72.8777),\
(2, 'Delhi', 'Delhi', 'India', '456 Connaught Place', 28.7041, 77.1025),\
(3, 'Bengaluru', 'Karnataka', 'India', '789 MG Road', 12.9716, 77.5946),\
(4, 'Pune', 'Maharashtra', 'India', '101 FC Road', 18.5204, 73.8567),\
(5, 'Chennai', 'Tamil Nadu', 'India', '202 Marina Beach Road', 13.0827, 80.2707),\
(6, 'Hyderabad', 'Telangana', 'India', '303 Banjara Hills', 17.3850, 78.4867),\
(7, 'Jaipur', 'Rajasthan', 'India', '404 MI Road', 26.9124, 75.7873),\
(8, 'Ahmedabad', 'Gujarat', 'India', '505 CG Road', 23.0225, 72.5714);\
\
INSERT INTO devices (device_id, customer_id, device_type, device_os, device_ip, created_at)\
VALUES\
(1, 1, 'Mobile', 'Android', '192.168.0.1', NOW()),\
(2, 2, 'Laptop', 'Windows', '192.168.0.2', NOW()),\
(3, 3, 'Tablet', 'iOS', '192.168.0.3', NOW()),\
(4, 4, 'Mobile', 'iOS', '192.168.0.4', NOW()),\
(5, 5, 'Laptop', 'Linux', '192.168.0.5', NOW()),\
(6, 6, 'Mobile', 'Android', '192.168.0.6', NOW()),\
(7, 7, 'Tablet', 'Android', '192.168.0.7', NOW()),\
(8, 8, 'Laptop', 'Windows', '192.168.0.8', NOW()),\
(9, 9, 'Mobile', 'Android', '192.168.0.9', NOW()),\
(10, 10, 'Laptop', 'MacOS', '192.168.0.10', NOW());\
\
INSERT INTO transaction_channels (channel_id, channel_name) VALUES\
(1, 'POS'),\
(2, 'ATM'),\
(3, 'Online'),\
(4, 'Mobile Banking'),\
(5, 'POS'),\
(6, 'ATM'),\
(7, 'Online'),\
(8, 'Mobile Banking'),\
(9, 'POS'),\
(10, 'ATM'),\
(11, 'Online'),\
(12, 'Mobile Banking'),\
(13, 'POS'),\
(14, 'ATM'),\
(15, 'Online'),\
(16, 'Mobile Banking'),\
(17, 'POS'),\
(18, 'ATM'),\
(19, 'Online'),\
(20, 'Mobile Banking');\
\
INSERT INTO transactions (\
    transaction_id, card_id, merchant_id, location_id, device_id, channel_id, amount, currency, transaction_time, status, created_at\
)\
VALUES\
(1, 1, 1, 1, 1, 1, 2500.00, 'INR', '2024-12-15 10:35:00', 'SUCCESS', '2024-12-15 10:36:00'),\
(2, 2, 2, 3, 2, 2, 1200.00, 'INR', '2024-12-15 11:10:00', 'SUCCESS', '2024-12-15 11:12:00'),\
(3, 3, 3, 3, 3, 3, 5600.00, 'INR', '2024-12-15 13:45:00', 'FAILED', '2024-12-15 13:47:00'),\
(4, 4, 4, 4, 4, 4, 1500.00, 'INR', '2024-12-16 09:10:00', 'SUCCESS', '2024-12-16 09:12:00'),\
(5, 5, 5, 2, 5, 5, 700.00, 'INR', '2024-12-16 10:05:00', 'SUCCESS', '2024-12-16 10:06:00'),\
(6, 6, 6, 1, 6, 6, 3500.00, 'INR', '2024-12-16 11:55:00', 'SUCCESS', '2024-12-16 11:56:00'),\
(7, 7, 7, 3, 7, 7, 499.99, 'INR', '2024-12-17 14:25:00', 'SUCCESS', '2024-12-17 14:27:00'),\
(8, 8, 8, 4, 8, 8, 8000.00, 'INR', '2024-12-17 15:15:00', 'SUCCESS', '2024-12-17 15:18:00'),\
(9, 9, 1, 1, 2, 9, 1000.00, 'INR', '2024-12-18 16:05:00', 'SUCCESS', '2024-12-18 16:08:00'),\
(10, 10, 2, 2, 3, 10, 300.00, 'INR', '2024-12-18 18:45:00', 'FAILED', '2024-12-18 18:48:00'),\
(11, 11, 3, 3, 4, 11, 4000.00, 'INR', '2024-12-19 09:30:00', 'SUCCESS', '2024-12-19 09:32:00'),\
(12, 12, 4, 4, 5, 12, 250.00, 'INR', '2024-12-19 10:10:00', 'SUCCESS', '2024-12-19 10:12:00'),\
(13, 13, 5, 2, 6, 13, 600.00, 'INR', '2024-12-19 13:20:00', 'SUCCESS', '2024-12-19 13:22:00'),\
(14, 14, 6, 1, 7, 14, 900.00, 'INR', '2024-12-20 11:45:00', 'SUCCESS', '2024-12-20 11:47:00'),\
(15, 15, 7, 3, 8, 15, 1100.00, 'INR', '2024-12-20 14:15:00', 'SUCCESS', '2024-12-20 14:17:00'),\
(16, 1, 8, 1, 1, 16, 5000.00, 'INR', '2024-12-21 15:30:00', 'SUCCESS', '2024-12-21 15:32:00'),\
(17, 2, 1, 4, 2, 17, 750.00, 'INR', '2024-12-21 16:10:00', 'FAILED', '2024-12-21 16:13:00'),\
(18, 3, 2, 2, 3, 18, 9000.00, 'INR', '2024-12-21 17:45:00', 'SUCCESS', '2024-12-21 17:47:00'),\
(19, 4, 3, 3, 4, 19, 420.00, 'INR', '2024-12-22 10:55:00', 'SUCCESS', '2024-12-22 10:57:00'),\
(20, 5, 4, 4, 5, 20, 150.00, 'INR', '2024-12-22 12:05:00', 'SUCCESS', '2024-12-22 12:07:00');\
\
INSERT INTO fraud_alerts (alert_id, transaction_id, alert_description, alert_type, created_at)\
VALUES\
(1, 3, 'High transaction amount flagged as suspicious', 'Amount Alert', '2024-12-15 14:00:00'),\
(2, 8, 'International transaction detected', 'Location Alert', '2024-12-17 15:30:00'),\
(3, 10, 'Multiple failed attempts in short time', 'Failed Attempts', '2024-12-18 19:00:00'),\
(4, 17, 'Transaction from unusual location', 'Location Alert', '2024-12-21 16:30:00'),\
(5, 18, 'Transaction amount exceeds normal pattern', 'Amount Alert', '2024-12-21 18:00:00');\
\
INSERT INTO risk_scores (score_id, customer_id, score, calculated_at)\
VALUES\
(1, 1, 780, '2024-12-15'),\
(2, 2, 620, '2024-12-15'),\
(3, 3, 590, '2024-12-16'),\
(4, 4, 710, '2024-12-16'),\
(5, 5, 670, '2024-12-16'),\
(6, 6, 750, '2024-12-17'),\
(7, 7, 680, '2024-12-17'),\
(8, 8, 700, '2024-12-18'),\
(9, 9, 740, '2024-12-18'),\
(10, 10, 720, '2024-12-19');\
\
INSERT INTO blacklist (blacklist_id, card_id, reason, added_on)\
VALUES\
(1, 3, 'Card reported lost', '2024-12-15'),\
(2, 8, 'Fraudulent transaction detected', '2024-12-17'),\
(3, 14, 'Exceeded daily transaction limit', '2024-12-18');\
\
INSERT INTO logins (login_id, customer_id, device_id, ip_address, login_time, status)\
VALUES\
(1, 1, 1, '192.168.0.101', '2024-12-15 09:15:00', 'SUCCESS'),\
(2, 2, 2, '192.168.0.102', '2024-12-15 10:00:00', 'SUCCESS'),\
(3, 3, 3, '192.168.0.103', '2024-12-15 11:30:00', 'FAILED'),\
(4, 4, 4, '192.168.0.104', '2024-12-16 08:45:00', 'SUCCESS'),\
(5, 5, 5, '192.168.0.105', '2024-12-16 09:25:00', 'SUCCESS'),\
(6, 6, 6, '192.168.0.106', '2024-12-16 10:15:00', 'FAILED'),\
(7, 7, 7, '192.168.0.107', '2024-12-17 07:55:00', 'SUCCESS'),\
(8, 8, 8, '192.168.0.108', '2024-12-17 08:40:00', 'SUCCESS'),\
(9, 9, 9, '192.168.0.109', '2024-12-18 06:20:00', 'FAILED'),\
(10, 10, 10, '192.168.0.110', '2024-12-18 07:10:00', 'SUCCESS');\
\
INSERT INTO authentication (auth_id, card_id, auth_type, status, created_at)\
VALUES\
(1, 1, 'PIN', 'ACTIVE', '2024-12-15 10:00:00'),\
(2, 1, 'OTP', 'ACTIVE', '2024-12-15 10:05:00'),\
(3, 2, 'PIN', 'ACTIVE', '2024-12-15 11:00:00'),\
(4, 3, 'Biometric', 'ACTIVE', '2024-12-15 12:00:00'),\
(5, 4, 'PIN', 'ACTIVE', '2024-12-15 13:00:00'),\
(6, 5, 'PIN', 'INACTIVE', '2024-12-15 14:00:00'),\
(7, 6, 'Biometric', 'ACTIVE', '2024-12-15 15:00:00'),\
(8, 7, 'PIN', 'ACTIVE', '2024-12-15 16:00:00'),\
(9, 8, 'OTP', 'INACTIVE', '2024-12-15 17:00:00'),\
(10, 9, 'PIN', 'ACTIVE', '2024-12-15 18:00:00'),\
(11, 10, 'Biometric', 'ACTIVE', '2024-12-15 19:00:00'),\
(12, 11, 'PIN', 'INACTIVE', '2024-12-15 20:00:00'),\
(13, 12, 'PIN', 'ACTIVE', '2024-12-15 21:00:00'),\
(14, 13, 'Biometric', 'ACTIVE', '2024-12-15 22:00:00'),\
(15, 14, 'PIN', 'ACTIVE', '2024-12-15 23:00:00');\
\
INSERT INTO limits (limit_id, card_id, daily_limit, credit_limit, created_at)\
VALUES\
(1, 1, 50000.00, 200000.00, NOW()),\
(2, 2, 40000.00, 150000.00, NOW()),\
(3, 3, 30000.00, 100000.00, NOW()),\
(4, 4, 60000.00, 250000.00, NOW()),\
(5, 5, 45000.00, 180000.00, NOW()),\
(6, 6, 55000.00, 220000.00, NOW()),\
(7, 7, 35000.00, 140000.00, NOW()),\
(8, 8, 50000.00, 200000.00, NOW()),\
(9, 9, 60000.00, 250000.00, NOW()),\
(10, 10, 30000.00, 100000.00, NOW()),\
(11, 11, 40000.00, 150000.00, NOW()),\
(12, 12, 35000.00, 120000.00, NOW()),\
(13, 13, 50000.00, 210000.00, NOW()),\
(14, 14, 45000.00, 180000.00, NOW()),\
(15, 15, 60000.00, 250000.00, NOW());}