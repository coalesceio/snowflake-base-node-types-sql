@id("0f83521f-a980-4076-8d1e-2fb994d7b9fc")
@nodeType("SQLFact")
SELECT
    "GEOMETRY_ID"                        AS "GEOMETRY_ID"        @id("1c64df"),
    "G"                                  AS "G"                  @id("f92dd3") @isBusinessKey,
    "GEOMETRY_WKT"                       AS "GEOMETRY_WKT"       @id("42b04e"),
    "DESCRIPTION"                        AS "DESCRIPTION"        @id("8c8ee4"),
    "GEOMETRY_DIMENSION"                 AS "GEOMETRY_DIMENSION" @id("a4c748"),
    "SRID"                               AS "SRID"               @id("373b36"),
    "IS_VALID"                           AS "IS_VALID"           @id("fbe1f6"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("326bd2") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("0e782a") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_GEOMETRY') }} "WRK_GEOMETRY"