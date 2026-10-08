@id("d5a70000-0000-4000-8000-000000000212")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f12001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f12002"),
     "REGIONKEY" AS "REGION_KEY" @id("f12003"),
     "CommenT" AS "NATION_COMMENT" @id("f12004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f12008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f12009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
