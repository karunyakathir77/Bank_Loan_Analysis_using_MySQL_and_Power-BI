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

-- Retrieved the total number of loan applications submitted:
USE bank_loan_dB
SELECT COUNT(id) as "Total Loan Applications" FROM financial_loan;

-- Extracted the no. of loan applications submitted each month, ordered chronologically by month:
SELECT
  MONTH(issue_date) as "Month Number",
  MONTHNAME(issue_date) as "Months",
  COUNT(id) as "Loan Count"
FROM financial_loan
GROUP BY month(issue_date), monthname(issue_date)
ORDER BY month(issue_date);

-- Calculated the Month-over-Month (MoM) Growth Rate in loan volume:
WITH MonthlyLoanData AS(
  SELECT
    MONTH(issue_date) as month_num,
		MONTHNAME(issue_date) as months,
    COUNT(id) as Loan_Count
  FROM financial_loan
	GROUP BY month(issue_date), monthname(issue_date)
	ORDER BY month(issue_date)
)
SELECT
	month_num,
  months,
  Loan_Count,
	LAG(Loan_Count) OVER (ORDER BY month_num) as Prev_Month_Loan_Count,
  ROUND(((Loan_Count - LAG(Loan_Count) OVER (ORDER BY month_num))/LAG(Loan_Count) OVER (ORDER BY month_num))*100,2) as Growth_Rate
FROM MonthlyLoanData
ORDER BY month_num;

-- Computed the total disbursed amount for the year:
SELECT SUM(loan_amount) as "Total Funded Amount" FROM financial_loan;

-- Displayed the disbursed amount on a monthly basis:
SELECT
  month(issue_date) as month_num,
  MONTHNAME(issue_date) as months,
  SUM(loan_amount) as "Total Funded Amount"
FROM financial_loan
GROUP BY month(issue_date), monthname(issue_date)
ORDER BY month(issue_date);

-- Computed the total amount repaid by borrowers:
SELECT SUM(total_payment) as "Total Amount Received" FROM financial_loan;

-- Computed the total amount received on a monthly basis:
SELECT
  month(issue_date) as month_num,
  MONTHNAME(issue_date) as months,
  SUM(total_payment) as "Total Amount Received"
FROM financial_loan
GROUP BY month(issue_date), monthname(issue_date)
ORDER BY month(issue_date);

-- Calculate the average interest rate:
SELECT round(avg(int_rate)*100,2) as Average_ITR FROM financial_loan;

-- Analyzed the Percentage of Good Loans (GL):
SELECT
  ROUND((COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN id END))/COUNT(id)*100,3) as GL
FROM financial_loan;
-- Retrieved the Total Number of Good Loan Applications:
SELECT COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN id END) as GL_Applications
FROM financial_loan; -- (OR)
SELECT COUNT(id) as GLApplications FROM financial_loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";
-- Calculated the Total Disbursed Amount for Good Loans:
SELECT SUM(loan_amount) as GL_funded_amt FROM financial_loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";
-- Computed the Total Received Amount from Good Loans:
SELECT SUM(total_payment) as GL_ReceivedAmt FROM financial_loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

-- Analyzed the Percentage of Bad Loans (BL):
SELECT 
  ROUND((COUNT(CASE WHEN loan_status = "Charged Off" THEN id END))/COUNT(id)*100,3) as BL
FROM financial_loan;
-- Retrieved the Total Number of Bad Loan Applications:
SELECT COUNT(id) as BLApplications FROM financial_loan
WHERE loan_status = "Charged Off";
-- Calculated the Total Disbursed Amount for Bad Loans:
SELECT SUM(loan_amount) as BL_funded_amt FROM financial_loan
WHERE loan_status = "Charged Off";
-- Computed the Total Received Amount from Bad Loans:
SELECT SUM(total_payment) as BL_ReceivedAmt FROM financial_loan
WHERE loan_status = "Charged Off";

-- Overview of the Loan Status Grid:
SELECT
  loan_status,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received,
  ROUND(AVG(int_rate)*100,3) as Interest_Rate,
  ROUND(AVG(dti)*100,3) as DTI
FROM financial_loan
GROUP BY loan_status;

-- Analyzed the Monthly Loan Count and Disbursed Amount by Loan Status:
SELECT
  MONTH(issue_date) as "Month No.",
  MONTHNAME(issue_date) as "Months",
  COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) AS Charged_Off,
  SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amount END) AS
  Total_ChargedOff_Funded_Amount,
  COUNT(CASE WHEN loan_status = 'Fully Paid' THEN id END) AS Fully_Paid,
  SUM(CASE WHEN loan_status = 'Fully Paid' THEN loan_amount END) AS
  Total_FullyPaid_Funded_Amount,
  COUNT(CASE WHEN loan_status = 'Current' THEN id END) AS "Current",
  SUM(CASE WHEN loan_status = 'Current' THEN loan_amount END) AS
  Total_Current_Funded_Amount
FROM financial_loan
GROUP BY month(issue_date), monthname(issue_date)
ORDER BY month(issue_date);

-- Analyzed the Monthly Loan Count, Disbursed Amount and Received Amount:
SELECT
  MONTH(issue_date) as "Month No.",
  MONTHNAME(issue_date) as "Months",
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Received_Amount
FROM financial_loan
GROUP BY month(issue_date), monthname(issue_date)
ORDER BY month(issue_date);

-- Analyzed Loan Count, Disbursed Amount and Received Amount by Location:
SELECT
  address_state,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received
FROM financial_loan
GROUP BY address_state
ORDER BY address_state;

-- Identified the Top 10 Locations with Highest Loan Counts:
SELECT address_state, COUNT(id) as Loan_Count
FROM financial_loan
GROUP BY address_state
ORDER BY count(id) DESC
LIMIT 10;

-- Analyzed Loan Count, Disbursed Amount and Received Amount by Term Loan:
SELECT 
  term,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received
FROM financial_loan
GROUP BY term
ORDER BY term;

-- Analyzed Loan Count, Disbursed Amount and Received Amount by Employee Length:
SELECT
  emp_length,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length;

-- Analyzed Loan Count, Disbursed Amount and Received Amount by Loan Purpose:
SELECT
  purpose,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;

-- Identified the Top 5 Loan Purposes with the Highest Loan Counts, Excluding Non-Specific Categories:
SELECT purpose, COUNT(id) as Loan_Count
FROM financial_loan
WHERE purpose NOT IN ("credit card", "Debt consolidation", "other", "major purchase")
GROUP BY purpose
ORDER BY COUNT(id) DESC
LIMIT 5;

-- Analyzed Loan Count, Disbursed Amount and Received Amount by Home Ownership:
SELECT
  home_ownership,
  COUNT(id) as Loan_Count,
  SUM(loan_amount) as Total_Funded_Amount,
  SUM(total_payment) as Total_Amount_Received
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;

-- Identified the Verification Status of Loan Applications:
SELECT verification_status, COUNT(id) as Loan_Count
FROM financial_loan
GROUP BY verification_status;
