USE bank_transactions;

-- Import MCC_Codes data from file:

-- Step 1: Insert data from JSON file into the MCC_Codes table
INSERT INTO MCC_Codes (mcc_id, description)
SELECT
    CAST([key] AS INT) AS mcc_id,  -- Convert JSON keys to INT for the mcc_id column
    [value] AS description         -- Use JSON values as the description
FROM OPENROWSET(
    BULK 'C:\Users\Sophia\Desktop\archive\mcc_codes.json',  -- Specify the path to the JSON file
    SINGLE_CLOB  -- Read the file as a single large text value
) AS jsonFile
CROSS APPLY OPENJSON(jsonFile.BulkColumn);  -- Parse the JSON content into key-value pairs

-- Step 2: Check the imported data
SELECT * FROM MCC_Codes;
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;


-- Step 2: Insert data into the Transactions table
INSERT INTO Transactions (transaction_id, date, client_id, card_id, merchant_id, amount, use_chip, mcc, errors, is_fraud)
SELECT
    transaction_id,
    TRY_CONVERT(DATE, date, 120) AS date,
    client_id,
    card_id,
    TRY_CONVERT(INT, merchant_id) AS merchant_id,
    amount,
    use_chip,
    mcc,
    errors,
    is_fraud
FROM Unified_Transactions
WHERE TRY_CONVERT(INT, merchant_id) IS NOT NULL;
