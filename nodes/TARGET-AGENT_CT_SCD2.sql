@id("f3b8a1c2-6e7d-4a9b-8c1f-2d5e9a7b4c60")
@nodeType("718")
@deployDisabled
-- WARNING: skips column ID checks. This stays as-is for the complete lifecycle of this node once created — don't remove unless every column has a real system-generated ID.
@disableIDs
@mergeStrategy("changeTracking")
SELECT
    "NATION_TEST".N_NATIONKEY               AS "BUSINESS_KEY"          @isBusinessKey,
    "NATION_TEST".N_NAME                    AS "NATION_NAME"           @isChangeTracking,
    "NATION_TEST".N_REGIONKEY               AS "REGION_KEY"            @isChangeTracking,
    "NATION_TEST".N_COMMENT                 AS "COMMENT",
    0                                        AS "DIM_NATION_TEST_KEY"   @isSurrogateKey,
    1                                        AS "SYSTEM_VERSION"        @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"   @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"    @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"    @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"       @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
