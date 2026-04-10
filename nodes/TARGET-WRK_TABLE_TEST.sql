@id("6a9f1c4d-2f76-429b-b6e0-b45748ac735f")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")
@preSQL("ALTER SESSION SET TIMEZONE = 'UTC'", "ALTER SESSION SET TIMEZONE = 'UTC'")
@postSQL("ALTER SESSION SET TIMEZONE = 'UTC'", "ALTER SESSION SET TIMEZONE = 'UTC'")
@preTests("continueOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "continuEOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postTests("SELECT * FROM {{ this }} WHERE N_NAME IS NULL", "SELECT * FROM {{ this }} WHERE N_REGIONKEY < 0")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME" @tests('null'),
     "N_REGIONKEY" AS "N_REGIONKEY"  @tests('NULL', 'unique'),
     "N_COMMENT" AS "N_COMMENT" @tests('unique'),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"