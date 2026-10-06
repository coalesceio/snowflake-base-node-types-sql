@id("d5a70000-0000-4000-8000-000000000004")
@nodeType("SQLWork")
@materializationType("view")
@tag("Cost_Centre", "FIN")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v04-c1"),
     "name"       AS "NATION_NAME"    @id("v04-c2") @tag("PII", "true"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v04-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
