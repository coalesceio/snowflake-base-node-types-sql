@id("d5a70000-0000-4000-8000-000000000009")
@nodeType("SQLWork")
@materializationType("view")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("v09-c1"),
     "name"       AS "NATION_NAME"    @id("v09-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("v09-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("v09-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
