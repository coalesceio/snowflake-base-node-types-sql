@id("d5a70000-0000-4000-8000-000000000303")
@nodeType("SQLWork")
@materializationType("view")
@description("K3 view - recreated")
@tag("Cost_Centre", "OPS")
@tag("PII", "true")
SELECT
     "NAtionKey" AS "NATION_KEY" @id("c30001") @tag("OWNER", "Keys"),
     UPPER("name") AS "NATION_NAME" @id("c30002") @tag("PII", "false"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("c3000a") @tag("OWNER", "Data")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
