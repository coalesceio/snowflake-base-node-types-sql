@id("52557349-6aa9-449b-93af-a92f16d4da09")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("3f61c2") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("d16aa3") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("d84a93"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         @id("c69950"),
    "N_COMMENT"                              AS "N_COMMENT"           @id("def87c"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("3bad57"),
    1                                        AS "SYSTEM_VERSION"      @id("36835c") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("d03748") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("af3512") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("deccbf") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("84af63") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"