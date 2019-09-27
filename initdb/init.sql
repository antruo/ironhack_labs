START TRANSACTION;

# Create database
CREATE DATABASE IF NOT EXISTS bank;

# Create tables
CREATE TABLE IF NOT EXISTS bank.account (
	account_id INT PRIMARY KEY,
	district_id INT,
	frequency TEXT,
	`date` INT 
);

CREATE TABLE IF NOT EXISTS bank.card (
	card_id INT,
	disp_id INT,
	type TEXT,
	issued TEXT
);

CREATE TABLE IF NOT EXISTS bank.client (
	client_id INT,
	birth_number INT,
	district_id INT
);

CREATE TABLE IF NOT EXISTS bank.disp (
	disp_id INT,
	client_id INT,
	account_id INT,
	`type` TEXT
);

CREATE TABLE IF NOT EXISTS bank.district (
	A1 INT,
	A2 TEXT,
	A3 TEXT,
	A4 INT,
	A5 INT,
	A6 INT,
	A7 INT,
	A8 INT,
	A9 INT,
	A10 FLOAT,
	A11 INT,
	A12 FLOAT,
	A13 FLOAT,
	A14 INT,
	A15 INT,
	A16 INT
);

CREATE TABLE IF NOT EXISTS bank.loan (
	loan_id INT,
	account_id INT,
	`date` INT,
	amount INT,
	duration INT,
	payments FLOAT,
	status TEXT
);

CREATE TABLE IF NOT EXISTS bank.order (
	order_id INT,
	account_id INT,
	bank_to TEXT,
	account_to INT,
	amount FLOAT,
	k_symbol TEXT
);

CREATE TABLE IF NOT EXISTS bank.trans (
	trans_id INT,
	account_id INT,
	`date` INT,
	type TEXT,
	operation TEXT,
	amount FLOAT,
	balance FLOAT,
	k_symbol TEXT,
	bank TEXT,
	account INT
);

# Load data
LOAD DATA INFILE '/initdb/datasets/account.asc' 
	INTO TABLE bank.account
	FIELDS TERMINATED BY ';'
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/card.asc' 
	INTO TABLE bank.card
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/client.asc' 
	INTO TABLE bank.client
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/disp.asc' 
	INTO TABLE bank.disp
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/district.asc' 
	IGNORE INTO TABLE bank.district
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/loan.asc' 
	INTO TABLE bank.loan
	FIELDS TERMINATED BY ';'
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/order.asc' 
	INTO TABLE bank.order
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

LOAD DATA INFILE '/initdb/datasets/trans.asc' 
	IGNORE INTO TABLE bank.trans
	FIELDS TERMINATED BY ';' 
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 ROWS;

COMMIT;
