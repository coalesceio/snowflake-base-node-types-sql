@id("327e2d63-c93e-4d50-b654-cd52db6b2ea6")
@nodeType("718")
@disableIDs     -- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created.
SELECT
    0                                        AS "DIM_NATION_TEST2_KEY" @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY" @isBusinessKey,
    "N_NAME"                                 AS "N_NAME",
    "N_REGIONKEY"                            AS "N_REGIONKEY",
    "N_COMMENT"                              AS "N_COMMENT",
    "N_LOAD_TIMESTAMP"                       AS "N_LOAD_TIMESTAMP",
    1                                        AS "SYSTEM_VERSION"       @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"