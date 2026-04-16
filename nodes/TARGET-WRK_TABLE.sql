@id("ef23dea2-46c4-4015-89c6-f5b1fcbb7a64")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @tests("null", "unique"),
     "N_NAME" AS "N_NAME" @tests("null"),
     "N_REGIONKEY" AS "N_REGIONKEY" @tests("unique"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"