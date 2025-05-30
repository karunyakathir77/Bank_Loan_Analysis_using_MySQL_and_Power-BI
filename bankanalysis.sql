-- Created a Database called bank_loan_dB and then imported .csv file under the bank_loan_dB:
CREATE DATABASE bank_loan_dB;
-- Modified the Data Type of respective columns:
USE bank_loan_dB;
ALTER TABLE financial_loan 
ADD PRIMARY KEY(id),
MODIFY COLUMN address_state VARCHAR(50),
MODIFY COLUMN application_type VARCHAR(50),
MODIFY COLUMN emp_length VARCHAR(50),
MODIFY COLUMN emp_title VARCHAR(100),
MODIFY COLUMN grade VARCHAR(50),
MODIFY COLUMN home_ownership VARCHAR(50),
MODIFY COLUMN loan_status VARCHAR(50),
MODIFY COLUMN purpose VARCHAR(50),
MODIFY COLUMN sub_grade VARCHAR(50),
MODIFY COLUMN term VARCHAR(50),
MODIFY COLUMN verification_status VARCHAR(50),
MODIFY COLUMN annual_income float,
MODIFY COLUMN dti float,
MODIFY COLUMN installment float,
MODIFY COLUMN int_rate float;
-- Modified the Text to Date Data Type using str_to_date function:
ALTER TABLE financial_loan;
UPDATE financial_loan
SET issue_date = str_to_date(issue_date, '%d-%m-%Y');
SET last_payment_date = str_to_date(last_payment_date, '%Y-%m-%d');
SET next_payment_date = str_to_date(next_payment_date, '%d-%m-%Y');
-- shows ERROR so created a new column and pasted all the values from the original column to the new column:
ALTER TABLE financial_loan
ADD COLUMN new_last_credit_pull_date date;
UPDATE financial_loan
SET new_last_credit_pull_date = str_to_date(last_credit_pull_date, '%d-%m-%Y'); -- error so created a new column

ALTER TABLE financial_loan
MODIFY COLUMN issue_date date,
MODIFY COLUMN last_payment_date date,
MODIFY COLUMN next_payment_date date,
DROP COLUMN last_credit_pull_date,
CHANGE new_last_credit_pull_date last_credit_pull_date DATE;
-- data types are changed accordingly
