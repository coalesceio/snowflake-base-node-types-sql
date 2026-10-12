@id("fd92ab41-c52d-44cf-95ed-e3f75c7a4b61")
@nodeType("SQLDimension")
@materializationType("table")
@description("Sales star - nation/region dimension (change tracking, SCD1) with zero key")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tests("SELECT NATION_KEY FROM {{ ref('TARGET', 'WRK_GEOGRAPHY') }} GROUP BY NATION_KEY HAVING COUNT(*) > 1 OR NATION_KEY IS NULL", false, "Before")
SELECT
    0 AS "DIM_NATION_KEY" @id("f115dbc7-738e-4304-9c1a-39f555b822be") @isSurrogateKey,
    "G"."NATION_KEY" AS "NATION_KEY" @id("931fe599-ac91-401d-9618-2288fbe5a9a1") @isBusinessKey,
    "G"."NATION_NAME" AS "NATION_NAME" @id("d638f271-b0c3-4416-933d-6eb626529c74"),
    "G"."REGION_KEY" AS "REGION_KEY" @id("28fb779d-1cc5-47d3-84ca-edbd91d32d6f"),
    "G"."REGION_NAME" AS "REGION_NAME" @id("8ce57dcf-7480-48fa-845b-ffc5c1e40384"),
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("661e9035-5549-409c-ac77-d59cd655865b") @isSystemCreateDate,
    CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("424a6d79-f13c-4a43-8853-b36b1a073c22") @isSystemUpdateDate
FROM {{ ref('TARGET', 'WRK_GEOGRAPHY') }} "G"
