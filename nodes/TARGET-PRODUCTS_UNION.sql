@id("c04b7270-7ad1-44d9-9b76-b03b7da72db0")
@nodeType("704")
@materializationType("table")
@description("PRODUCTS UNION")
WITH PRODUCTS_UNION_CTE AS (
    SELECT
         "PRODUCT_ID" AS "PRODUCT_ID",
         "PRODUCT_NAME" AS "PRODUCT_NAME",
         "BRAND" AS "BRAND",
         "COLOUR" AS "COLOUR"
    FROM {{ ref('SRC', 'PRODUCTS') }}

    UNION ALL

    SELECT
         "PRODUCT_ID" AS "PRODUCT_ID",
         "PRODUCT_NAME" AS "PRODUCT_NAME",
         "BRAND" AS "BRAND",
         "COLOUR" AS "COLOUR"
    FROM {{ ref('SRC', 'PRODUCTS_GROCERY') }}
)
SELECT 
 
         "PRODUCT_ID" AS "PRODUCT_ID",
         "PRODUCT_NAME" AS "PRODUCT_NAME",
         "BRAND" AS "BRAND",
         "COLOUR" AS "COLOUR",
         '1' AS contant
 FROM PRODUCTS_UNION_CTE;
