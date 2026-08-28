@id("59f38db1-4728-4488-8801-037a92e139f8")
@nodeType("704")
@truncateBefore
@tests("SELECT * FROM {{ref('TARGET','WRK_PIVOT_UPPER')}} WHERE Q1 > 2000 ", "After", true)
@postSQL("  
    CREATE OR REPLACE TABLE ANANDHIS_DEV.TARGET.RAWSALES ( SALES STRING,Q1 VARIANT,Q2  VARIANT,Q3  VARIANT,Q4  VARIANT
  )
  
  ")
@postSQL("  
    MERGE INTO ANANDHIS_DEV.TARGET.RAWSALES AS TGT 
USING ANANDHIS_DEV.TARGET.WRK_PIVOT_UPPER AS SRC
    ON TGT.SALES = SRC.Salesperson  -- Join on a unique identifier
WHEN MATCHED THEN
    UPDATE SET 
        TGT.Q1 = SRC.Q1,
        TGT.Q2 = SRC.Q2,
        TGT.Q3 = SRC.Q3,
        TGT.Q4 = SRC.Q4
WHEN NOT MATCHED THEN
    INSERT (
        SALES, 
        Q1, 
        Q2, 
        Q3, 
        Q4
    )
    VALUES (
        SRC.Salesperson, 
        SRC.Q1, 
        SRC.Q2, 
        SRC.Q3, 
        SRC.Q4
    )
  ")
-- CTE to provide the raw data
WITH RawSales AS (
    SELECT 'Alice' AS Salesperson, 'Q1' AS Quarter, 1000 AS Amount
    UNION ALL SELECT 'Alice', 'Q2', 1500
    UNION ALL SELECT 'Alice', 'Q3', 1200
    UNION ALL SELECT 'Bob', 'Q1', 2000
    UNION ALL SELECT 'Bob', 'Q2', 1800
    UNION ALL SELECT 'Bob', 'Q4', 2200
)
    SELECT
        SALESPERSON AS "SALESPERSON",
        CAST("'Q1'" AS VARIANT) AS "Q1",
        CAST("'Q2'" AS VARIANT) AS "Q2",
        CAST("'Q3'" AS VARIANT) AS "Q3",
        CAST("'Q4'" AS VARIANT) AS "Q4"
FROM (
    SELECT Salesperson, Quarter, Amount 
    FROM RawSales
)
PIVOT (
    SUM(Amount) 
    FOR Quarter IN ('Q1', 'Q2', 'Q3', 'Q4')
);