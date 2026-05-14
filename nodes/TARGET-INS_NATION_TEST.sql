@id("2182f347-3873-46d2-b042-e1da6841df4c")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@preTests("SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1", "continuEOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1") 

@postTests("continueOnFailure: SELECT * FROM {{ this }} WHERE N_NAME IS NULL", "SELECT * FROM {{ this }} WHERE N_REGIONKEY < 0") 

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"