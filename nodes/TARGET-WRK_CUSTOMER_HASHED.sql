@id("b91029c3-4d34-4a1f-bcea-b6b2d496cfd7")
@nodeType("707")
@description("Customer records from WRK_CUSTOMER enriched with a deterministic hash of CUSTKEY and customer name")
SELECT
     "C_CUSTKEY" AS "C_CUSTKEY" @description("Unique identifier for the customer") @inHash("CUSTOMER_HASH", 1),
     "C_NAME" AS "C_NAME" @description("Customer name") @inHash("CUSTOMER_HASH", 2),
     "C_ADDRESS" AS "C_ADDRESS",
     "C_NATIONKEY" AS "C_NATIONKEY",
     "C_PHONE" AS "C_PHONE",
     "C_ACCTBAL" AS "C_ACCTBAL",
     "C_MKTSEGMENT" AS "C_MKTSEGMENT",
     "C_COMMENT" AS "C_COMMENT",
     "C_LOAD_TIMESTAMP" AS "C_LOAD_TIMESTAMP",
     {{ get_hash('CUSTOMER_HASH') }}::STRING AS "CUSTOMER_HASH" @description("SHA1 hash of C_CUSTKEY and C_NAME")
FROM {{ ref('TARGET', 'WRK_CUSTOMER_TB') }} "WRK_CUSTOMER_TB"
