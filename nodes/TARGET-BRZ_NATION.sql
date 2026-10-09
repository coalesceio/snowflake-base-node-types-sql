@id("b8a7d817-ce78-4a3a-8e88-79ea95532c8a")
@nodeType("Latest220:::SQLWork")
@description("Bronze: SRC.Nation_Test with standard column names (SQL Work)")
SELECT
    "NAtionKey"        AS "NATION_KEY"     @id("453bc9") @description("Nation identifier"),
    "name"             AS "NATION_NAME"    @id("dbbfd5"),
    "REGIONKEY"        AS "REGION_KEY"     @id("fc480e"),
    "CommenT"          AS "NATION_COMMENT" @id("061344"),
    "N_Load_Timestamp" AS "SOURCE_LOAD_TS" @id("f3a661")
FROM {{ ref('SRC', 'Nation_Test') }} "Nation_Test"
