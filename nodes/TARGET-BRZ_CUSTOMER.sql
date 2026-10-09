@id("a3405689-72ed-5412-84a6-5e329f2ddfa3")
@nodeType("SQLWork")
@materializationType("table")
@description("Bronze customer (SQLWork)")
@tag("OWNER", "ANALYTICS")
SELECT
    "CUSTOMER"."C_CUSTKEY" AS "C_CUSTKEY" @id("a876d7b7-e239-561c-8c60-ceea4a100c86") @notNull,
    "CUSTOMER"."C_NAME" AS "C_NAME" @id("b1749a65-0d94-5020-9160-8854ddb198da"),
    "CUSTOMER"."C_ADDRESS" AS "C_ADDRESS_LINE" @id("3ac0092c-465b-522b-a66a-b1f53e5397d7"),
    "CUSTOMER"."C_NATIONKEY" AS "C_NATIONKEY" @id("cfe9da85-2393-508f-8896-136aa2b1bd09") @clusterKey(1),
    "CUSTOMER"."C_PHONE" AS "C_PHONE" @id("cfa27e3b-5f2d-50e4-abf4-bc74bacdabd2") @tag("PII", "true"),
    "CUSTOMER"."C_ACCTBAL" AS "C_ACCTBAL" @id("e7d9330c-99b6-5cce-94ff-d7e8a691c0e7"),
    "CUSTOMER"."C_MKTSEGMENT" AS "C_MKTSEGMENT" @id("4fad3d04-11f2-5ab3-a1e3-bd1b17e893d2"),
    "CUSTOMER"."C_COMMENT" AS "C_COMMENT" @id("78d5ab51-2c35-5795-9d8f-ab34a051aabd"),
    CAST(LEFT("CUSTOMER"."C_PHONE", 2) AS VARCHAR(2)) AS "C_PHONE_PREFIX" @id("c1a47b2f-2fa0-5a57-9bcb-f533ff87e494")
FROM {{ ref('SRC', 'CUSTOMER') }} "CUSTOMER"
