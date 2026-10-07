@id("d5a70000-0000-4000-8000-000000000041")
@nodeType("SQLWork")
@materializationType("table")
@tag("OWNER", "Tanvi")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t27-c1"),
     "name"       AS "NATION_NAME"    @id("t27-c2")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
