@id("721d78c5-5ddc-4473-8204-5d0f15a368b8")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("4c707a") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("14423c") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("f92daf"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         ,
    "N_COMMENT"                              AS "N_COMMENT"           @id("c7ce27"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("505a3f"),
    1                                        AS "SYSTEM_VERSION"      @id("3a132b") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("b3132f") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("c17775") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("b86055") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("68aa7c") @isSystemEndDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("68aa7y") @isSystemEndDate

FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"