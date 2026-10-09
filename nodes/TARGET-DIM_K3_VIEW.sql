@id("d5a70000-0000-4000-8000-000000000403")
@nodeType("SQLDimension")
@materializationType("view")
@description("K3 view")
@tag("Cost_Centre", "FIN")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("d30001") @isBusinessKey,
     "name" AS "NATION_NAME" @id("d30002") @tag("PII", "true") @tag("OWNER", "Data") @description("Nation name"),
     "REGIONKEY" AS "REGION_KEY" @id("d30003") @tag("Cost_Centre", "FIN"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("d30008") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("d30009") @isSystemUpdateDate
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
