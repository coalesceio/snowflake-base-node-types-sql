@id("d5a70000-0000-4000-8000-000000000227")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("upsert")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f27001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f27002"),
     "REGIONKEY" AS "REGION_KEY" @id("f27003"),
     "CommenT" AS "NATION_COMMENT" @id("f27004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f27008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f27009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
