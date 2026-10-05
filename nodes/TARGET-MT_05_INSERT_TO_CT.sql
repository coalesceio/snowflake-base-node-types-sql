@id("7e57a000-0000-4000-8000-000000000005")
@nodeType("SQLFact")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> 2 * (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea051"),
    "name"                                   AS "name"                @id("7ea052"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea053"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea054"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea05e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7ea05f") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
