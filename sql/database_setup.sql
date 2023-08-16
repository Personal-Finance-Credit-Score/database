-- Create Customer table
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create LoanTypes table
CREATE TABLE LoanTypes (
    type_id SERIAL PRIMARY KEY,
    loan_type VARCHAR(50) NOT NULL
);

-- Create Employment Types table
CREATE TABLE EmploymentTypes (
    type_id SERIAL PRIMARY KEY,
    employment_type VARCHAR(50) NOT NULL
);

-- Create Marital Types table
CREATE TABLE MaritalTypes (
    type_id SERIAL PRIMARY KEY,
    marital_type VARCHAR(50) NOT NULL
);

-- Create Education Types table
CREATE TABLE EducationTypes (
    type_id SERIAL PRIMARY KEY,
    education_level VARCHAR(50) NOT NULL
);

-- Create Gender Types table
CREATE TABLE GenderTypes (
    type_id SERIAL PRIMARY KEY,
    gender VARCHAR(10) NOT NULL
);

-- Create AddressBook table
CREATE TABLE AddressBook (
    address_id SERIAL PRIMARY KEY,
    address_line_1 VARCHAR(200) NOT NULL,
    address_line_2 VARCHAR(200),
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip VARCHAR(20) NOT NULL
);

-- Create Personal Details table with birthdate
CREATE TABLE PersonalDetails (
    personal_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    gender_id INT NOT NULL,
    marital_id INT NOT NULL,
    education_id INT NOT NULL,
    employment_id INT NOT NULL,
    current_address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (gender_id) REFERENCES GenderTypes(type_id),
    FOREIGN KEY (marital_id) REFERENCES MaritalTypes(type_id),
    FOREIGN KEY (education_id) REFERENCES EducationTypes(type_id),
    FOREIGN KEY (employment_id) REFERENCES EmploymentTypes(type_id),
    FOREIGN KEY (current_address_id) REFERENCES AddressBook(address_id)
);

-- Create PreviousAddresses table
CREATE TABLE PreviousAddresses (
    previous_address_id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    personal_id INT NOT NULL,
    FOREIGN KEY (personal_id) REFERENCES PersonalDetails(personal_id),
    FOREIGN KEY (address_id) REFERENCES AddressBook(address_id)
);

