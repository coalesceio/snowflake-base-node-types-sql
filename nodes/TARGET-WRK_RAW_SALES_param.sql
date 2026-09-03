@id("bf693bd6-5908-4c93-9db6-c0fd297bcfb6")
@nodeType("707")
SELECT
     "SALES_ID" AS "SALES_ID",
     "SALESPERSON" AS "SALESPERSON",
     "SALE_DATE" AS "SALE_DATE",
     "AMOUNT" AS "AMOUNT",
     "QUARTER" AS "QUARTER",
     "REGION" AS "REGION"
FROM {{ ref('TARGET', 'RAW_SALES') }} "RAW_SALES"
WHERE AMOUNT > {{parameters.amount}}
