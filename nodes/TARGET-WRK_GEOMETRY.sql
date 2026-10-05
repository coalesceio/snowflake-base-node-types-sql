@id("66609af2-1e8c-4346-9027-1ff6f1e84e1b")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
    {{ get_hash('GEOMETRY_ID', 'MD5') }}::STRING AS "GEOMETRY_ID"        @id("5e8d55") @not_null @uniqueness,
    "GEOMETRY_TABLE"."G"                         AS "G"                  @id("b651a3") @not_null,
    ST_ASWKT("GEOMETRY_TABLE"."G")               AS "GEOMETRY_WKT"       @id("d60e4d") @inHash("GEOMETRY_ID", 1),
    TRIM("GEOMETRY_TABLE"."DESCRIPTION")         AS "DESCRIPTION"        @id("19f774"),
    CAST(ST_DIMENSION("GEOMETRY_TABLE"."G") AS STRING)   AS "GEOMETRY_DIMENSION" @id("46e663") @accepted_values("0, 1, 2"),
    ST_SRID("GEOMETRY_TABLE"."G")                AS "SRID"               @id("8bda19"),
    CAST(ST_ISVALID("GEOMETRY_TABLE"."G") AS STRING) AS "IS_VALID"           @id("a88b25")
FROM {{ ref('SRC', 'GEOMETRY_TABLE') }} "GEOMETRY_TABLE"
