------ POOR DTI -------

INSERT INTO Customer (customer_id, username, password, email)
VALUES (1, 'santiagosuzanne', 'password', 'johnwang@yahoo.com');

INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (1, 1, 9241.47, 3.04, 49, 3, 0.55, 4171.38, 22, 2, 0, 0, '2021-10-25');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (2, 1, 1787.15, 2.85, 19, 4, 0.61, 693.6, 7, 1, 2, 1, '2023-01-18');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (3, 1, 39692.26, 12.27, 17, 1, 0.82, 7000.56, 3, 2, 2, 1, '2023-05-18');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (5, 1, 5175.55, 5.26, 45, 3, 0.98, 113.78, 1, 1, 1, 1, '2023-07-17');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (8, 1, 42831.6, 10.27, 16, 4, 0.36, 27539.95, 10, 1, 1, 1, '2022-10-20');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (9, 1, 46195.1, 4.41, 17, 2, 0.07, 43070.22, 16, 1, 1, 1, '2022-04-23');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (13, 1, 10326.73, 10.0, 21, 1, 0.77, 2353.32, 5, 1, 0, 0, '2023-03-19');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (16, 1, 17545.38, 8.12, 51, 2, 0.18, 14471.99, 42, 3, 2, 0, '2020-03-04');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (18, 1, 24985.84, 2.39, 52, 3, 0.79, 5337.55, 11, 3, 1, 0, '2022-09-20');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (19, 1, 6043.53, 13.56, 12, 1, 0.27, 4428.18, 9, 3, 0, 0, '2022-11-19');
INSERT INTO Loan (loan_id, customer_id, loan_amount, interest_rate, loan_term, loan_type_id, credit_utilization_ratio, amount_paid, number_of_payments, days_late_30, days_late_60, days_90_plus, date_opened) VALUES (20, 1, 29075.23, 4.82, 29, 2, 0.5, 14500.81, 14, 1, 1, 1, '2022-06-22');


INSERT INTO PersonalDetails (customer_id, first_name, last_name, birthdate, gender_id, marital_id, education_id, current_address_id)
VALUES
    (1, 'Michael', 'Johnson', '1938-01-22', 1, 2, 3, 1);


INSERT INTO HomePayment (customer_id, is_rent, monthly_payment)
VALUES
	(1, False, 2000);


INSERT INTO Employment (address_line_1, address_line_2, city, state, zipcode, employment_type_id, name) 
VALUES 
('10971 Franklin Lakes', 'None', 'New Ryanborough', 'MS', '32366', 1, 'Lime Apple LLC');



INSERT INTO Income (customer_id, source, amount, frequency_id, employment_id)
VALUES
	(1, 'full-time', 20000, 1, 1);


-- Assuming today's date is '2023-08-03'
-- Insert historical credit scores for customer 1 for 24 months
WITH CreditScoreData AS (
    SELECT
        1 AS customer_id,
        ROUND(RANDOM() * (850 - 300) + 300) AS credit_score,
        (CURRENT_DATE - INTERVAL '1 month' * n) AS timestamp
    FROM
        generate_series(0, 23) AS n
)
INSERT INTO HistoricalCreditScores (customer_id, credit_bureau, credit_score, timestamp)
SELECT
    csd.customer_id,
    bureaus.credit_bureau,
    csd.credit_score,
    csd.timestamp
FROM
    CreditScoreData csd
CROSS JOIN
    (VALUES ('Transunion'), ('Equifax'), ('Experian')) AS bureaus(credit_bureau);




