@id("d5a70000-0000-4000-8000-000000000135")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d35001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d35002"),
     "REGIONKEY" AS "REGION_KEY" @id("d35003"),
     "CommenT" AS "NATION_COMMENT" @id("d35004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d35008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d35009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
