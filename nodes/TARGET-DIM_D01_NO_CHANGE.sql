@id("d5a70000-0000-4000-8000-000000000101")
@nodeType("SQLDimension")
@materializationType("table")
@description("D01: created once, never changed")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d01001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("d01002") @tag("PII", "true") @description("Nation name"),
     "REGIONKEY" AS "REGION_KEY" @id("d01003"),
     "CommenT" AS "NATION_COMMENT" @id("d01004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d01008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d01009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
