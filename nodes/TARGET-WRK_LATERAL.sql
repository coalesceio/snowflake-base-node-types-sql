@id("0f634ca5-6574-4c32-8e01-80aed244adde")
@nodeType("707")
WITH ProductData AS (
    SELECT 1 AS ID, 'Electronics,Sale,Refurbished' AS Tags
)
SELECT DISTINCT
    ID, 
    CAST(s.VALUE AS STRING)AS Tag_Name,
    CAST(s.INDEX AS NUMBER) AS Tag_Order
FROM ProductData,
LATERAL SPLIT_TO_TABLE(Tags, ',') s;