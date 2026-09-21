@id("921c0082-4cbf-4c06-9bc2-44ac1eb610b4")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("84c777") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("b984ac") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("f89631"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         @id("fc338a"),
    "N_COMMENT"                              AS "N_COMMENT"           @id("69476b"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("8a0dd6"),
    1                                        AS "SYSTEM_VERSION"      @id("0bc025") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("34aa68") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("188130") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("1ff074") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("3237f6") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"