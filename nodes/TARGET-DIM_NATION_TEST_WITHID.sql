@id("9f68afb8-4848-4dce-8508-3e2cb7b1e7e4")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST1_KEY" @id("5df2fd") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"          @id("e2f691") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"               @id("3c818f"),
    "N_REGIONKEY"                            AS "N_REGIONKEY_RENAME"          @id("d916b6"),
    "N_COMMENT"                              AS "N_COMMENT"            @id("802956"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"     @id("317113"),
    1                                        AS "SYSTEM_VERSION"       @id("5e6791") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("3c0863") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("6edf2d") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("aba3d8") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("823324") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"