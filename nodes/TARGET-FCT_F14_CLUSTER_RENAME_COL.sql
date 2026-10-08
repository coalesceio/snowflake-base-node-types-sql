@id("d5a70000-0000-4000-8000-000000000214")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f14001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("f14002"),
     "REGIONKEY" AS "REGION_KEY" @id("f14003"),
     "CommenT" AS "NATION_COMMENT" @id("f14004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f14008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f14009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
