@id("d5a70000-0000-4000-8000-000000000122")
@nodeType("SQLDimension")
@materializationType("table")
@mergeStrategy("lastModified")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d22001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d22002"),
     "N_Load_Timestamp" AS "LOAD_TS" @id("d2200a") @lastModifiedTracking(1),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d22008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d22009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
