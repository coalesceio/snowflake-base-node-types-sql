@id("0ae7382c-ee31-4c39-8a35-d5c3bc29fa28")
@nodeType("707")
SELECT
     "C_CUSTKEY" AS "C_CUSTKEY",
     "C_NAME" AS "C_NAME",
     "C_ADDRESS" AS "C_ADDRESS",
     "C_NATIONKEY" AS "C_NATIONKEY",
     "C_PHONE" AS "C_PHONE"
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
