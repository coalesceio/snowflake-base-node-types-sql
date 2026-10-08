@id("d5a70000-0000-4000-8000-000000000123")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d23001") @isBusinessKey,
     CAST("name" AS VARCHAR(25)) AS "NATION_NAME" @id("d23002"),
     "REGIONKEY" AS "REGION_KEY" @id("d23003"),
     "CommenT" AS "NATION_COMMENT" @id("d23004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d23008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d23009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
