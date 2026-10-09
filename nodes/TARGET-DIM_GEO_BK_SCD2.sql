@id("7d6a0e21-3c4b-4f8e-a1d2-000000000001")
@nodeType("Latest220:::SQLDimension")
@description("TEST: GEOGRAPHY + GEOMETRY as business keys, NAME tracked (SCD2)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_GEO_BK_SCD2_KEY"  @id("7d1a01") @isSurrogateKey,
    "ID"                                     AS "ID"                   @id("7d1a02"),
    "NAME"                                   AS "NAME"                 @id("7d1a03") @isChangeTracking,
    "LOCATION_GEO"                           AS "LOCATION_GEO"         @id("7d1a04") @isBusinessKey,
    "LOCATION_GEOM"                          AS "LOCATION_GEOM"        @id("7d1a05") @isBusinessKey,
    1                                        AS "SYSTEM_VERSION"       @id("7d1a06") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("7d1a07") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("7d1a08") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("7d1a09") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"      @id("7d1a0a") @isSystemEndDate
FROM {{ ref('SRC', 'TEST_GEO_GEOMETRY') }} "TEST_GEO_GEOMETRY"
