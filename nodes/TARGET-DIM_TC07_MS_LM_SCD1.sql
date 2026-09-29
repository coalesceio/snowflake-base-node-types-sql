@id("78bbb190-7d59-478a-8524-8d0a47469ffc")
@nodeType("718")
@description("TC07 - multi-source CTE lastModified SCD1 on N_LOAD_TIMESTAMP")
@mergeStrategy("lastModified")
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
     0 AS "DIM_TC07_MS_LM_SCD1_KEY" @id("a64be4") @isSurrogateKey,
     "N"."N_NATIONKEY" AS "N_NATIONKEY" @id("da511a") @isBusinessKey @not_null @uniqueness @inHash("GH_NATION_KEY", 1),
     "N"."N_NAME" AS "N_NAME" @id("d6f48d") @not_null,
     "N"."N_REGIONKEY" AS "N_REGIONKEY" @id("1bdd5c") @accepted_values("0, 1, 2, 3, 4"),
     CAST(COALESCE("CA"."CUSTOMER_COUNT", 0) AS NUMBER(38,0)) AS "CUSTOMER_COUNT" @id("c291f4") @min_value(0),
     CAST("CA"."LATEST_SIGNUP_DATE" AS DATE) AS "LATEST_SIGNUP_DATE" @id("398656"),
     CAST(COALESCE("OA"."ORDER_COUNT", 0) AS NUMBER(38,0)) AS "ORDER_COUNT" @id("ea5ada") @min_value(0),
     "N"."N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("2b7d38") @lastModifiedTracking(1) @not_null,
     {{ get_hash('GH_NATION_KEY', 'SHA256') }}::STRING AS "GH_NATION_KEY" @id("dc4ecd") @uniqueness,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("c8dd1d") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("8ad72c") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "N"
LEFT JOIN "CUSTOMER_AGG" "CA" ON "N"."N_NATIONKEY" = "CA"."NATION_KEY"
LEFT JOIN "ORDER_AGG" "OA" ON "N"."N_NATIONKEY" = "OA"."NATION_KEY"
