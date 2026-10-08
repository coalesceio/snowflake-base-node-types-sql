@id("d5a70000-0000-4000-8000-000000000225")
@nodeType("SQLFact")
@materializationType("Table ")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f25001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f25002"),
     "REGIONKEY" AS "REGION_KEY" @id("f25003"),
     "CommenT" AS "NATION_COMMENT" @id("f25004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f25008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f25009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
