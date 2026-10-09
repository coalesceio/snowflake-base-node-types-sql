@id("14087bff-c550-57ed-af81-01dfb0872afb")
@nodeType("SQLWork")
@materializationType("table")
@description("Customer enriched with geography")
SELECT
    "C"."C_CUSTKEY" AS "CUSTOMER_KEY" @id("aa47ab0f-53d6-52c9-b657-957cbb53fdce") @inHash("CUST_HASH", 1),
    "C"."C_NAME" AS "CUSTOMER_NAME" @id("fd5bc778-8f4d-5809-b9d6-c7fdd89c33ab") @inHash("CUST_HASH", 2),
    "C"."C_ADDRESS" AS "ADDRESS" @id("0ac78ef4-c70a-5aba-8461-a6104552f41a"),
    "C"."C_PHONE" AS "PHONE" @id("1e295ea6-ca9c-5df7-8cb9-06eca10fce4b"),
    "C"."C_ACCTBAL" AS "ACCOUNT_BALANCE" @id("6dc8135d-addd-5c6a-b654-6af5fb31fa7e"),
    "C"."C_MKTSEGMENT" AS "MARKET_SEGMENT" @id("325ce1f0-f9f0-582a-9c8d-fae12036964c") @inHash("CUST_HASH", 3),
    "G"."NATION_NAME" AS "NATION_NAME" @id("ff652a57-a2b7-52f0-8fc1-166edd072781"),
    "G"."REGION_NAME" AS "REGION_NAME" @id("25794cf7-10f1-5d60-b408-05a201060049"),
    {{ get_hash('CUST_HASH') }}::STRING AS "CUSTOMER_HASH" @id("a2a8f878-2f23-5b2b-9e7c-7e623ee3ee8f")
FROM {{ ref('TARGET', 'BRZ_CUSTOMER') }} "C"
LEFT JOIN {{ ref('TARGET', 'SLV_GEOGRAPHY') }} "G"
    ON "C"."C_NATIONKEY" = "G"."NATION_KEY"
