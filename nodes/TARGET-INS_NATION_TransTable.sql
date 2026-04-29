@id("4f1a8713-1b5a-4fc6-8d21-20aa2756089e")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@materializationType("transient table")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"