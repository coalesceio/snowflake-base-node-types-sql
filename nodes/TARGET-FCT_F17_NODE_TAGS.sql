@id("d5a70000-0000-4000-8000-000000000217")
@nodeType("SQLFact")
@materializationType("table")
@tag("Cost_Centre", "HR")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f17001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f17002"),
     "REGIONKEY" AS "REGION_KEY" @id("f17003"),
     "CommenT" AS "NATION_COMMENT" @id("f17004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f17008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f17009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
