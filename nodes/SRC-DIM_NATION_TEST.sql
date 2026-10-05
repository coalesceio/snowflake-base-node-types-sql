@id("98c97019-2f23-4dba-a8b5-f820fe174b63")
@nodeType("SQLDimension")
@mergeStrategy("lastModified")
@zeroKey(0)
SELECT
    0                                        AS "DIM_NATION_TEST_KEY" @id("91186b") @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY"         @id("91186c") @isBusinessKey,
    "N_NAME"                                 AS "N_NAME"              @id("003d0c") @zeroKey("'N/A'"),
    "N_REGIONKEY"                            AS "N_REGIONKEY"         @id("e6743a"),
    "N_COMMENT"                              AS "N_COMMENT"           @id("5692c2"),
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP"    @id("f1edf1") @lastModifiedTracking(2),
    1                                        AS "SYSTEM_VERSION"      @id("3510ef") @isSystemVersion,
    'Y' AS "SYSTEM_CURRENT_FLAG" @id("3510ee") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @id("b39f48") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @id("5a0570") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @id("3febed") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"