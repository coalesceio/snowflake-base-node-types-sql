@id("d5a70000-0000-4000-8000-000000000121")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d21001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d21002"),
     "REGIONKEY" AS "REGION_KEY" @id("d21003"),
     "CommenT" AS "NATION_COMMENT" @id("d21004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d21008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d21009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
