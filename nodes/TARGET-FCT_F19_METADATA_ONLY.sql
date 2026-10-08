@id("d5a70000-0000-4000-8000-000000000219")
@nodeType("SQLFact")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f19001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f19002"),
     "REGIONKEY" AS "REGION_KEY" @id("f19003"),
     "CommenT" AS "NATION_COMMENT" @id("f19004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f19008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f19009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
