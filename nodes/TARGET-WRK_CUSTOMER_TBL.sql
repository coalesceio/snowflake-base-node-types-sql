@id("262b35d3-178a-43bb-8753-ee81b665e5f9")
@nodeType("SQLWork")
@materializationType("table")
@description("Sales star - cleansed customer enriched with geography")
@writeMode("truncateInsert")
SELECT
    "C"."C_CUSTKEY" AS "CUSTOMER_KEY" @notNull @uniqueness @inHash("CUSTOMER_ATTR_HASH", 1),
    TRIM("C"."C_NAME") AS "CUSTOMER_NAME" @inHash("CUSTOMER_ATTR_HASH", 2),
    TRIM("C"."C_ADDRESS") AS "ADDRESS" @inHash("CUSTOMER_ATTR_HASH", 3),
    "C"."C_PHONE" AS "PHONE",
    "C"."C_ACCTBAL" AS "ACCOUNT_BALANCE",
    UPPER(TRIM("C"."C_MKTSEGMENT")) AS "MARKET_SEGMENT" @inHash("CUSTOMER_ATTR_HASH", 4) @accepted_values("'AUTOMOBILE', 'BUILDING', 'FURNITURE', 'HOUSEHOLD', 'MACHINERY'"),
    "C"."C_NATIONKEY" AS "NATION_KEY" @clusterKey(1),
    "G"."NATION_NAME" AS "NATION_NAME" @clusterKey(2),
    "G"."REGION_NAME" AS "REGION_NAME",
    {{ get_hash('CUSTOMER_ATTR_HASH', 'MD5') }}::STRING AS "CUSTOMER_ATTR_HASH"
FROM {{ ref('SRC', 'CUSTOMER') }} "C"
LEFT JOIN {{ ref('TARGET', 'WRK_GEOGRAPHY') }} "G"
    ON "C"."C_NATIONKEY" = "G"."NATION_KEY"
