@id("d5a70000-0000-4000-8000-000000000035")
@nodeType("SQLWork")
@materializationType("table")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t24-c1"),
     CAST("name" AS VARCHAR(60)) AS "NATION_NAME" @id("t24-c2"),
     "CommenT"    AS "COMMENT_TEXT"   @id("t24-c4"),
     "REGIONKEY" * 10 AS "REGION_SCORE" @id("t24-c5")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
