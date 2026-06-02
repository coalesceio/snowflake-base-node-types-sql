@id("20725a58-8725-4b3d-9349-d06af38d6e24")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")
@testsEnabled(true)
@preContinueOnFailure(true)
@preTests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
@postContinueOnFailure(true)
@postTests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @tests('null'),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"