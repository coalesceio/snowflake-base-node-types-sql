@id("7e57a000-0000-4000-8000-000000000015")
@nodeType("724")
@tests("SELECT 1 FROM (SELECT COUNT(*) AS C FROM {{ this }}) WHERE C <> (SELECT COUNT(*) FROM {{ ref('SRC', 'Nation_Test') }})")
SELECT
    "NAtionKey"                              AS "NAtionKey"           @id("7ea151"),
    "name"                                   AS "name"                @id("7ea152"),
    "REGIONKEY"                              AS "REGIONKEY"           @id("7ea153"),
    "N_Load_Timestamp"                       AS "N_Load_Timestamp"    @id("7ea154"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("7ea15e") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7ea15f") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
