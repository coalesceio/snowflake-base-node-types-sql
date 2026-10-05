@id("83958036-0bec-443a-8294-b0ab30489abf")
@nodeType("SQLFact")
@description("Nation fact (changeTracking SCD1) enriched with region-level aggregates via CTEs and joins")
@mergeStrategy("changeTracking")
WITH "NATION_SRC" AS (
    SELECT "N"."NAtionKey", UPPER(TRIM("N"."name")) AS "NATION_NAME", "N"."REGIONKEY", "N"."CommenT", "N"."N_Load_Timestamp"
    FROM {{ ref('SRC', 'Nation_Test') }} "N"
    WHERE "N"."NAtionKey" IS NOT NULL
),
"REGION_STATS" AS (
    SELECT "R"."REGIONKEY", COUNT(*) AS "NATION_COUNT", MAX("R"."N_Load_Timestamp") AS "LATEST_REGION_LOAD"
    FROM "NATION_SRC" "R"
    GROUP BY "R"."REGIONKEY"
),
"REGION_FIRST_NATION" AS (
    SELECT "F"."REGIONKEY", MIN("F"."NATION_NAME") AS "FIRST_NATION_NAME"
    FROM "NATION_SRC" "F"
    GROUP BY "F"."REGIONKEY"
)
SELECT
    "NS"."NAtionKey"                         AS "NAtionKey_NAME"      @id("7c1a01") @description("Nation identifier") @isBusinessKey @not_null @uniqueness @min_max(0, 24),
    "NS"."NATION_NAME"                       AS "NATION_NAME"         @id("7c1a02") @description("Nation name, trimmed and upper-cased") @not_null @empty @rejected_values("'UNKNOWN'"),
    "NS"."REGIONKEY"                         AS "REGIONKEY"           @id("7c1a03") @description("Region the nation belongs to") @not_null @accepted_values("0, 1, 2, 3, 4"),
    "NS"."CommenT"::VARCHAR(200)             AS "CommenT"             @id("7c1a04") @description("Free-text comment") @empty,
    "NS"."N_Load_Timestamp"                  AS "N_Load_Timestamp"    @id("7c1a05") @description("Source load timestamp") @max_value("CURRENT_TIMESTAMP") @relative_time("<=", "LATEST_REGION_LOAD"),
    "RS"."NATION_COUNT"                      AS "REGION_NATION_COUNT" @id("7c1a06") @description("Number of nations in the same region") @min_value(1) @max_value(25),
    "RS"."LATEST_REGION_LOAD"                AS "LATEST_REGION_LOAD"  @id("7c1a07") @description("Most recent load timestamp across the region"),
    "RF"."FIRST_NATION_NAME"                 AS "FIRST_NATION_NAME"   @id("7c1a08") @description("Alphabetically first nation in the region") @not_null,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7c1a09") @isSystemCreateDate @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7c1a0a") @isSystemUpdateDate @freshness(1, "DAY")
FROM "NATION_SRC" "NS"
INNER JOIN "REGION_STATS" "RS"
    ON "NS"."REGIONKEY" = "RS"."REGIONKEY"
LEFT JOIN "REGION_FIRST_NATION" "RF"
    ON "NS"."REGIONKEY" = "RF"."REGIONKEY"
