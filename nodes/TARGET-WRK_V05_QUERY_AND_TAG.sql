@id("d5a70000-0000-4000-8000-000000000005")
@nodeType("SQLWork")
@materializationType("view")
@tag("Cost_Centre", "HR")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v05-c1"),
     "name"       AS "NATION_NAME"    @id("v05-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v05-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("v05-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
WHERE "REGIONKEY" IS NOT NULL
