@id("d5a70000-0000-4000-8000-000000000203")
@nodeType("SQLFact")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f03001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f03002"),
     "REGIONKEY" AS "REGION_KEY" @id("f03003"),
     "CommenT" AS "NATION_COMMENT" @id("f03004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f03008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f03009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
