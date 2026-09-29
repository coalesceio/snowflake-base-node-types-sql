@id("f3a27087-6fb2-41db-9af1-d7549eb59ded")
@nodeType("718")
SELECT
    0                                        AS "DIM_GEOMETRY_TABLE_KEY" @id("231c30") @isSurrogateKey,
    "G"                                      AS "G"                      @id("b26553") @isBusinessKey,
    "DESCRIPTION"                            AS "DESCRIPTION"            @id("9a525c"),
    1                                        AS "SYSTEM_VERSION"         @id("e18dc3") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"    @id("b1e84c") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"     @id("9135d5") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"     @id("bb6a87") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"        @id("de0dee") @isSystemEndDate
FROM {{ ref('SRC2', 'GEOMETRY_TABLE') }} "GEOMETRY_TABLE"