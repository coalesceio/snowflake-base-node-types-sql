@id("d5a70000-0000-4000-8000-000000000235")
@nodeType("SQLFact")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f35001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f35002"),
     "REGIONKEY" AS "REGION_KEY" @id("f35003"),
     "CommenT" AS "NATION_COMMENT" @id("f35004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f35008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f35009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
