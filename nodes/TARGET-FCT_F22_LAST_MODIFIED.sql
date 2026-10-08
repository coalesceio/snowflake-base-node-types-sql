@id("d5a70000-0000-4000-8000-000000000222")
@nodeType("SQLFact")
@materializationType("table")
@mergeStrategy("lastModified")
@description("F22: description added")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f22001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("f22002") @description("Name, last modified"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("f2200a") @lastModifiedTracking,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f22008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f22009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
