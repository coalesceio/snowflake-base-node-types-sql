@id("d5a70000-0000-4000-8000-000000000020")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t09-c1"),
     "name"       AS "NATION_NAME"    @id("t09-c2")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
