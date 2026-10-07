@id("d5a70000-0000-4000-8000-000000000012")
@nodeType("SQLWork")
@materializationType(" Table ")
@description("T01: deployed once, no change in phase 2")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t01-c1") @clusterKey(1),
     "name"       AS "NATION_NAME"    @id("t01-c2") @description("Nation name") @tag("PII", "true") @clusterKey(2, "substr(""NATION_NAME"", 1, 3)"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t01-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t01-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
