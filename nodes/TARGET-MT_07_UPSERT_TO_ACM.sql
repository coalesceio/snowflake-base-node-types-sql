@id("7e57a000-0000-4000-8000-000000000007")
@nodeType("SQLFact")
@mergeStrategy("upsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY ""NAtionKey"" HAVING COUNT(*) > 1")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea071") @isBusinessKey,
    "name"                                   AS "name"                @id("7ea072"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea073"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea074"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea07e") @isSystemCreateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
