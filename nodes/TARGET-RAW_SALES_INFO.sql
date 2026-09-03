@id("0a046c2b-701f-441f-898b-2de44ea2390c")
@nodeType("704")
@materializationType("view")
SELECT
     "SALES_ID" AS "SALES_ID",
     "SALESPERSON" AS "SALESPERSON",
     "SALE_DATE" AS "SALE_DATE",
     "AMOUNT" AS "AMOUNT",
     "QUARTER" AS "QUARTER",
     "REGION" AS "REGION"
FROM {{ ref('TARGET', 'RAW_SALES') }} "RAW_SALES"
WHERE "AMOUNT" > 1000
