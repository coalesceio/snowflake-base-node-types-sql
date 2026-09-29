@id("7d6a0e21-3c4b-4f8e-a1d2-000000000004")
@nodeType("718")
@description("TEST: GEOGRAPHY + GEOMETRY as plain columns, ID business key (SCD1)")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_GEO_NONBK_SCD1_KEY" @id("7d4a01") @isSurrogateKey,
    "ID"                                     AS "ID"                   @id("7d4a02") @isBusinessKey,
    "NAME"                                   AS "NAME"                 @id("7d4a03"),
    "LOCATION_GEO"                           AS "LOCATION_GEO"         @id("7d4a04"),
    "LOCATION_GEOM"                          AS "LOCATION_GEOM"        @id("7d4a05"),
    1                                        AS "SYSTEM_VERSION"       @id("7d4a06") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"  @id("7d4a07") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"   @id("7d4a08") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"   @id("7d4a09") @isSystemUpdateDate
FROM {{ ref('SRC', 'TEST_GEO_GEOMETRY') }} "TEST_GEO_GEOMETRY"
