@id("d5a70000-0000-4000-8000-000000000032")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t21-c1") @tag("PII", "false"),
     "name"       AS "NATION_NAME"    @id("t21-c2") @tag("PII", "true"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t21-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
