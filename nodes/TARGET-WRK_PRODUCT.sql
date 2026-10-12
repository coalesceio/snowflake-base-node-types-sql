@id("aa610980-c992-4c9c-a05a-e2e2cfd8479a")
@nodeType("SQLWork")
@materializationType("table")
@description("Sales star - cleansed part/product with price band")
@writeMode("truncateInsert")
@tag("PIPELINE", "SALES_STAR")
SELECT
    "P"."P_PARTKEY" AS "PART_KEY" @notNull @uniqueness,
    TRIM("P"."P_NAME") AS "PART_NAME",
    "P"."P_MFGR" AS "MANUFACTURER",
    "P"."P_BRAND" AS "BRAND",
    "P"."P_TYPE" AS "PART_TYPE",
    "P"."P_SIZE" AS "PART_SIZE" @min_value("0"),
    "P"."P_CONTAINER" AS "CONTAINER",
    "P"."P_RETAILPRICE" AS "RETAIL_PRICE" @min_value("0"),
    CAST(CASE WHEN "P"."P_RETAILPRICE" >= 1500 THEN 'HIGH'
              WHEN "P"."P_RETAILPRICE" >= 1000 THEN 'MID'
              ELSE 'LOW' END AS VARCHAR(4)) AS "PRICE_BAND" @accepted_values("'HIGH', 'MID', 'LOW'"),
    "P"."LOAD_TS" AS "LOAD_TS"
FROM {{ ref('SRC', 'PART') }} "P"
