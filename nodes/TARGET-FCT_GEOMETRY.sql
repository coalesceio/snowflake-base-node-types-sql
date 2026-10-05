@id("93b57387-d57f-463e-90bd-9d4e5c61ae22")
@nodeType("SQLFact")
@mergeStrategy("changeTracking")
SELECT
    "DIM_GEOMETRY"."GEOMETRY_ID"          AS "GEOMETRY_ID"        @id("7a11ca") @isBusinessKey @not_null,
    "DIM_GEOMETRY"."DIM_GEOMETRY_KEY"     AS "DIM_GEOMETRY_KEY"   @id("cee928") @not_null,
    "DIM_GEOMETRY"."GEOMETRY_CLASS"       AS "GEOMETRY_CLASS"     @id("975fa1"),
    ST_NPOINTS("DIM_GEOMETRY"."G")        AS "POINT_COUNT"        @id("587dac") @min_value("1"),
    ST_AREA("DIM_GEOMETRY"."G")           AS "AREA"               @id("fbe70c") @min_value("0"),
    ST_PERIMETER("DIM_GEOMETRY"."G")      AS "PERIMETER"          @id("5a5f05") @min_value("0"),
    ST_LENGTH("DIM_GEOMETRY"."G")         AS "LENGTH"             @id("fea85b") @min_value("0"),
    ST_X(ST_CENTROID("DIM_GEOMETRY"."G")) AS "CENTROID_X"         @id("5b71c2"),
    ST_Y(ST_CENTROID("DIM_GEOMETRY"."G")) AS "CENTROID_Y"         @id("e03cd5"),
    ST_XMIN("DIM_GEOMETRY"."G")           AS "X_MIN"              @id("2a801b"),
    ST_XMAX("DIM_GEOMETRY"."G")           AS "X_MAX"              @id("b6c3f1"),
    ST_YMIN("DIM_GEOMETRY"."G")           AS "Y_MIN"              @id("ef8372"),
    ST_YMAX("DIM_GEOMETRY"."G")           AS "Y_MAX"              @id("0c305b"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)  AS "SYSTEM_CREATE_DATE" @id("df7219") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP)  AS "SYSTEM_UPDATE_DATE" @id("e51609") @isSystemUpdateDate
FROM {{ ref('TARGET', 'DIM_GEOMETRY') }} "DIM_GEOMETRY"
WHERE "DIM_GEOMETRY"."SYSTEM_CURRENT_FLAG" = 'Y'
  AND "DIM_GEOMETRY"."DIM_GEOMETRY_KEY" <> 0
