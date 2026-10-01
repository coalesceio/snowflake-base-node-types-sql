@id("7e57a000-0000-4000-8000-000000000017")
@nodeType("724")
@mergeStrategy("allColumnMatch")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea171"),
    "name"                                   AS "name"                @id("7ea172"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea173"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea174"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea17e") @isSystemCreateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
