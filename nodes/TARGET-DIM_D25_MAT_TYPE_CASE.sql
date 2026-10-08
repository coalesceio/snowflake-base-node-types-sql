@id("d5a70000-0000-4000-8000-000000000125")
@nodeType("SQLDimension")
@materializationType("  TABLE")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d25001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d25002"),
     "REGIONKEY" AS "REGION_KEY" @id("d25003"),
     "CommenT" AS "NATION_COMMENT" @id("d25004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d25008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d25009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
