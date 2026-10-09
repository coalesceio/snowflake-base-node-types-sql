@id("d5a70000-0000-4000-8000-000000000303")
@nodeType("SQLWork")
@materializationType("view")
@description("K3 view")
@tag("Cost_Centre", "HR")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("c30001") @tag("OWNER", "Keys"),
     "name" AS "NATION_NAME" @id("c30002") @tag("PII", "false") @description("Nation name"),
     "REGIONKEY" AS "REGION_KEY" @id("c30003")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
