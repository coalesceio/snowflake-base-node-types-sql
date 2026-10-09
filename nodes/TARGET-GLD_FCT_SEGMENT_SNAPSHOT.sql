@id("f54968fd-dbda-4ab9-80f2-0b0aa4dfadba")
@nodeType("SQLFact")
@description("Gold: daily segment snapshot - allColumnMatch, re-runs on the same day add nothing (SQL Fact)")
@mergeStrategy("allColumnMatch")
WITH "AGG" AS (
    SELECT "S"."NATION_NAME", "S"."C_MKTSEGMENT", COUNT(*) AS "CUSTOMER_COUNT", SUM("S"."C_ACCTBAL") AS "TOTAL_ACCTBAL"
    FROM {{ ref('TARGET', 'SLV_CUSTOMER_ENRICHED') }} "S"
    GROUP BY "S"."NATION_NAME", "S"."C_MKTSEGMENT"
)
SELECT
    CAST(CURRENT_DATE AS DATE)           AS "SNAPSHOT_DATE"      @id("69317f"),
    "A"."NATION_NAME"                    AS "NATION_NAME"        @id("16abf0"),
    "A"."C_MKTSEGMENT"                   AS "C_MKTSEGMENT"       @id("7400d3"),
    "A"."CUSTOMER_COUNT"                 AS "CUSTOMER_COUNT"     @id("c3edaf") @min_value("1"),
    "A"."TOTAL_ACCTBAL"                  AS "TOTAL_ACCTBAL"      @id("1acc6e"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("32a0aa") @isSystemCreateDate
FROM "AGG" "A"
