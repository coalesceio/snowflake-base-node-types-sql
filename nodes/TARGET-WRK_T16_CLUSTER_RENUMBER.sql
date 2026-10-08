@id("d5a70000-0000-4000-8000-000000000027")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_ID"      @id("t16-c1") @clusterKey(10),
     "name"       AS "NATION_NAME"    @id("t16-c2"),
     "REGIONKEY" * 10 AS "REGION_BUCKET" @id("t16-c4") @clusterKey(30),
     SUBSTR("name", 1, 2) AS "NAME_PREFIX" @id("t16-c5") @clusterKey(40)
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
