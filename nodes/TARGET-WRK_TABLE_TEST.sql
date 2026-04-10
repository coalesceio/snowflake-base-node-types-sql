@id("4f627343-c408-42fe-a13c-f145b79fdd94")
@nodeType("7b516fbe-d586-4d1b-ab79-f3b494bbcd4e")
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