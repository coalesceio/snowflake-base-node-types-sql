@id("d5a70000-0000-4000-8000-000000000216")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f16001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("f16002"),
     "REGIONKEY" AS "REGION_KEY" @id("f16003") @clusterKey(2),
     "CommenT" AS "NATION_COMMENT" @id("f16004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f16008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f16009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
