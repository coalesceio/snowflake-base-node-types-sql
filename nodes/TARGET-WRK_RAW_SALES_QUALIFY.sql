@id("d5701e06-33d2-49f9-9baa-88b497cc6527")
@nodeType("707")
SELECT DISTINCT
    Salesperson, 
    Sale_Date, 
    SUM(Amount) AS Total_Daily_Sales
FROM {{ ref('TARGET', 'RAW_SALES') }} "RAW_SALES"
GROUP BY Salesperson, Sale_Date
QUALIFY ROW_NUMBER() OVER (PARTITION BY Salesperson ORDER BY SUM(Amount) DESC) = 1;