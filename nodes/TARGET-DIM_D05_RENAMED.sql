@id("d5a70000-0000-4000-8000-000000000105")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d05001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d05002"),
     "REGIONKEY" AS "REGION_KEY" @id("d05003"),
     "CommenT" AS "NATION_COMMENT" @id("d05004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d05008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d05009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
