@id("7e57a000-0000-4000-8000-000000000105")
@nodeType("SQLFact")
@writeMode("truncateInsert")
@description("Fact test: plain insert (no merge strategy, no business key) - truncated and reloaded each run")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
@postSQL("SELECT MIN(""SYSTEM_CREATE_DATE"") AS FIRST_LOAD, MAX(""SYSTEM_CREATE_DATE"") AS LAST_LOAD FROM {{ this }}")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ ref('SRC', 'Nation_Test_CamelCase') }}) WHERE C = 0", false, "Before")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test_CamelCase') }})")
@tests("SELECT 1 FROM {{ this }} WHERE ""NATION_LABEL"" NOT LIKE ""NATION_NAME"" || '%'", true, "After")
SELECT
    "NAtionKey"                                  AS "NATION_KEY"         @id("f10501") @not_null @uniqueness @min_value("0") @max_value("24"),
    "name"                                       AS "NATION_NAME"        @id("f10502") @not_null @empty @inHash("GH_ROW", 2),
    "REGIONKEY"                                  AS "REGION_KEY"         @id("f10503") @accepted_values("0") @accepted_values("1, 2, 3, 4") @rejected_values("5, 99") @inHash("GH_ROW", 1),
    "name" || ' (R' || "REGIONKEY" || ')'        AS "NATION_LABEL"       @id("f10504") @description("Display label: name plus region") @not_null @empty,
    "N_Load_Timestamp"                           AS "SOURCE_LOAD_TS"     @id("f10505") @max_value("CURRENT_TIMESTAMP") @relative_time("<=", "SYSTEM_CREATE_DATE"),
    {{ get_hash('GH_ROW', 'MD5', '|') }}::STRING AS "GH_ROW"             @id("f10506") @not_null @uniqueness,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)         AS "SYSTEM_CREATE_DATE" @id("f1050e") @isSystemCreateDate @not_null @freshness(1, "HOUR")
FROM {{ ref('SRC', 'Nation_Test_CamelCase') }} "Nation_Test_CamelCase"
