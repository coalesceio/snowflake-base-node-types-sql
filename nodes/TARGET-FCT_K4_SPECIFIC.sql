@id("d5a70000-0000-4000-8000-000000000504")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("lastModified")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("e40001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("e40002") @tag("PII", "true"),
     "REGIONKEY" AS "REGION_KEY" @id("e40003"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("e40005") @lastModifiedTracking,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e40008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e40009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
