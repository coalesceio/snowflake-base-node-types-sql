@id("67fb946f-c6f6-4be8-a8b8-6b4bc362585a")
@nodeType("704")
@testsEnabled
@tests("SELECT 1
WHERE EXISTS (
    SELECT 1
    FROM {{this}}
    WHERE EMAIL NOT LIKE '%@%'
  )", "After", true)
SELECT
     "EMAIL" AS "EMAIL",
     "JOIN_DATE" AS "JOIN_DATE",
     "AGE_BAND" AS "AGE_BAND",
     "HOUSEHOLD_INCOME" AS "HOUSEHOLD_INCOME",
     "MARITAL_STATUS" AS "MARITAL_STATUS",
     "HOUSEHOLD_SIZE" AS "HOUSEHOLD_SIZE",
     "TOTAL_ORDER_VALUE" AS "TOTAL_ORDER_VALUE"
FROM {{ ref('SRC', 'CUSTOMERS') }} "CUSTOMERS"
WHERE NOT REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')