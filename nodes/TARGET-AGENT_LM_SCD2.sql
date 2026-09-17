@id("c7e2a9f4-5d1b-4a6c-9f3e-8b0d4c7a2e15")
@nodeType("4a720337-2713-45a5-b3f2-2d47d7abe3e5")
@mergeStrategy("lastModified")
SELECT
    "NATION_TEST".N_NATIONKEY                AS "BUSINESS_KEY"        @isBusinessKey,
    "NATION_TEST".N_NAME                     AS "NATION_NAME",
    "NATION_TEST".N_REGIONKEY                AS "REGION_KEY",
    "NATION_TEST".N_COMMENT                  AS "COMMENT",
    "NATION_TEST".N_LOAD_TIMESTAMP           AS "LOAD_TIMESTAMP"      @lastModifiedTracking(2),
    0                                         AS "DIM_NATION_TEST_KEY" @isSurrogateKey,
    1                                         AS "SYSTEM_VERSION"      @isSystemVersion,
    'Y'                                       AS "SYSTEM_CURRENT_FLAG" @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"  @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"  @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"     @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
