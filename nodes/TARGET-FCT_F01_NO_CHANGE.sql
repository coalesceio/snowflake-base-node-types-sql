@id("d5a70000-0000-4000-8000-000000000201")
@nodeType("SQLFact")
@materializationType("table")
@description("F01: created once, never changed")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("f01001") @isBusinessKey @clusterKey(1),
     "name" AS "NATION_NAME" @id("f01002") @tag("PII", "true") @description("Nation name"),
     "REGIONKEY" AS "REGION_KEY" @id("f01003"),
     "CommenT" AS "NATION_COMMENT" @id("f01004"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f01008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f01009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
