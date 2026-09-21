@id("a5daf323-8e0b-44e7-88cf-ea59112d12ff")
@nodeType("718")
SELECT
    0                                        AS "DIM_NATION_TEST5_KEY" @id("0409b9") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"          @id("f3257c"),
    "N_NAME"                                 AS "N_NAME"               ,
    "N_REGIONKEY"                            AS "N_REGIONKEY"          @id("75a033"),
    "N_COMMENT"                              AS "N_COMMENT"            @id("75a779"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"     @id("f17589"),
    1                                        AS "SYSTEM_VERSION"       @id("b79e5c") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("d69610") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("368277") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("815054") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("292075") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"