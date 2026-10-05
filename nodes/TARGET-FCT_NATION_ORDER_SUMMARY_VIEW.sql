@id("d6a0d3f8-9d4b-41ab-8b55-6367291dd137")
@nodeType("SQLFact")
@description("Pipeline: per-nation order summary - upsert on DIM_NATION_KEY")
@materializationType("view")
@mergeStrategy("upsert")
@tests("SELECT 1 FROM {{ this }} WHERE ORDER_COUNT < MATCHED_ORDER_COUNT", false, "After")
WITH "ORDER_STATS" AS (
    SELECT
        "F"."DIM_NATION_KEY"                               AS "DIM_NATION_KEY",
        COUNT(*)                                           AS "ORDER_COUNT",
        COUNT_IF("F"."CUSTOMER_MATCHED" = 'Y')             AS "MATCHED_ORDER_COUNT",
        COUNT(DISTINCT NULLIF("F"."DIM_CUSTOMER_KEY", -1)) AS "CUSTOMER_COUNT",
        MIN("F"."ORDER_ID")                                AS "FIRST_ORDER_ID",
        MAX("F"."ORDER_ID")                                AS "LAST_ORDER_ID"
    FROM {{ ref('TARGET', 'FCT_ORDERS') }} "F"
    GROUP BY "F"."DIM_NATION_KEY"
)
SELECT
    "S"."DIM_NATION_KEY"                 AS "DIM_NATION_KEY"      @id("3b0001") @isBusinessKey @not_null @uniqueness,
    COALESCE("DN"."N_NAME", 'UNKNOWN')   AS "N_NATION_NAME"              @id("3b0002") @not_null,
    "S"."ORDER_COUNT"                    AS "ORDER_COUNT"         @id("3b0003") @not_null @min_value(1),
    "S"."MATCHED_ORDER_COUNT"            AS "MATCHED_ORDER_COUNT" @id("3b0004") @not_null @min_value(0),
    "S"."CUSTOMER_COUNT"                 AS "CUSTOMER_COUNT"      @id("3b0005") @min_value(0),
    "S"."FIRST_ORDER_ID"                 AS "FIRST_ORDER_ID"      @id("3b0006") @relative_time("<=", "LAST_ORDER_ID"),
    "S"."LAST_ORDER_ID"                  AS "LAST_ORDER_ID"       @id("3b0007"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"  @id("3b0008") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"  @id("3b0009") @isSystemUpdateDate
FROM "ORDER_STATS" "S"
LEFT JOIN {{ ref('TARGET', 'DIM_NATION') }} "DN"
    ON "S"."DIM_NATION_KEY" = "DN"."DIM_NATION_KEY"
