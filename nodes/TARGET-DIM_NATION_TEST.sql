@id("c670d46f-5306-4d99-ab5c-a76b1a3f9bea")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("ce304f") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("7d6e35") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("aee942"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         ,
    "N_COMMENT"                              AS "N_COMMENT"           @id("04055a"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("12df4d"),
    1                                        AS "SYSTEM_VERSION"      @id("0c28af") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG" @id("76068f") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("3afd97") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("7d3b98") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("6e8253") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"