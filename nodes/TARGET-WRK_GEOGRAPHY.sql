@id("43a27587-9433-4475-b5ee-6b23eef0374c")
@nodeType("SQLWork")
@materializationType("table")
@description("Sales star - nation joined to region (conformed geography)")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY NATION_KEY HAVING COUNT(*) > 1", false, "After")
SELECT
    "N"."N_NATIONKEY" AS "NATION_KEY" @notNull @not_null @uniqueness,
    UPPER(TRIM("N"."N_NAME")) AS "NATION_NAME" @not_null @empty,
    "R"."R_REGIONKEY" AS "REGION_KEY" @not_null,
    UPPER(TRIM("R"."R_NAME")) AS "REGION_NAME" @accepted_values("'AFRICA', 'AMERICA', 'ASIA', 'EUROPE', 'MIDDLE EAST'"),
    "N"."N_COMMENT" AS "NATION_COMMENT",
    "N"."N_LOAD_TIMESTAMP" AS "LOAD_TS"
FROM {{ ref('SRC', 'NATION') }} "N"
INNER JOIN {{ ref('SRC', 'REGION') }} "R"
    ON "N"."N_REGIONKEY" = "R"."R_REGIONKEY"
