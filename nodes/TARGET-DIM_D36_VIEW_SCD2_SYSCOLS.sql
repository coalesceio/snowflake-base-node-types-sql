@id("d5a70000-0000-4000-8000-000000000136")
@nodeType("SQLDimension")
@materializationType("view")
SELECT
     "NAtionKey" * 100 AS "DIM_SK" @id("d3600b") @isSurrogateKey,
     "NAtionKey" AS "NATION_KEY" @id("d36001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d36002") @isChangeTracking,
     "REGIONKEY" AS "REGION_KEY" @id("d36003"),
     "CommenT" AS "NATION_COMMENT" @id("d36004"),
     1 AS "SYSTEM_VERSION" @id("d36005") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("d36006") @isSystemCurrentFlag,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d36007") @isSystemEndDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d36008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d36009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
