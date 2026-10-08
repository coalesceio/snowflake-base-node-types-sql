@id("d5a70000-0000-4000-8000-000000000124")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d24001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d24002"),
     "REGIONKEY" AS "REGION_KEY" @id("d24003"),
     "CommenT" AS "NATION_COMMENT" @id("d24004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d24008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d24009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
