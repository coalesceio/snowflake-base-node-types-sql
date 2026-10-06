@id("d5a70000-0000-4000-8000-000000000008")
@nodeType("SQLWork")
@materializationType("view")
@tests("SELECT 1 WHERE 1 = 0", true, "After")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v08-c1"),
     "name"       AS "NATION_NAME"    @id("v08-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v08-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("v08-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
