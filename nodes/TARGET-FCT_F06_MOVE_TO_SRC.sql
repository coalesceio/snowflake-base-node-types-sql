@id("d5a70000-0000-4000-8000-000000000206")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f06001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f06002"),
     "REGIONKEY" AS "REGION_KEY" @id("f06003"),
     "CommenT" AS "NATION_COMMENT" @id("f06004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f06008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f06009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
