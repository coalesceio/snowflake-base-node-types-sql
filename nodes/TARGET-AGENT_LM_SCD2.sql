@id("c7e2a9f4-5d1b-4a6c-9f3e-8b0d4c7a2e15")
@nodeType("718")
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real @id("xxxxx").
@disableIDs
@mergeStrategy("lastModified")
@zeroKey("0", "PNKNOWN", "1900-01-01 00:00:00", "true")
SELECT
    "NATION_TEST".N_NATIONKEY                AS "BUSINESS_KEY"        @isBusinessKey,
    "NATION_TEST".N_NAME                     AS "NATION_NAME" @zeroKey("NA"),
    "NATION_TEST".N_REGIONKEY                AS "REGION_KEY" @zeroKey("100"),
    "NATION_TEST".N_COMMENT                  AS "COMMENT",
    "NATION_TEST".N_LOAD_TIMESTAMP           AS "LOAD_TIMESTAMP"      @lastModifiedTracking(2),
    0                                         AS "DIM_NATION_TEST_KEY" @isSurrogateKey,
    1                                         AS "SYSTEM_VERSION"      @isSystemVersion,
    'Y'                                       AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
