@id("d5a70000-0000-4000-8000-000000000205")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f05001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f05002"),
     "REGIONKEY" AS "REGION_KEY" @id("f05003"),
     "CommenT" AS "NATION_COMMENT" @id("f05004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f05008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f05009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
