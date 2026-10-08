@id("d5a70000-0000-4000-8000-000000000113")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d13001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d13002"),
     "REGIONKEY" AS "REGION_KEY" @id("d13003"),
     "CommenT" AS "NATION_COMMENT" @id("d13004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d13008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d13009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
