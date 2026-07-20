@id("387b4361-9ebd-487a-8119-f9ca34d2d7d1")
@nodeType("661")
@testsEnabled(true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "Before", true)
@tests("SELECT * FROM {{ this }} WHERE N_NAME IS NULL", "After", true)
@tests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "After", true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @tests('null'),
     "N_NAME" AS "N_NAME" @tests("unique"),
     "N_REGIONKEY" AS "N_REGIONKEY" ,
     "N_COMMENT" AS "N_COMMENT" @tests("unique", 'null'),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"