@id("7e57a000-0000-4000-8000-000000000010")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
@writeMode("truncateInsert")
@description("Phase A: annotations present")
@preSQL("SELECT CURRENT_TIMESTAMP AS PRE_SQL_RAN")
@postSQL("SELECT COUNT(*) AS POST_SQL_ROWS FROM {{ this }}")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea101") @isBusinessKey @not_null @uniqueness,
    "name"                                   AS "name"                @id("7ea102") @not_null @empty,
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea103") @accepted_values("0, 1, 2, 3, 4"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea104"),
    LENGTH("name")                           AS "NAME_LENGTH"         @id("7ea105") @description("Characters in the nation name") @min_value("1"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea10e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7ea10f") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
