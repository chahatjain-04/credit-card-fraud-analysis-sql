{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 CREATE TYPE card_type_enum AS ENUM ('Credit', 'Debit');\
CREATE TYPE transaction_status AS ENUM ('SUCCESS','FAILED','PENDING');\
CREATE TYPE login_status AS ENUM ('SUCCESS','FAILED');\
CREATE TYPE auth_type AS ENUM('PIN','OTP','Biometric');\
CREATE TYPE authentication_status AS ENUM('ACTIVE','INACTIVE');\
\
CREATE TABLE banks (\
    bank_id INT PRIMARY KEY,\
    bank_name VARCHAR(100) NOT NULL,\
    branch_name VARCHAR(100),\
    branch_code VARCHAR(50) UNIQUE,\
    ifsc_code VARCHAR(20) UNIQUE,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\
);\
CREATE TABLE customers (\
    customer_id INT PRIMARY KEY ,\
    full_name VARCHAR(100) NOT NULL,\
	gender VARCHAR(10),\
    age INT,\
    dob DATE,\
    email VARCHAR(100) UNIQUE,\
    phone VARCHAR(20),\
    address VARCHAR(255),\
    bank_id INT,\
    credit_score INT,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (bank_id) REFERENCES banks(bank_id)\
);\
CREATE TABLE cards (\
    card_id INT PRIMARY KEY,\
    customer_id INT,\
    bank_id INT,\
    card_number VARCHAR(20) UNIQUE,\
    expiry_date DATE,\
    cvv INT,\
    card_limit DECIMAL(10,2),\
    is_active BOOLEAN DEFAULT TRUE,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
	card_type card_type_enum,\
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),\
    FOREIGN KEY (bank_id) REFERENCES banks(bank_id)\
);\
CREATE TABLE merchants (\
    merchant_id INT PRIMARY KEY,\
    merchant_name VARCHAR(100) NOT NULL,\
    category VARCHAR(50),\
    city VARCHAR(50),\
    country VARCHAR(50),\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\
);\
CREATE TABLE devices (\
    device_id INT PRIMARY KEY,\
    customer_id INT,\
    device_type VARCHAR(50),\
    device_os VARCHAR(50),\
    device_ip VARCHAR(50),\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)\
);\
CREATE TABLE locations (\
    location_id INT PRIMARY KEY,\
    city VARCHAR(50),\
    state VARCHAR(50),\
    country VARCHAR(50),\
	address VARCHAR(255),\
    latitude DECIMAL(9,6),\
    longitude DECIMAL(9,6)\
);\
CREATE TABLE transaction_channels (\
    channel_id INT PRIMARY KEY,\
    channel_name VARCHAR(50)\
);\
CREATE TABLE transactions (\
    transaction_id INT PRIMARY KEY,\
    card_id INT,\
    merchant_id INT,\
    location_id INT,\
    device_id INT,\
    channel_id INT,\
    amount DECIMAL(10,2),\
    currency VARCHAR(10),\
    transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    status transaction_status,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (card_id) REFERENCES cards(card_id),\
    FOREIGN KEY (merchant_id) REFERENCES merchants(merchant_id),\
    FOREIGN KEY (location_id) REFERENCES locations(location_id),\
    FOREIGN KEY (device_id) REFERENCES devices(device_id),\
    FOREIGN KEY (channel_id) REFERENCES transaction_channels(channel_id)\
);\
CREATE TABLE fraud_alerts (\
    alert_id INT PRIMARY KEY,\
    transaction_id INT,\
    alert_description VARCHAR(255),\
	alert_type VARCHAR(50),\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)\
);\
CREATE TABLE risk_scores (\
    score_id INT PRIMARY KEY,\
    customer_id INT,\
    score INT,\
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)\
);\
CREATE TABLE blacklist (\
    blacklist_id INT PRIMARY KEY,\
    card_id INT,\
    reason VARCHAR(255),\
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (card_id) REFERENCES cards(card_id)\
);\
CREATE TABLE logins (\
    login_id INT PRIMARY KEY,\
    customer_id INT,\
    device_id INT,\
    ip_address VARCHAR(50),\
	login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    status login_status,\
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),\
    FOREIGN KEY (device_id) REFERENCES devices(device_id)\
);\
CREATE TABLE authentication (\
    auth_id INT PRIMARY KEY,\
    card_id INT,\
    auth_type auth_type,\
    status authentication_status,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (card_id) REFERENCES cards(card_id)\
);\
CREATE TABLE limits (\
    limit_id INT PRIMARY KEY,\
    card_id INT,\
    daily_limit DECIMAL(10,2),\
    credit_limit DECIMAL(10,2),\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (card_id) REFERENCES cards(card_id)\
);}