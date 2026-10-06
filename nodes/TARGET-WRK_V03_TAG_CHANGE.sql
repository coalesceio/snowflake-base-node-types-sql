@id("d5a70000-0000-4000-8000-000000000003")
@nodeType("SQLWork")
@materializationType("view")
@tag("Cost_Centre", "HR")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v03-c1"),
     "name"       AS "NATION_NAME"    @id("v03-c2") @tag("PII", "false"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v03-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
