@id("df50915a-b9da-423b-8ebb-d33a3f248b7f")
@nodeType("718")
@description("TC06 - multi-source CTE changeTracking SCD2 (CUSTOMER_COUNT/ORDER_COUNT tracked, TOTAL_ACCTBAL in place)")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
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
     0 AS "DIM_TC06_MS_CT_SCD2_KEY" @id("133a33") @isSurrogateKey @uniqueness,
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("091f63") @isBusinessKey @not_null,
     "N"."N_NAME" AS "N_NAME" @id("e9e185") @inHash("GH_NATION_STATS", 1),
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("cae1c1"),
     CAST(COALESCE("CA"."CUSTOMER_COUNT", 0) AS NUMBER(38,0)) AS "CUSTOMER_COUNT" @id("d0d750") @isChangeTracking @min_value(0) @inHash("GH_NATION_STATS", 2),
     CAST(COALESCE("CA"."TOTAL_ACCTBAL", 0) AS NUMBER(18,2)) AS "TOTAL_ACCTBAL" @id("fd4085"),
     CAST(COALESCE("OA"."ORDER_COUNT", 0) AS NUMBER(38,0)) AS "ORDER_COUNT" @id("b8abe1") @isChangeTracking @min_value(0) @inHash("GH_NATION_STATS", 3),
     "N"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("8cfcb2"),
     {{ get_hash('GH_NATION_STATS', 'MD5') }}::STRING AS "GH_NATION_STATS" @id("cc59a8"),
     1 AS "SYSTEM_VERSION" @id("5bf07d") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("7d5d8f") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("3e09e0") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("135179") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("530d98") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
LEFT JOIN "CUSTOMER_AGG" "CA" ON "N"."N_NATIONKEY" = "CA"."NATION_KEY"
LEFT JOIN "ORDER_AGG" "OA" ON "N"."N_NATIONKEY" = "OA"."NATION_KEY"
