@id("d5a70000-0000-4000-8000-000000000106")
@nodeType("SQLDimension")
@materializationType("table")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d06001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d06002"),
     "REGIONKEY" AS "REGION_KEY" @id("d06003"),
     "CommenT" AS "NATION_COMMENT" @id("d06004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d06008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d06009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
