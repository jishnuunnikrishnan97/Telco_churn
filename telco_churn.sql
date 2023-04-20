CREATE TABLE telco_churn (
  customerID VARCHAR(20) PRIMARY KEY,
  gender VARCHAR(50),
  SeniorCitizen INTEGER,
  Partner VARCHAR(50),
  Dependents VARCHAR(50),
  tenure INTEGER,
  PhoneService VARCHAR(50),
  MultipleLines VARCHAR(50),
  InternetService VARCHAR(50),
  OnlineSecurity VARCHAR(50),
  OnlineBackup VARCHAR(50),
  DeviceProtection VARCHAR(50),
  TechSupport VARCHAR(50),
  StreamingTV VARCHAR(50),
  StreamingMovies VARCHAR(50),
  Contract VARCHAR(50),
  PaperlessBilling VARCHAR(50),
  PaymentMethod VARCHAR(50),
  MonthlyCharges NUMERIC(50, 2),
  TotalCharges NUMERIC(50, 2),
  Churn VARCHAR(10)
);


COPY telco_churn
FROM'C:\Program Files\PostgreSQL\15\data\Importing_data\telco_churn.csv'
WITH DELIMITER ','   
CSV HEADER;

/*Basic analysis of the dataset*/

/*Find the total number of customers who have churned and 
the average monthly charges for customers who have churned and
the average Tenure for customers who have churned*/

SELECT COUNT(*) AS "Total Churned Customers",
		ROUND(AVG(MonthlyCharges)) AS "Average Monthly Charges For Churned",
		ROUND(AVG(tenure)) AS "Average Tenure For Churned"
FROM telco_churn
WHERE churn = 'Yes';

/*Find the distribution of churned customers by contract type*/

SELECT CONTRACT,
		COUNT(*) AS "Count of Churned members acc Contract"
FROM telco_churn
WHERE Churn = 'Yes'
GROUP BY Contract;

/*Find the distribution of churned customers by gender*/

SELECT gender,
		COUNT(*) AS "Count of Churned members acc Gender"
FROM telco_churn
WHERE Churn = 'Yes'
GROUP BY gender;

/*Find the churn rate WRT Gender*/

SELECT 
	gender,
	COUNT(*) AS "Total Number of Customers",
	ROUND(
	COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0/COUNT(*)) 
	AS "Churn Rate"
FROM telco_churn
GROUP BY gender;


/*Find the churn rate WRT Internet Service type*/

SELECT 
	InternetService,
	COUNT(*) AS "Total Number of Customers",
	ROUND(
	COUNT(*) FILTER (WHERE Churn = 'Yes') * 100.0/COUNT(*)) 
	AS "Churn Rate"
FROM telco_churn
GROUP BY InternetService
ORDER BY "Total Number of Customers" DESC;
