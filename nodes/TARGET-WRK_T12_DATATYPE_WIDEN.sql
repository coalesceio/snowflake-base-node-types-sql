@id("d5a70000-0000-4000-8000-000000000023")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t12-c1"),
     CAST("name" AS VARCHAR(100)) AS "NATION_NAME" @id("t12-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t12-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
