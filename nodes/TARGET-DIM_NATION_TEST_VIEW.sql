@id("ea827314-b477-4a98-9d64-db61d17d8602")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@materializationType("view")
SELECT
    0                                        AS "DIM_NATION_TEST3_KEY" @isSurrogateKey,
    "N_NATIONKEY"                            AS "N_NATIONKEY",
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
