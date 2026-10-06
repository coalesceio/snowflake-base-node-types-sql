@id("d5a70000-0000-4000-8000-000000000035")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t24-c1"),
     CAST("name" AS VARCHAR(25)) AS "NATION_NAME" @id("t24-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t24-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t24-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
