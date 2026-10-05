@id("4ab9c524-9352-4440-8abe-f7e66b8faadc")
@nodeType("718")
@mergeStrategy("changeTracking")
@zeroKey("0")
@tests("SELECT 1 FROM {{ ref('TARGET', 'WRK_GEOMETRY') }} GROUP BY GEOMETRY_ID HAVING COUNT(*) > 1", false, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY GEOMETRY_ID HAVING COUNT(*) > 1", false, "After")
SELECT
    0                                                                                                                      AS "DIM_GEOMETRY_KEY"    @id("1f88dc") @isSurrogateKey,
    "WRK_GEOMETRY"."GEOMETRY_ID"                                                                                           AS "GEOMETRY_ID"         @id("a2f975") @isBusinessKey @not_null,
    "WRK_GEOMETRY"."G"                                                                                                     AS "G"                   @id("52499f") @zeroKey("TO_GEOMETRY('POINT(0 0)')"),
    "WRK_GEOMETRY"."GEOMETRY_WKT"                                                                                          AS "GEOMETRY_WKT"        @id("0a26d1"),
    "WRK_GEOMETRY"."DESCRIPTION"                                                                                           AS "DESCRIPTION"         @id("032118") @isChangeTracking,
    CASE "WRK_GEOMETRY"."GEOMETRY_DIMENSION" WHEN 0 THEN 'POINT' WHEN 1 THEN 'LINE' WHEN 2 THEN 'POLYGON' ELSE 'OTHER' END AS "GEOMETRY_CLASS"      @id("958c91"),
    "WRK_GEOMETRY"."SRID"                                                                                                  AS "SRID"                @id("67ae86"),
    "WRK_GEOMETRY"."IS_VALID"                                                                                              AS "IS_VALID"            @id("e26415"),
    1                                                                                                                      AS "SYSTEM_VERSION"      @id("6863a3") @isSystemVersion,
    'Y'                                                                                                                    AS "SYSTEM_CURRENT_FLAG" @id("2e0c61") @isSystemCurrentFlag,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                                                                   AS "SYSTEM_CREATE_DATE"  @id("cf0622") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)                                                                                   AS "SYSTEM_UPDATE_DATE"  @id("43ba7f") @isSystemUpdateDate,
    CAST('2999-12-31 00:00:00' AS TIMESTAMP)                                                                               AS "SYSTEM_END_DATE"     @id("b8f64c") @isSystemEndDate
FROM {{ ref('TARGET', 'WRK_GEOMETRY') }} "WRK_GEOMETRY"
