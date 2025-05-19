/*Перевіряємо назви колонок і типи даних в колонках*/

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'bank_transactions';

/*Перегляд перших записів*/

SELECT *
FROM bank_transactions
LIMIT 10;


/*Перевірка пропущених значень: Перевіряємо чи є записи з NULL*/

SELECT *
FROM bank_transactions
WHERE 'TransactionID' IS NULL
   OR 'AccountID' IS NULL
   OR 'TransactionAmount' IS NULL
   OR 'TransactionDate' IS NULL
   OR 'TransactionType' IS NULL
   OR 'Location' IS NULL
   OR 'DeviceID' IS NULL
   OR 'IP Adress' IS NULL
   OR 'MerchantID' IS NULL
   OR 'Channel' IS NULL
   OR 'CustomerAge' IS NULL
   OR 'CustomerOccupation' IS NULL
   OR 'TransactionDuration' IS NULL
   OR 'LoginAttempts' IS NULL
   OR 'AccountBalance' IS NULL
   OR 'PreviousTransactionDate' IS NULL;

/*Видалення дублікатів: Перевіряємо чи є дублікати в колонці TransactionID (в інших можуть бути дублікати)*/

SELECT 
	"TransactionID", 
	COUNT(*) AS count
FROM bank_transactions
GROUP BY  "TransactionID"
HAVING COUNT(*) > 1
ORDER BY count DESC;

/*Перевірка аномалій, шляхом визначення min та max значень в числових та дата колонках*/

SELECT
    MAX("TransactionAmount") AS max_amount,
    MIN("TransactionAmount") AS min_amount,
    MAX("TransactionDate") AS max_date,
    MIN("TransactionDate") AS min_date,
    MAX("CustomerAge") AS max_age,
    MIN("CustomerAge") AS min_age,
    MAX("TransactionDuration") AS max_duration,
    MIN("TransactionDuration") AS min_duration,
    MAX("LoginAttempts") AS max_attempts,
    MIN("LoginAttempts") AS min_attempts,
    MAX("AccountBalance") AS max_balance,
    MIN("AccountBalance") AS min_balance
FROM bank_transactions;

/*TransactionType має бути debit або credit*/

SELECT 
	DISTINCT("TransactionType") as type_transaction
FROM bank_transactions;

/*Channel має бути online, atm, branch*/

SELECT 
	DISTINCT ("Channel") as type_channel
FROM bank_transactions;

/*CustomerOccupation - знаходимо унікальні значення*/

SELECT 
	DISTINCT ("CustomerOccupation") as customers
FROM bank_transactions;

