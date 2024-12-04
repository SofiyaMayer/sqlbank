CREATE DATABASE bank_transactions;
USE bank_transactions;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    address VARCHAR(100),
    latitude DECIMAL(10, 2),
    longitude DECIMAL(10, 2),
    per_capita_income VARCHAR(10),
    yearly_income VARCHAR(10),
    total_debt VARCHAR(10),
    credit_score INT,
    num_credit_cards INT
);

CREATE TABLE MCC_Codes (
    mcc_id INT PRIMARY KEY,
    description VARCHAR(1000)
);

CREATE TABLE Merchants (
    merchant_id INT PRIMARY KEY,
    merchant_city VARCHAR(50),
    merchant_state VARCHAR(50),
    zip INT,
    mcc INT,
    FOREIGN KEY (mcc) REFERENCES MCC_Codes(mcc_id),
);

CREATE TABLE Cards (
    card_id INT PRIMARY KEY,
    client_id INT,
    card_brand VARCHAR(20),
    card_type VARCHAR(20),
    card_number VARCHAR(30),
    expires DATE,
    cvv INT,
    has_chip VARCHAR(3),
    num_cards_issued INT,
    credit_limit DECIMAL(10, 2),
    acct_open_date DATE,
    year_pin_last_changed INT,
    card_on_dark_web VARCHAR(3),
    FOREIGN KEY (client_id) REFERENCES Users(user_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    date varchar(50),
    client_id INT,
    card_id INT,
    merchant_id INT,
    amount DECIMAL(10, 2),
    use_chip VARCHAR(3),
    mcc INT,
    errors VARCHAR(50),
    is_fraud VARCHAR(3),
    FOREIGN KEY (client_id) REFERENCES Users(user_id),
    FOREIGN KEY (card_id) REFERENCES Cards(card_id),
    FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id)
);

