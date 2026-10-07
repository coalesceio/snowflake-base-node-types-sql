@id("d5a70000-0000-4000-8000-000000000007")
@nodeType("SQLWork")
@materializationType("view")
@description("V07: changed description")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v07-c1"),
     "name"       AS "NATION_NAME"    @id("v07-c2") @description("Changed column description"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v07-c3")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
