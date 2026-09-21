@id("bbb2bdef-6c1d-4e03-9dcc-ccede71b8537")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("85cff9") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("7c0a0e"),
    "N_NAME"                                 AS "N_NAME"              @id("dd209d"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         ,
    "N_COMMENT"                              AS "N_COMMENT"           @id("7a9b84"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("1da5c8"),
    1                                        AS "SYSTEM_VERSION"      @id("06a113") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("0ae5b2") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("69eeda") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("40c604") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("c988c4") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"