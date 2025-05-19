SELECT *
FROM bank_transactions
limit 10;

/*Транзакції за типом та містом:*/

SELECT
	"Location",
	"TransactionType",
	COUNT(*) as transaction_count,
	SUM ("TransactionAmount") as total_amount,
	ROUND(AVG ("TransactionAmount")) as avg_amount
FROM bank_transactions
GROUP BY "Location", "TransactionType";

/*Транзакції за віковими групами*/

SELECT
	CASE 
		WHEN "CustomerAge" < 25 THEN '18-24'
		WHEN "CustomerAge" BETWEEN 25 AND 44 THEN '25-44'
		WHEN "CustomerAge" BETWEEN 45 AND 64 THEN '45-64'
		WHEN "CustomerAge" >= 65 THEN '65+'
	END as age_group,
	COUNT (*) as transaction_count,
	SUM ("TransactionAmount") as total_amount,
	ROUND(AVG ("TransactionAmount")) as avg_amount
FROM bank_transactions
GROUP BY age_group;

/*Транзакції за професіями*/

SELECT 
	"CustomerOccupation",
	COUNT (*) as transaction_count,
	SUM ("TransactionAmount") as total_amount,
	ROUND(AVG ("TransactionAmount")) as avg_amount
FROM bank_transactions
GROUP BY "CustomerOccupation";

/*Підозрілі транзакції (високий TransactionDuration або LoginAttempts)*/

SELECT 
    "TransactionID",
    "AccountID",
    "TransactionAmount",
    "TransactionDate",
    "TransactionType",
    "Location",
    "Channel",
    "CustomerAge",
    "CustomerOccupation",
    "TransactionDuration",
    "LoginAttempts"
FROM bank_transactions
WHERE "TransactionDuration" > (SELECT AVG("TransactionDuration") + 2 * STDDEV("TransactionDuration") FROM bank_transactions)
   OR "LoginAttempts" > 3;

 /*Транзакції за каналами*/

 SELECT 
    "Channel",
    COUNT(*) AS transaction_count,
    SUM("TransactionAmount") AS total_amount,
    ROUND(AVG("TransactionAmount")) AS avg_amount
FROM bank_transactions
GROUP BY "Channel";