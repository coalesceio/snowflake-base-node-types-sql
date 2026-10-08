@id("d5a70000-0000-4000-8000-000000000213")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f13001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("f13002"),
     "REGIONKEY" AS "REGION_KEY" @id("f13003"),
     "CommenT" AS "NATION_COMMENT" @id("f13004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f13008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f13009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
