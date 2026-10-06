@id("d5a70000-0000-4000-8000-000000000024")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t13-c1"),
     "name"       AS "NATION_NAME"    @id("t13-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t13-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t13-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
