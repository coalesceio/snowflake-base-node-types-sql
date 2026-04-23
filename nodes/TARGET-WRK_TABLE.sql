@id("ef23dea2-46c4-4015-89c6-f5b1fcbb7a64")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

/* Adding a comment */

@truncateBefore
@selectDistinct

@preSQL("SELECT count(*) FROM {{ this }}", "SELECT count(*) FROM {{ this }}")

@preTests("SELECT 1 FROM {{ this }} GROUP BY N_REGIONKEY HAVING COUNT(*) > 1", "continuEOnFailure:SELECT 1 FROM {{ this }} GROUP BY N_COMMENT HAVING COUNT(*) > 1")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable(),
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"