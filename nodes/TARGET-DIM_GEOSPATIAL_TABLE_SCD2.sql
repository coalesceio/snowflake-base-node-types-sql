@id("5c97a422-5665-48bd-ac62-0804b5fcfdd0")
@nodeType("718")
@mergeStrategy("changeTracking")
SELECT
    0                                        AS "DIM_GEOSPATIAL_TABLE_SCD2_KEY" @id("825925") @isSurrogateKey,
    "ID"                                     AS "ID"                            @id("51b516") @isBusinessKey,
    "G"                                      AS "G"                             @id("095db2") @isChangeTracking,
    "DESCRIPTION"                            AS "DESCRIPTION"                   @id("a3f0dc"),
    1                                        AS "SYSTEM_VERSION"                @id("55fe97") @isSystemVersion,
    'Y'                                      AS "SYSTEM_CURRENT_FLAG"           @id("1eff1d") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_CREATE_DATE"            @id("95c03c") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)     AS "SYSTEM_UPDATE_DATE"            @id("6540ae") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE"               @id("796020") @isSystemEndDate
FROM {{ ref('SRC2', 'GEOSPATIAL_TABLE') }} "GEOSPATIAL_TABLE"
