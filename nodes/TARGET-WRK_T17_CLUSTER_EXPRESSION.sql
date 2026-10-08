@id("d5a70000-0000-4000-8000-000000000028")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t17-c1"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t17-c3"),
     SUBSTR("name", 1, 2) AS "NAME_PREFIX" @id("t17-c4") @clusterKey(1)
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
