@id("d5a70000-0000-4000-8000-000000000226")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("allColumnMatch")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f26001"),
     "REGIONKEY" AS "REGION_KEY" @id("f26003"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f26008") @isSystemCreateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
