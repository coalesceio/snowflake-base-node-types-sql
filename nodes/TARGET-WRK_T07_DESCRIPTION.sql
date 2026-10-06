@id("d5a70000-0000-4000-8000-000000000018")
@nodeType("SQLWork")
@materializationType("table")
@description("T07: original description")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t07-c1"),
     "name"       AS "NATION_NAME"    @id("t07-c2") @description("Original column description"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t07-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
