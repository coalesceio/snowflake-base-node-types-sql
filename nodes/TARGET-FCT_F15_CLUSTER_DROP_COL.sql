@id("d5a70000-0000-4000-8000-000000000215")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f15001") @isBusinessKey @clusterKey(2),
     "name" AS "NATION_NAME" @id("f15002"),
     "CommenT" AS "NATION_COMMENT" @id("f15004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f15008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f15009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
