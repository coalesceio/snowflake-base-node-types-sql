@id("ac150816-1597-4b7d-8b0d-d4bfc8fdb1da")
@nodeType("718")
@description("TC05 - multi-source CTE (NATION_TEST + CUSTOMER + ORDERS_TEST) changeTracking SCD1 with hash over CTE columns")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE CUSTOMER_COUNT < 0 OR ORDER_COUNT < 0", true, "After")
WITH "CUSTOMER_AGG" AS (
    SELECT
        "C_NATIONKEY" AS "NATION_KEY",
        COUNT(*) AS "CUSTOMER_COUNT",
        SUM("C_ACCTBAL") AS "TOTAL_ACCTBAL"
    FROM {{ ref('SRC', 'CUSTOMER') }}
    GROUP BY "C_NATIONKEY"
),
"ORDER_AGG" AS (
    SELECT
        MOD("ORDER_ID", 25) AS "NATION_KEY",
        COUNT(*) AS "ORDER_COUNT"
    FROM {{ ref('SRC', 'ORDERS_TEST') }}
    GROUP BY MOD("ORDER_ID", 25)
)
SELECT
     0 AS "DIM_TC05_MS_CT_SCD1_KEY" @id("16c21d") @isSurrogateKey,
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("e99837") @isBusinessKey @not_null @uniqueness,
     "N"."N_NAME" AS "N_NAME" @id("77351e") @not_null @inHash("GH_NATION_STATS", 1),
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("20f4d4") @min_max(0, 4),
     CAST(COALESCE("CA"."CUSTOMER_COUNT", 0) AS NUMBER(38,0)) AS "CUSTOMER_COUNT" @id("500959") @not_null @min_value(0) @inHash("GH_NATION_STATS", 2),
     CAST(COALESCE("CA"."TOTAL_ACCTBAL", 0) AS NUMBER(18,2)) AS "TOTAL_ACCTBAL" @id("eaba6e") @not_null,
     CAST(COALESCE("OA"."ORDER_COUNT", 0) AS NUMBER(38,0)) AS "ORDER_COUNT" @id("766c61") @not_null @min_value(0) @inHash("GH_NATION_STATS", 3),
     "N"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("04bd5c"),
     {{ get_hash('GH_NATION_STATS') }}::STRING AS "GH_NATION_STATS" @id("3e38cc") @not_null,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("6f0e81") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("4b210f") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
LEFT JOIN "CUSTOMER_AGG" "CA" ON "N"."N_NATIONKEY" = "CA"."NATION_KEY"
LEFT JOIN "ORDER_AGG" "OA" ON "N"."N_NATIONKEY" = "OA"."NATION_KEY"
