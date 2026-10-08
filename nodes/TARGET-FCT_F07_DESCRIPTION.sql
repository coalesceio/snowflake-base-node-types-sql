@id("d5a70000-0000-4000-8000-000000000207")
@nodeType("SQLFact")
@materializationType("table")
@description("F07: original")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f07001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f07002"),
     "REGIONKEY" AS "REGION_KEY" @id("f07003"),
     "CommenT" AS "NATION_COMMENT" @id("f07004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f07008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f07009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
