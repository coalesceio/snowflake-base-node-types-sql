@id("d5a70000-0000-4000-8000-000000000119")
@nodeType("SQLDimension")
@materializationType("table")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} WHERE 1 = 0", true, "After")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d19001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d19002"),
     "REGIONKEY" AS "REGION_KEY" @id("d19003"),
     "CommenT" AS "NATION_COMMENT" @id("d19004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d19008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d19009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
