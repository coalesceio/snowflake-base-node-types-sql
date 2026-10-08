@id("d5a70000-0000-4000-8000-000000000221")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("upsert")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f21001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f21002"),
     "REGIONKEY" AS "REGION_KEY" @id("f21003"),
     "CommenT" AS "NATION_COMMENT" @id("f21004")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
