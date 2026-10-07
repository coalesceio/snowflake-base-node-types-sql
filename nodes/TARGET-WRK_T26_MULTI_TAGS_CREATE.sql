@id("d5a70000-0000-4000-8000-000000000040")
@nodeType("SQLWork")
@materializationType("table")
@tag("Cost_Centre", "FIN")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t26-c1"),
     "name"       AS "NATION_NAME"    @id("t26-c2") @tag("PII", "true") @tag("OWNER", "Tanvi"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t26-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
