@id("d5a70000-0000-4000-8000-000000000019")
@nodeType("SQLWork")
@materializationType("table")
SELECT
     "NAtionKey"  AS "NATION_KEY"     @id("t08-c1"),
     "name"       AS "NATION_NAME"    @id("t08-c2"),
     "REGIONKEY"  AS "REGION_KEY"     @id("t08-c3") @description("Region key") @tag("PII", "false"),
     "CommenT"    AS "NATION_COMMENT" @id("t08-c4"),
     TRUE         AS "LOAD_FLAG"      @id("t08-c5")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
