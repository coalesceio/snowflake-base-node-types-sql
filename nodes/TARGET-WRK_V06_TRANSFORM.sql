@id("d5a70000-0000-4000-8000-000000000006")
@nodeType("SQLWork")
@materializationType("view")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v06-c1"),
     UPPER("name") AS "NATION_NAME"   @id("v06-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v06-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("v06-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
