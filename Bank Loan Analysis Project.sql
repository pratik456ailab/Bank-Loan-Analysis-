-- Bank Loan Analysis 

select * from bank_loan_data

-- A.	BANK LOAN REPORT 
--KPI’s:
--Total Loan Applications
select count( id ) as Total_Loan_Application from bank_loan_data 

--MTD Loan Applications 
select count(id) as MTD_Total_Loan_Applications from  bank_loan_data 
where MONTH (issue_date) = 12 and YEAR (issue_date)=2021 

--PMTD Loan Applications
select count(id) as PMTD_Total_Loan_Applications from bank_loan_data 
where MONTH(issue_date) = 11 and YEAR(issue_date) = 2021

-- (MTD- PMTD)/PMTD

--Total Funded Amount
select sum(loan_amount) as Total_Funded_Amount From  bank_loan_data

--MTD Total Funded Amount
select sum(loan_amount) as MID_Total_Funded_Amount from bank_loan_data 
where MONTH (issue_date) = 12 and YEAR(issue_date) = 2021

--PMTD Total Funded Amount
select sum(loan_amount) as PMID_Total_Funded_Amount from bank_loan_data 
where MONTH (issue_date) = 11 and YEAR(issue_date) = 2021

--Total Amount Received
select sum(total_payment ) as Total_Amount_Received from bank_loan_data 

--MTD Total Amount Received
select sum(total_payment) as MTD_Total_Amount_Received from bank_loan_data 
where MONTH (issue_date) = 12 and YEAR (issue_date) =2021

--PMTD Total Amount Received
select sum(total_payment) as PMTD_Total_Amount_Received from bank_loan_data 
where MONTH (issue_date) = 11 and YEAR (issue_date) =2021

-- Average Interest Rate 
select AVG(int_rate) as Avg_Interest_Rate from bank_loan_data 
select AVG(int_rate)*100 as Avg_Interest_Rate from bank_loan_data 
select ROUND(AVG(int_rate),4)*100 as Avg_Interest_Rate from bank_loan_data 

--MTD Average Interest
select ROUND(AVG(int_rate),4)*100 as MTD_Avg_Interest_Rate from  bank_loan_data 
WHERE MONTH (issue_date)= 12 and YEAR (issue_date) = 2021

--PMTD Average Interest
select ROUND(AVG(int_rate),4)*100 as MTD_Avg_Interest_Rate from  bank_loan_data 
WHERE MONTH (issue_date)= 11 and YEAR (issue_date) = 2021

--Avg DTI
select ROUND(AVG(dti),4)*100 as Avg_DTI from  bank_loan_data

--MTD Avg DTI
select ROUND(AVG(dti),4)*100 as MTD_Avg_DTI from  bank_loan_data
where MONTH(issue_date) = 12 and YEAR(issue_date) =2021 

--PMTD Avg DTI
select ROUND(AVG(dti),4)*100 as PMTD_Avg_DTI from  bank_loan_data
where MONTH(issue_date) = 11 and YEAR(issue_date) =2021 

--GOOD LOAN ISSUED

--Good Loan Percentage
select 
(COUNT(case when loan_status = 'Fully Paid' or loan_status = 'Current' Then id END)*100)
/COUNT(id) as Good_Loan_Percentage
From bank_loan_data 

--Good Loan Applications
select count(id) as Good_Loan_Application from bank_loan_data 
where loan_status = 'Fully Paid' or loan_status ='Current'

--Good Loan Funded Amount
select sum(loan_amount) as Good_Loan_Funded_Amount From bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

--Good Loan Amount Received
select sum(total_payment) as Good_Loan_Received_amount from bank_loan_data 
where loan_status = 'Fully Paid' or loan_status = 'Current'

--BAD LOAN ISSUED 
--Bad Loan Percentage
select (count(case when loan_status = 'Charged Off' then id end ) * 100.0)/
count(id) as Bad_Loan_Percentage 
from bank_loan_data 

--Bad Loan Applications
select count(id) as Bad_Loan_Application from bank_loan_data
where loan_status = 'Charged Off'

--Bad Loan Funded Amount 
select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data 
where loan_status = 'Charged Off'

--Bad Loan Amount Received
select sum(total_payment) as Bad_Loan_Amount_Received from bank_loan_data 
where loan_status = 'Charged Off' 


--LOAN STATUS

select 
      loan_status ,
	  count(id) as Total_Loan_Applications,
	  sum(total_payment) as Total_Amount_Received,
	  sum(loan_amount) as Total_Funded_Amount,
	  AVG(int_rate * 100) as Intrest_Rate ,
	  AVG(dti *100) as DTI 
	  from
	  bank_loan_data 
	  group by 
	  loan_status 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--B. BANK LOAN REPORT | OVERVIEW

--MONTH

SELECT
    DATENAME(MONTH, issue_date) AS Month_Name ,
	COUNT(id) as Total_Loan_Applications ,
	SUM(loan_amount) as Total_Funded_Amount ,
	SUM(total_payment) as Total_Received_Amount 
FROM bank_loan_data 
GROUP BY  DATENAME(MONTH, issue_date)
ORDER BY  DATENAME(MONTH, issue_date)DESC

SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--STATE
select 
     address_state ,
	 count(id) as Total_Loan_Application ,
	 sum(loan_amount) as Total_Funded_Amount ,
	 sum(total_payment) as Total_Received_Amount 
From bank_loan_data 
group by address_state 
order by address_state 

select 
     address_state ,
	 count(id) as Total_Loan_Application ,
	 sum(loan_amount) as Total_Funded_Amount ,
	 sum(total_payment) as Total_Received_Amount 
From bank_loan_data 
group by address_state 
order by sum(loan_amount) desc

select 
     address_state ,
	 count(id) as Total_Loan_Application ,
	 sum(loan_amount) as Total_Funded_Amount ,
	 sum(total_payment) as Total_Received_Amount 
From bank_loan_data 
group by address_state 
order by count(id) desc

--TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

--EMPLOYEE LENGTH 
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--HOME OWNERSHIP 
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade ='A' AND address_state ='CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC

--See the results when we hit the Grade A in the filters for dashboards. 
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose




