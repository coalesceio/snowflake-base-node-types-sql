@id("d5a70000-0000-4000-8000-000000000028")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t17-c1"),
     "name"       AS "NATION_NAME"    @id("t17-c2") @clusterKey(1),
     "REGIONKEY"  AS "REGION_KEY"     @id("t17-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
