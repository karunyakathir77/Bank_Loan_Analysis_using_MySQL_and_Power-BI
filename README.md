# Bank_Loan_Analysis_using_MySQL_and_Power-BI
## About
The Bank Loan Analysis Project integrates SQL-based analysis with a dynamic Power BI dashboard to visualize and interpret patterns in loan applications. The project focuses on identifying repayment behaviours, loan preferences, and risk profiles, helping institutions strengthen credit evaluation and market expansion strategies.
## Dataset
- Source: kaggle.com
- Volume: 38,000+ loan records
- Key Fields:
    - Personal & Loan Info: ID, State, Term, Application Type, Emp. Length/Title
    - Loan Details: Grade, Sub-grade, Loan Amount, Purpose, Home Ownership
    - Dates: Issue Date, Payment Dates, Credit Pull Date
    - Financials: Installment, Interest Rate, DTI, Annual Income, Total Payment
    - Status: Loan Status (Current, Fully Paid, Charged Off), Verification Status
## Analysis
* Cleaned, structured, formatted data using MySQL queries
* Performed various aggregations and computations in MySQL and Power BI
* Total Loan count per month and term
* Month-over-month growth rate
* Funded vs. received amount
* Good vs. bad loan classification
* Loan trends by geography, purpose, verification status, and more
* Used Power BI measures (DAX) for interactive KPIs
## Key Questions Addressed
* How many total loan applications were received? What's the monthly trend?
* What is the month-over-month growth in applications?
* What are the total amounts disbursed and received (monthly and overall)?
* Which loan term (36 or 60 months) is more popular and profitable?
* Which states have the highest number of applications?
* Which home ownership status dominates the loan customer base?
* What is the distribution of verified vs. non-verified applications?
* What are the most common loan purposes?
* What's the good vs. bad loan ratio? How do they perform?
* What are the top 10 loan-receiving locations?
## Findings
* Loan Volume: Applications increased steadily throughout the year, especially in Q4.
* Funded vs. Repaid: Total amount received exceeded disbursed amount, indicating low NPAs.
* Good Loans: 86%+ loans are either Fully Paid or Current, reflecting financial stability.
* Loan Term: 36-month loans are more common and generate higher repayment.
* Top States: California and New York lead in loan count.
* Employment Length: Applicants with 10+ years of experience are more reliable in repayments.
* Loan Purpose: Debt consolidation and credit card dominate volume; home and business loans have high disbursement values.
* Home Ownership: Most borrowers are renters.
* Verification: A significant number of applications remain unverified, posing potential risks.
## Strategic Recommendations
* Product Strategy: Prioritize top loan purposes for upselling and customized interest rates.
* Risk Reduction: Implement automated alert systems for early detection of default risk.
* KYC Compliance: Encourage full verification to minimize fraudulent applications.
* Market Expansion: Offer competitive rates in underserved regions to boost penetration.
* Inclusive Lending: Develop tailored loans for diverse income brackets to widen customer base.
* Digital Engagement: Improve customer experience via mobile apps and dashboards for loan tracking and repayment reminders.
## Overall Outcome
This project effectively combines MySQL and Power BI to deliver actionable insights into loan trends, repayment behaviors, and customer segmentation. It highlights strong financial health through a high proportion of good loans, identifies key regions and loan purposes driving growth, and uncovers areas needing attention like KYC compliance. The dashboard enables data-driven decisions to reduce risk, tailor loan products, and support strategic business expansion.