-- Create Loan table
CREATE TABLE Loan (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    date_opened date NOT NULL,
    loan_amount DECIMAL(100, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    loan_term INT NOT NULL,
    loan_type_id INT NOT NULL,
    credit_utilization_ratio DECIMAL(5, 2) NOT NULL,
    payment_history DECIMAL(100, 2),
    number_of_payments INT,
    days_late_30 INT,
    days_late_60 INT,
    days_90_plus INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (loan_type_id) REFERENCES LoanTypes(type_id)
);


-- Create CreditInquiries table
CREATE TABLE CreditInquiries (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    address_line_1 VARCHAR(100) NOT NULL,
    address_line_2 VARCHAR(50),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(10) NOT NULL,
    zipcode INT NOT NULL,
    phone_number INT NOT NULL,
    requested_on DATE NOT NULL,
    inquiry_type VARCHAR(10),
    inquiry_removal_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Collection table
CREATE TABLE Collection (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    original_creditor VARCHAR(100) NOT NULL,
    opened DATE NOT NULL,
    closed DATE,
    status VARCHAR(10),
    balance DECIMAL(50, 2) NOT NULL,
    original_amount DECIMAL(50, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create OffersCredit table
CREATE TABLE OffersCredit (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    reward_rate VARCHAR(50) NOT NULL,
    annual_fee INT NOT NULL,
    welcome_bonus INT NOT NULL,
    interest_rate DECIMAL(10, 2) NOT NULL
);

-- Create OffersLoan table
CREATE TABLE OffersLoan (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    interest_rate DECIMAL(10, 2) NOT NULL,
    interest_fee DECIMAL(100, 2) NOT NULL,
    loan_amount INT NOT NULL,
    loan_term INT NOT NULL,
    auto_pay_discount DECIMAL(5, 2) NOT NULL
);

-- Create HomePayment table
CREATE TABLE HomePayment (
	id SERIAL PRIMARY KEY,
	customer_id INT NOT NULL,
	is_rent Boolean NOT NULL,
	monthly_payment decimal(100, 2) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Income Frequency table
CREATE TABLE IncomeFrequency (
    frequency_id SERIAL PRIMARY KEY,
    frequency VARCHAR(20) NOT NULL,
    frequency_digit INT NOT NULL
);

-- Create Income table
CREATE TABLE Income (
    income_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    source VARCHAR(100) NOT NULL,
    amount DECIMAL(100, 2) NOT NULL,
    frequency_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (frequency_id) REFERENCES IncomeFrequency(frequency_id)
);

-- Create a table to store historical credit scores
CREATE TABLE HistoricalCreditScores (
    score_id SERIAL PRIMARY KEY,
    customer_id INT,
    credit_score INT,
    timestamp TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Insert data into MaritalTypes table
INSERT INTO maritaltypes (marital_type)
VALUES
    ('Single'),
    ('Married'),
    ('Divorced'),
    ('Widowed');

-- Insert data into EducationTypes table
INSERT INTO educationtypes (type_id, education_level)
VALUES
    (1, 'High School'),
    (2, 'Bachelor''s Degree'),
    (3, 'Master''s Degree'),
    (4, 'Doctorate/Ph.D. Degree');

-- Insert data into EmploymentTypes table
INSERT INTO employmenttypes (type_id, employment_type)
VALUES
    (1, 'Employed'),
    (0, 'Unemployed'),
    (2, 'Self-Employed');

-- Insert data into LoanTypes table
INSERT INTO loantypes (loan_type)
VALUES
    ('auto-loan'),
    ('student-loan'),
    ('home-loan'),
    ('credit-card-loan');

-- Insert data into GenderTypes table
INSERT INTO GenderTypes (gender)
VALUES
    ('Male'),
    ('Female'),
    ('Other');

-- Insert 20 fake records into OffersCredit table
INSERT INTO OffersCredit (name, reward_rate, annual_fee, welcome_bonus, interest_rate)
SELECT
    'Bank ' || (n + 1) AS name,
    '2% Cash Back' AS reward_rate,
    (n + 1) * 50 AS annual_fee,
    (n + 1) * 50 AS welcome_bonus,
    (n + 1) + 12.5 AS interest_rate
FROM generate_series(0, 19) AS n;

-- Insert 20 fake records into OffersLoan table with calculated interest_fee
INSERT INTO OffersLoan (name, interest_rate, interest_fee, loan_amount, auto_pay_discount, loan_term)
SELECT
    'Bank ' || (n + 1) AS name,
    (n + 1) + 7.5 AS interest_rate,
    ((n * 1000) + 1000) * (((n + 1) + 7.5) / 100) * ((n + 1) + 12) AS interest_fee,
    1000 + (n * 1000) AS loan_amount,
    (n + 1) * 0.1 AS auto_pay_discount,
	(n + 1) + 12 AS loan_term
FROM generate_series(0, 19) AS n;

-- Insert income frequencies
INSERT INTO IncomeFrequency (frequency, frequency_digit)
VALUES
	('Monthly', 12),
	('Quaterly', 4),
	('Yearly', 1);

-- Create a view for calculating DTI ratio
CREATE OR REPLACE VIEW DTIRatioView AS
SELECT
    inc.customer_id,
    ROUND((COALESCE(lp.total_monthly_payment, 0) + COALESCE(hp.total_monthly_payment, 0))) AS total_monthly_debt,
    inc.amount AS income,
    ROUND((COALESCE(lp.total_monthly_payment, 0) + COALESCE(hp.total_monthly_payment, 0)) / inc.amount, 2) AS dti_ratio
FROM
    Income inc
LEFT JOIN (
    SELECT
        customer_id,
        SUM(monthly_payment) AS total_monthly_payment
    FROM
        HomePayment
    GROUP BY
        customer_id
) hp ON inc.customer_id = hp.customer_id
LEFT JOIN (
    SELECT
        customer_id,
        SUM(loan_amount / loan_term) AS total_monthly_payment
    FROM
        Loan
    GROUP BY
        customer_id
) lp ON inc.customer_id = lp.customer_id;