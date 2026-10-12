@id("778cb477-6fd9-4dee-a9c6-57ad0ea6be58")
@nodeType("SQLWork")
@materializationType("table")
@description("Sales star - cleansed supplier enriched with geography")
@writeMode("truncateInsert")
SELECT
    "S"."S_SUPPKEY" AS "SUPPLIER_KEY" @notNull @uniqueness,
    TRIM("S"."S_NAME") AS "SUPPLIER_NAME" @empty @uniqueness ,
    TRIM("S"."S_ADDRESS") AS "ADDRESS",
    "S"."S_PHONE" AS "PHONE",
    "S"."S_ACCTBAL" AS "ACCOUNT_BALANCE",
    "S"."S_NATIONKEY" AS "NATION_KEY",
    "G"."NATION_NAME" AS "NATION_NAME",
    
    "G"."REGION_NAME" AS "REGION_NAME"
FROM {{ ref('SRC', 'SUPPLIER') }} "S"
LEFT JOIN {{ ref('TARGET', 'WRK_GEOGRAPHY') }} "G"
    ON "S"."S_NATIONKEY" = "G"."NATION_KEY"
