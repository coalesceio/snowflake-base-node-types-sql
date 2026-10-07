@id("d5a70000-0000-4000-8000-000000000015")
@nodeType("SQLWork")
@materializationType("transient table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t04-c1"),
     "name"       AS "NATION_NAME"    @id("t04-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t04-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t04-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
