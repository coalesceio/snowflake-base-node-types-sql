@id("d5a70000-0000-4000-8000-000000000117")
@nodeType("SQLDimension")
@materializationType("table")
@tag("Cost_Centre", "HR")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d17001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d17002"),
     "REGIONKEY" AS "REGION_KEY" @id("d17003"),
     "CommenT" AS "NATION_COMMENT" @id("d17004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d17008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d17009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
