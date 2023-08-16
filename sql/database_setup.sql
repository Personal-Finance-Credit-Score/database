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
    zipcode INT NOT NULL
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
    current_address_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (gender_id) REFERENCES GenderTypes(type_id),
    FOREIGN KEY (marital_id) REFERENCES MaritalTypes(type_id),
    FOREIGN KEY (education_id) REFERENCES EducationTypes(type_id),
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
    amount_paid DECIMAL(100, 2),
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

-- Create Employment table
CREATE TABLE Employment (
    employment_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address_line_1 VARCHAR(100) NOT NULL,
    address_line_2 VARCHAR(10),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(10) NOT NULL,
    zipcode INT NOT NULL,
    employment_type_id INT NOT NULL,
    FOREIGN KEY (employment_type_id) REFERENCES EmploymentTypes(type_id)
);


-- Create Income table
CREATE TABLE Income (
    income_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    source VARCHAR(100) NOT NULL,
    amount DECIMAL(100, 2) NOT NULL,
    frequency_id INT NOT NULL,
    employment_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (frequency_id) REFERENCES IncomeFrequency(frequency_id),
    FOREIGN KEY (employment_id) REFERENCES Employment(employment_id)
);

-- Create a table to store historical credit scores
CREATE TABLE HistoricalCreditScores (
    score_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    credit_bureau VARCHAR(50) NOT NULL,
    credit_score INT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
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


-- Create a view for Average Credit Score formula
CREATE VIEW AverageCreditScoresView AS
SELECT
    l.customer_id,
    ROUND(AVG(
        (
            (inc.amount / 10000) * 0.4 +             -- Income contributes 40%
            CASE WHEN lt.loan_type = 'credit-card-loan'
                THEN (l.loan_amount / 1000) * 0.3 -- Credit limit contributes 30%
                ELSE (l.loan_amount / 1000) * 0.3 -- Loan amount contributes 30%
            END +
            (1 - ((COALESCE(l.days_late_30, 0)/30) + (COALESCE(l.days_late_60, 0)/60) + (COALESCE(l.days_90_plus, 0) / 90))) * 0.1 -- Payment delay contributes 10%
        ) * 100
    )) AS avg_credit_score
FROM
    Loan l
JOIN
    Income inc ON l.customer_id = inc.customer_id
JOIN
    LoanTypes lt ON l.loan_type_id = lt.type_id
GROUP BY
    l.customer_id;


CREATE OR REPLACE VIEW LandingPageView AS
WITH TransunionScores AS (
    SELECT DISTINCT ON (customer_id) customer_id, credit_score AS score
    FROM HistoricalCreditScores
    WHERE credit_bureau = 'Transunion'
    ORDER BY customer_id, timestamp DESC
),
EquifaxScores AS (
    SELECT DISTINCT ON (customer_id) customer_id, credit_score AS score
    FROM HistoricalCreditScores
    WHERE credit_bureau = 'Equifax'
    ORDER BY customer_id, timestamp DESC
),
ExperianScores AS (
    SELECT DISTINCT ON (customer_id) customer_id, credit_score AS score
    FROM HistoricalCreditScores
    WHERE credit_bureau = 'Experian'
    ORDER BY customer_id, timestamp DESC
)
SELECT
    l.customer_id,
    ts.score AS transunion_score,
    es.score AS equifax_score,
    xs.score AS experian_score,
    SUM(CASE WHEN l.amount_paid IS NOT NULL THEN (l.loan_amount - l.amount_paid) ELSE l.loan_amount END) AS total_debt,
    ROUND(SUM(l.credit_utilization_ratio) / COUNT(l.loan_id), 2) AS credit_usage,
    0 AS derogatory_marks,
    ROUND(AVG(EXTRACT(MONTH FROM AGE(CURRENT_DATE, l.date_opened))), 2) AS credit_age_months,
    COUNT(ci.id) AS hard_inquiries,
    (COALESCE(SUM(l.days_late_30), 0) + COALESCE(SUM(l.days_late_60), 0) + COALESCE(SUM(l.days_90_plus), 0)) / NULLIF(SUM(l.number_of_payments), 0) AS payment_history,
    ROUND(SUM(CASE WHEN l.loan_type_id = 4 THEN l.credit_utilization_ratio ELSE 0 END) / NULLIF(COUNT(CASE WHEN l.loan_type_id = 4 THEN 1 END), 0), 2) AS credit_card_use,
    COUNT(l.loan_id) AS total_accounts
FROM
    Loan l
LEFT JOIN TransunionScores ts ON l.customer_id = ts.customer_id
LEFT JOIN EquifaxScores es ON l.customer_id = es.customer_id
LEFT JOIN ExperianScores xs ON l.customer_id = xs.customer_id
LEFT JOIN CreditInquiries ci ON l.customer_id = ci.customer_id
GROUP BY
    l.customer_id, ts.score, es.score, xs.score;


CREATE OR REPLACE VIEW EmploymentInfoView AS
SELECT *
FROM Employment e
INNER JOIN Income inc ON e.employment_id = inc.employment_id








INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (1, '421 Roger Street Apt. 479', 'None', 'Fernandezmouth', 'PR', '91047');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (2, '50626 Susan Mountain', 'Apt. 374', 'West Williamland', 'OR', '75920');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (3, '7449 Hanna Neck', 'None', 'West Annaland', 'NC', '08277');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (4, '06353 Roberson Bridge', 'Suite 562', 'Jonesland', 'NE', '56126');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (5, '462 Castro Underpass Suite 497', 'None', 'Webbburgh', 'DC', '56405');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (6, '9419 Jacqueline Roads', 'Apt. 689', 'Hartmanhaven', 'VT', '83936');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (7, '9503 Christopher Valleys Apt. 532', 'Suite 294', 'Cassandraside', 'SC', '19368');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (8, '7851 Jacqueline Stravenue', 'None', 'Hudsonville', 'MH', '44096');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (9, '662 Smith Run Suite 568', 'Suite 512', 'Donaldshire', 'NH', '28280');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (10, '46387 Gutierrez Brook', 'None', 'East Amber', 'ND', '75899');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (11, '999 Veronica Manor', 'Apt. 485', 'Carlland', 'WI', '25537');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (12, '0401 Russell Station Suite 214', 'Suite 589', 'Aliciamouth', 'LA', '63663');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (13, '23267 Robert Point', 'None', 'Sheppardport', 'AK', '75905');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (14, '937 David Village', 'Suite 753', 'Lake John', 'HI', '66282');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (15, '90634 West Gardens Apt. 971', 'Apt. 846', 'Jamiefort', 'GA', '98159');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (16, '157 John Spurs', 'None', 'Lake Julialand', 'AL', '37686');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (17, '797 Kevin Isle Apt. 199', 'Apt. 391', 'North Aaronfort', 'NH', '49324');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (18, '8328 Cannon Mews Suite 568', 'None', 'Lindseyberg', 'RI', '27868');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (19, '85945 William Greens', 'Apt. 065', 'Port Glennland', 'WI', '62001');
INSERT INTO AddressBook (address_id, address_line_1, address_line_2, city, state, zipcode) VALUES (20, '10971 Franklin Lakes', 'None', 'New Ryanborough', 'MS', '32366');
