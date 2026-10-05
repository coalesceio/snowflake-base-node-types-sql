@id("7e57a000-0000-4000-8000-000000000008")
@nodeType("SQLFact")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NAtionKey1"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey1"           @id("7ea081") @isBusinessKey,
    "name"                                   AS "name1"                @id("7ea082"),
    UPPER("name")                            AS "name_Caps1"           @id("7ea042"),
    "REGIONKEY"                              AS "REGIONKEY1"           @id("7ea083"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp1"    @id("7ea084"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE1"  @id("7ea08e") @isSystemCreateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
