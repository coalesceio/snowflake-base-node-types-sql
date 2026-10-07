@id("d5a70000-0000-4000-8000-000000000026")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t15-c1") @clusterKey(2),
     "name"       AS "NATION_NAME"    @id("t15-c2")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
