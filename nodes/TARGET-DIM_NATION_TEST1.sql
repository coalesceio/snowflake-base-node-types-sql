@id("a8a64a3f-44de-49b5-8d93-a09eb93ebe89")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST1_KEY" @id("da385c") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY_1"          @id("11c2e2") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME_1"               @id("00270b"),
    "N_REGIONKEY"                            AS "N_REGIONKEY_1"          @id("abcafd"),
    "N_COMMENT"                              AS "N_COMMENT_1"            @id("6e8a9a"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP_1"     @id("846c6f"),
    1                                        AS "SYSTEM_VERSION"       @id("0b0038") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("19f1c8") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("a80c9d") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("734b45") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("f11a34") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"