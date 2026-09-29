@id("62710010-25b9-4452-9195-807f996f733c")
@nodeType("718")
@description("TC11 - upsert over the multi-source CTE")
@mergeStrategy("upsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
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
     0 AS "DIM_TC11_UPSERT_MULTI_SOURCE_KEY" @id("9d3d5c") @isSurrogateKey,
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("1887ea") @isBusinessKey @not_null,
     "N"."N_NAME" AS "N_NAME" @id("403ead"),
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("f5843a"),
     CAST(COALESCE("CA"."CUSTOMER_COUNT", 0) AS NUMBER(38,0)) AS "CUSTOMER_COUNT" @id("5bcb4e") @min_value(0),
     CAST("CA"."LATEST_SIGNUP_DATE" AS DATE) AS "LATEST_SIGNUP_DATE" @id("65983c"),
     CAST(COALESCE("OA"."ORDER_COUNT", 0) AS NUMBER(38,0)) AS "ORDER_COUNT" @id("a66002") @min_value(0),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("011b4a") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("dc0b5d") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
LEFT JOIN "CUSTOMER_AGG" "CA" ON "N"."N_NATIONKEY" = "CA"."NATION_KEY"
LEFT JOIN "ORDER_AGG" "OA" ON "N"."N_NATIONKEY" = "OA"."NATION_KEY"
