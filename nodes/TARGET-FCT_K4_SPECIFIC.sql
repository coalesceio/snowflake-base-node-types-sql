@id("d5a70000-0000-4000-8000-000000000504")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("upsert")
@tag("OWNER", "Ops")
@description("K4 fact switched to upsert")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("e40001") @isBusinessKey @clusterKey(1),
     CAST("name" AS VARCHAR(40)) AS "NATION_NAME" @id("e40002") @tag("PII", "false"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("e4000a") @clusterKey(2),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e40008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e40009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
