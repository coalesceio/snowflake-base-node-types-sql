@id("e4ed6882-6166-4493-8bbd-7a5b490d3494")
@nodeType("718")
@description("TC08 - multi-source CTE lastModified SCD2 on N_LOAD_TIMESTAMP")
@mergeStrategy("lastModified")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'N' AND SYSTEM_END_DATE = '2999-12-31 00:00:00'", true, "After")
@tests("SELECT 1 FROM {{ this }} WHERE CUSTOMER_COUNT < 0 OR ORDER_COUNT < 0", true, "After")
WITH "CUSTOMER_AGG" AS (
    SELECT
        MOD("CUSTOMER_ID", 25) AS "NATION_KEY",
        COUNT(*) AS "CUSTOMER_COUNT",
        MAX("SIGNUP_DATE") AS "LATEST_SIGNUP_DATE"
    FROM {{ ref('SRC', 'CUSTOMERS') }}
    GROUP BY MOD("CUSTOMER_ID", 25)
),
"ORDER_AGG" AS (
    SELECT
        MOD("ORDER_ID", 25) AS "NATION_KEY",
        COUNT(*) AS "ORDER_COUNT"
    FROM {{ ref('SRC', 'ORDERS_TEST') }}
    GROUP BY MOD("ORDER_ID", 25)
)
SELECT
     0 AS "DIM_TC08_MS_LM_SCD2_KEY" @id("52bd82") @isSurrogateKey @uniqueness,
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("bd6715") @isBusinessKey @not_null @inHash("GH_NATION_STATS", 1),
     "N"."N_NAME" AS "N_NAME" @id("03206e") @empty,
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("b2aa6a"),
     CAST(COALESCE("CA"."CUSTOMER_COUNT", 0) AS NUMBER(38,0)) AS "CUSTOMER_COUNT" @id("35aaa9") @inHash("GH_NATION_STATS", 2),
     CAST("CA"."LATEST_SIGNUP_DATE" AS DATE) AS "LATEST_SIGNUP_DATE" @id("a80f49"),
     CAST(COALESCE("OA"."ORDER_COUNT", 0) AS NUMBER(38,0)) AS "ORDER_COUNT" @id("e8e480") @inHash("GH_NATION_STATS", 3),
     "N"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("920bd6") @lastModifiedTracking(2) @not_null,
     {{ get_hash('GH_NATION_STATS', algo='SHA256', delimiter='~') }}::STRING AS "GH_NATION_STATS" @id("ffdede"),
     1 AS "SYSTEM_VERSION" @id("46ad78") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("a9039f") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("149d15") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("af98c5") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("82673e") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
LEFT JOIN "CUSTOMER_AGG" "CA" ON "N"."N_NATIONKEY" = "CA"."NATION_KEY"
LEFT JOIN "ORDER_AGG" "OA" ON "N"."N_NATIONKEY" = "OA"."NATION_KEY"
