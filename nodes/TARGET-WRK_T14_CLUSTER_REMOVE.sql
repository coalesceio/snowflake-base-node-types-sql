@id("d5a70000-0000-4000-8000-000000000025")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t14-c1") @clusterKey(1),
     "name"       AS "NATION_NAME"    @id("t14-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t14-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
