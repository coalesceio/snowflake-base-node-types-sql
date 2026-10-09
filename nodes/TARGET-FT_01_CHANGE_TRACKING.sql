@id("7e57a000-0000-4000-8000-000000000101")
@nodeType("Latest220:::SQLFact")
@mergeStrategy("changeTracking")
@writeMode("append")
@description("Fact test: changeTracking (SCD Type 1) merge on NATION_KEY with node and column tests")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@preSQL("SELECT COUNT(*) AS SOURCE_ROWS FROM {{ ref('SRC', 'Nation_Test') }}")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} WHERE ""NAtionKey"" IS NULL", true, "Before")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NATION_KEY"" HAVING COUNT(*) > 1", true, "After")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                          AS "NATION_KEY"         @id("f10101") @isBusinessKey @not_null @uniqueness @min_max("0", "24") @inHash("GH_NATION", 1),
    "name"                               AS "NATION_NAME"        @id("f10102") @not_null @empty @rejected_values("'UNKNOWN', 'N/A'") @inHash("GH_NATION", 2),
    "REGIONKEY"                          AS "REGION_KEY"         @id("f10103") @not_null @accepted_values("0, 1, 2") @accepted_values("3", "4") @inHash("GH_NATION", 3),
    "CommenT"                            AS "NATION_COMMENT"     @id("f10104") @description("Free-text nation comment"),
    "N_Load_Timestamp"                   AS "SOURCE_LOAD_TS"     @id("f10105") @not_null @max_value("CURRENT_TIMESTAMP"),
    LENGTH("name")                       AS "NAME_LENGTH"        @id("f10106") @description("Characters in the nation name") @min_value("1") @max_value("25"),
    {{ get_hash('GH_NATION') }}::STRING  AS "GH_NATION"          @id("f10107") @not_null @uniqueness,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f1010e") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f1010f") @isSystemUpdateDate @not_null @freshness(1, "DAY")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
