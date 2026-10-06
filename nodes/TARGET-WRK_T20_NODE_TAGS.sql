@id("d5a70000-0000-4000-8000-000000000031")
@nodeType("SQLWork")
@materializationType("table")
@tag("Cost_Centre", "HR")
@tag("PII", "true")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t20-c1"),
     "name"       AS "NATION_NAME"    @id("t20-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t20-c3"),
     "CommenT"    AS "NATION_COMMENT" @id("t20-c4")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
