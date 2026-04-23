@id("9769741f-a1fe-452c-b970-5e9b9d75f72b")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

@preSQL("select count(*) from {{this}}")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION') }} "NATION"