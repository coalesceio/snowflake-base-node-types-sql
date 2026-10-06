@id("d5a70000-0000-4000-8000-000000000001")
@nodeType("SQLWork")
@materializationType("view")
@description("V01: deployed once, no change in phase 2")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v01-c1"),
     "name"       AS "NATION_NAME"    @id("v01-c2") @description("Nation name") @tag("PII", "true"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v01-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
