@id("d5a70000-0000-4000-8000-000000000030")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_ID"      @id("t19-c1") @clusterKey(1),
     "name"       AS "NATION_NAME"    @id("t19-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t19-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
