@id("d5a70000-0000-4000-8000-000000000103")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d03001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d03002"),
     "REGIONKEY" AS "REGION_KEY" @id("d03003"),
     "CommenT" AS "NATION_COMMENT" @id("d03004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d03008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d03009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
