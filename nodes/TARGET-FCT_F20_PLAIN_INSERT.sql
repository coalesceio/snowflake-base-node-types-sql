@id("d5a70000-0000-4000-8000-000000000220")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f20001"),
     "name" AS "NATION_NAME" @id("f20002"),
     "REGIONKEY" AS "REGION_KEY" @id("f20003"),
     "CommenT" AS "NATION_COMMENT" @id("f20004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f20008") @isSystemCreateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
