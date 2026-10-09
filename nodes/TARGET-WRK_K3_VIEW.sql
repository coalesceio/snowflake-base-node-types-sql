@id("d5a70000-0000-4000-8000-000000000303")
@nodeType("SQLWork")
@materializationType("view")
@description("K3 view")
@tag("Cost_Centre", "FIN")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("c30001"),
     "name" AS "NATION_NAME" @id("c30002") @tag("PII", "true") @tag("OWNER", "Data") @description("Nation name"),
     "REGIONKEY" AS "REGION_KEY" @id("c30003") @tag("Cost_Centre", "FIN")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
