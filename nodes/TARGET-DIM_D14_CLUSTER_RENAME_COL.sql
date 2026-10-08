@id("d5a70000-0000-4000-8000-000000000114")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_ID" @id("d14001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d14002"),
     "REGIONKEY" AS "REGION_KEY" @id("d14003"),
     "CommenT" AS "NATION_COMMENT" @id("d14004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d14008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d14009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
