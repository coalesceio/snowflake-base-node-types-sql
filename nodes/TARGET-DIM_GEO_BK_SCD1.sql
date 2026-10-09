@id("7d6a0e21-3c4b-4f8e-a1d2-000000000002")
@nodeType("SQLDimension")
@description("TEST: GEOGRAPHY + GEOMETRY as business keys, nothing tracked (SCD1)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_GEO_BK_SCD1_KEY"  @id("7d2a01") @isSurrogateKey,
    "ID"                                     AS "ID"                   @id("7d2a02"),
    "NAME"                                   AS "NAME"                 @id("7d2a03"),
    "LOCATION_GEO"                           AS "LOCATION_GEO"         @id("7d2a04") @isBusinessKey,
    "LOCATION_GEOM"                          AS "LOCATION_GEOM"        @id("7d2a05") @isBusinessKey,
    1                                        AS "SYSTEM_VERSION"       @id("7d2a06") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("7d2a07") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("7d2a08") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("7d2a09") @isSystemUpdateDate
FROM {{ ref('SRC', 'TEST_GEO_GEOMETRY') }} "TEST_GEO_GEOMETRY"
