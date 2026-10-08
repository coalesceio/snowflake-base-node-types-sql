@id("d5a70000-0000-4000-8000-000000000116")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d16001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d16002"),
     "REGIONKEY" AS "REGION_KEY" @id("d16003") @clusterKey(2),
     "CommenT" AS "NATION_COMMENT" @id("d16004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d16008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d16009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
