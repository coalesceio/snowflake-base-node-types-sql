@id("f8c4f361-435b-4973-bca8-0f6a127072cd")
@nodeType("707")

WITH WideProducts AS (
    SELECT 'Laptop' AS Product, 500 AS Jan, 600 AS Feb, 700 AS Mar
    UNION ALL
    SELECT 'Tablet' AS Product, 200 AS Jan, 250 AS Feb, 300 AS Mar
)
-- Main query using UNPIVOT
SELECT 
Product, 
CAST(MonthName AS STRING), 
CAST(SalesAmount AS NUMERIC)
FROM WideProducts
UNPIVOT (
    SalesAmount FOR MonthName IN (Jan, Feb, Mar)
) AS UnpivotTable;