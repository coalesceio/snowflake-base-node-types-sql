@id("d5a70000-0000-4000-8000-000000000033")
@nodeType("SQLWork")
@materializationType("table")
@tag("Cost_Centre", "FIN", "SRC")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t22-c1"),
     "name"       AS "NATION_NAME"    @id("t22-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t22-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t22-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
