@id("1483866f-d2ec-4af9-8ebd-f0001f9bc62c")
@nodeType("707")
SELECT 
Salesperson, 
CAST(Sale_Date AS DATE), 
CAST(Total_Daily_Sales AS NUMERIC)
FROM (
    SELECT 
        Salesperson, 
        Sale_Date, 
        SUM(Amount) AS Total_Daily_Sales,
        ROW_NUMBER() OVER (PARTITION BY Salesperson ORDER BY SUM(Amount) DESC) as rn
    FROM {{ ref('TARGET', 'RAW_SALES') }} "RAW_SALES"
    GROUP BY Salesperson, Sale_Date
)
WHERE rn = 1;