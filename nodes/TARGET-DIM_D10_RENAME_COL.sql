@id("d5a70000-0000-4000-8000-000000000110")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d10001") @isBusinessKey,
     "name" AS "COUNTRY_NAME" @id("d10002"),
     "REGIONKEY" AS "REGION_KEY" @id("d10003"),
     "CommenT" AS "NATION_COMMENT" @id("d10004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d10008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d10009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
