@id("d5a70000-0000-4000-8000-000000000134")
@nodeType("SQLDimension")
@materializationType("view")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d34001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d34002"),
     "REGIONKEY" AS "REGION_KEY" @id("d34003"),
     "CommenT" AS "NATION_COMMENT" @id("d34004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d34008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d34009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
