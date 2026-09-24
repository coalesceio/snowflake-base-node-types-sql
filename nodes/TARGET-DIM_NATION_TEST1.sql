@id("62b53372-e9d4-4f1d-a68c-f68c1de85e9d")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST1_KEY" @id("c45b7d") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"          @id("18c039") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"               @id("946b60"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"          @id("8baccc"),
    "N_COMMENT"                              AS "N_COMMENT"            ,
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"     @id("f8be0e"),
    1                                        AS "SYSTEM_VERSION"       @id("445958") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("d601b6") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("6d249b") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("5a5d9b") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("8c8649") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"