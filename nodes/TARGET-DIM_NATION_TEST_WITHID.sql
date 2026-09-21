@id("c85959df-cba4-489d-89ce-3ca7f05f58ba")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("db5acb") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("f097cb") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("2b3e84"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         @id("d37f61"),
    "N_COMMENT"                              AS "N_COMMENT"           @id("fef020"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("e3e1e8"),
    1                                        AS "SYSTEM_VERSION"      @id("83fb3c") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("718a90") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("5d74b6") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("9e970b") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("ff08ab") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"