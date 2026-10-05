@id("7e57a000-0000-4000-8000-000000000102")
@nodeType("SQLFact")
@mergeStrategy("lastModified")
@writeMode("append")
@description("Fact test: lastModified merge on NATION_KEY tracking SOURCE_LOAD_TS, with node and column tests")
@preSQL("SELECT MAX(""N_Load_Timestamp"") AS MAX_SOURCE_TS FROM {{ ref('SRC', 'Nation_Test') }}")
@postSQL("SELECT MAX(""SOURCE_LOAD_TS"") AS MAX_TARGET_TS FROM {{ this }}")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} WHERE ""N_Load_Timestamp"" IS NULL", false, "Before")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} t JOIN {{ ref('SRC', 'Nation_Test') }} s ON t.""NATION_KEY"" = s.""NAtionKey"" WHERE t.""SOURCE_LOAD_TS"" < s.""N_Load_Timestamp""", true, "After")
SELECT
    "NAtionKey"                          AS "NATION_KEY"         @id("f10201") @isBusinessKey @not_null @uniqueness @min_value("0"),
    UPPER("name")                        AS "NATION_NAME"        @id("f10202") @not_null @empty,
    "REGIONKEY"                          AS "REGION_KEY"         @id("f10203") @accepted_values("0, 1, 2, 3, 4") @min_max("0", "4"),
    "CommenT"                            AS "NATION_COMMENT"     @id("f10204") @empty,
    "N_Load_Timestamp"                   AS "SOURCE_LOAD_TS"     @id("f10205") @lastModifiedTracking @not_null @max_value("CURRENT_TIMESTAMP") @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f1020e") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f1020f") @isSystemUpdateDate @not_null @freshness(12, "HOUR")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
