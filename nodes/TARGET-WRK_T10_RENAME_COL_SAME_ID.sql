@id("d5a70000-0000-4000-8000-000000000021")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t10-c1"),
     "name"       AS "COUNTRY_NAME"   @id("t10-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t10-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t10-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
