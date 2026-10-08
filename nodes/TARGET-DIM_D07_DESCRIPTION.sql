@id("d5a70000-0000-4000-8000-000000000107")
@nodeType("SQLDimension")
@materializationType("table")
@description("D07: changed description")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d07001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d07002") @description("Changed column description"),
     "REGIONKEY" AS "REGION_KEY" @id("d07003"),
     "CommenT" AS "NATION_COMMENT" @id("d07004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d07008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d07009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
