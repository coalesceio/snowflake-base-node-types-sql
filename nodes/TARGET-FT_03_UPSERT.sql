@id("7e57a000-0000-4000-8000-000000000103")
@nodeType("Latest220:::SQLFact")
@mergeStrategy("upsert")
@writeMode("append")
@description("Fact test: upsert merge on composite key NATION_KEY + REGION_KEY, system columns computed in the SELECT")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT ""REGION_KEY"", COUNT(*) AS NATIONS FROM {{ this }} GROUP BY ""REGION_KEY""")
@tests("SELECT 1 FROM {{ ref('SRC', 'Nation_Test') }} GROUP BY ""NAtionKey"", ""REGIONKEY"" HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NATION_KEY"", ""REGION_KEY"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM {{ this }} WHERE ""NATION_NAME"" <> UPPER(""NATION_NAME"")", true, "After")
SELECT
    "NAtionKey"                           AS "NATION_KEY"         @id("f10301") @isBusinessKey @not_null @uniqueness @min_max("0", "24"),
    "REGIONKEY"                           AS "REGION_KEY"         @id("f10302") @isBusinessKey @not_null @accepted_values("0", "1", "2", "3", "4") @rejected_values("-1"),
    UPPER(TRIM("name"))                   AS "NATION_NAME"        @id("f10303") @not_null @empty @rejected_values("'UNKNOWN'"),
    "CommenT"                             AS "NATION_COMMENT"     @id("f10304"),
    LENGTH("CommenT")                     AS "COMMENT_LENGTH"     @id("f10305") @description("Characters in the comment") @min_value("0") @max_value("152"),
    "N_Load_Timestamp"                    AS "SOURCE_LOAD_TS"     @id("f10306") @max_value("CURRENT_TIMESTAMP"),
    CAST("N_Load_Timestamp" AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f1030e") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_UPDATE_DATE"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)  AS "SYSTEM_UPDATE_DATE" @id("f1030f") @isSystemUpdateDate @not_null @freshness(1, "DAY")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
