@id("d41188a3-d677-5e1a-8d2c-44c4dafc5153")
@nodeType("SQLWork")
@materializationType("transient table")
@description("Top 100 customers by lifetime value")
SELECT
    "C"."CUSTOMER_KEY" AS "CUSTOMER_KEY" @id("771dd299-73f5-5131-a4cf-375914de96fc"),
    "C"."CUSTOMER_NAME" AS "CUSTOMER_NAME" @id("10f65ced-10c2-583b-ac83-20d5c2e6c5e9"),
    "C"."LIFETIME_VALUE" AS "LIFETIME_VALUE" @id("8ac13eb4-5404-5ffa-a834-27cc1403c7d6")
FROM {{ ref('TARGET', 'MRT_CUSTOMER_360') }} "C"
QUALIFY ROW_NUMBER() OVER (ORDER BY "C"."LIFETIME_VALUE" DESC, "C"."CUSTOMER_KEY") <= 100
