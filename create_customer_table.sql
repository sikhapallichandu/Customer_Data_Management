
-- 1. Create table queries
CREATE TABLE Customer_Data (
    Customer_Name VARCHAR(255) NOT NULL,      -- Name of the customer (Mandatory)
    Customer_ID VARCHAR(18) NOT NULL,         -- Unique customer ID (Mandatory)
    Open_Date DATE NOT NULL,                  -- The date when the customer record was created (Mandatory)
    Last_Consulted_Date DATE,                 -- The date when the customer was last consulted (Optional)
    Vaccination_Type VARCHAR(5),              -- The type of vaccination given (Optional, increased flexibility)
    Doctor_Consulted VARCHAR(255),            -- Name of the doctor consulted (Optional)
    State CHAR(3),                            -- State of the customer (Optional, adjusted to 3 chars for flexibility)
    Country CHAR(3),                          -- Country of the customer (Optional, adjusted to 3 chars)
    Post_Code INT,                            -- Postal code (Optional)
    Date_Of_Birth DATE,                       -- Customer's date of birth (Optional)
    Is_Active CHAR(1) CHECK (Is_Active IN ('A', 'I')), -- Active status: 'A' for active, 'I' for inactive (Optional)
    
	
	

-- 2.  Create the above tables with additional derived columns: age and days since last consulted >30

CREATE TABLE Customer_Data (
    Customer_Name VARCHAR(255) NOT NULL,      -- Name of the customer (Mandatory)
    Customer_ID VARCHAR(18) NOT NULL,         -- Unique customer ID (Mandatory)
    Open_Date DATE NOT NULL,                  -- The date when the customer record was created (Mandatory)
    Last_Consulted_Date DATE,                 -- The date when the customer was last consulted (Optional)
    Vaccination_Type VARCHAR(5),              -- The type of vaccination given (Optional)
    Doctor_Consulted VARCHAR(255),            -- Name of the doctor consulted (Optional)
    State CHAR(3),                            -- State of the customer (Optional)
    Country CHAR(3),                          -- Country of the customer (Optional)
    Post_Code INT,                            -- Postal code (Optional)
    Date_Of_Birth DATE,                       -- Customer's date of birth (Optional)
    Is_Active CHAR(1) CHECK (Is_Active IN ('A', 'I')), -- Active status: 'A' for active, 'I' for inactive (Optional)
    PRIMARY KEY (Customer_ID),                -- Primary key on Customer_ID
    Age AS (YEAR(CURRENT_DATE) - YEAR(Date_Of_Birth) - 
             CASE 
                WHEN MONTH(CURRENT_DATE) < MONTH(Date_Of_Birth) OR 
                     (MONTH(CURRENT_DATE) = MONTH(Date_Of_Birth) AND DAY(CURRENT_DATE) < DAY(Date_Of_Birth)) 
                THEN 1 
                ELSE 0 
             END), -- Computed Age
    Days_Since_Last_Consulted AS (DATEDIFF(CURRENT_DATE, Last_Consulted_Date)) -- Computed days since last consulted
);


-- 3. Create necessary validations.

CREATE TABLE Customer_Data (
    Customer_Name VARCHAR(255) NOT NULL,      -- Name of the customer (Mandatory)
    Customer_ID VARCHAR(18) NOT NULL UNIQUE,  -- Unique customer ID (Mandatory, must be unique)
    Open_Date DATE NOT NULL,                   -- The date when the customer record was created (Mandatory)
    Last_Consulted_Date DATE,                  -- The date when the customer was last consulted (Optional)
    Vaccination_Type VARCHAR(5),               -- The type of vaccination given (Optional)
    Doctor_Consulted VARCHAR(255),             -- Name of the doctor consulted (Optional)
    State CHAR(3) CHECK (State IN ('NY', 'CA', 'TX', 'FL', 'IL')),  -- Example states (Optional)
    Country CHAR(3) CHECK (Country IN ('USA', 'IND', 'AU', 'PHIL', 'NYC')),    -- Example countries (Optional)
    Post_Code INT CHECK (Post_Code > 0),      -- Postal code must be positive (Optional)
    Date_Of_Birth DATE CHECK (Date_Of_Birth <= CURRENT_DATE), -- Date of birth must be in the past
    Is_Active CHAR(1) CHECK (Is_Active IN ('A', 'I')) DEFAULT 'A', -- Active status: 'A' for active, 'I' for inactive (default is 'A')
    PRIMARY KEY (Customer_ID)                  -- Primary key on Customer_ID
);

