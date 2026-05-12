@id("06e64389-9619-46b8-bdc5-39c7f759c404")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")
@selectDistinct(true)
@testsEnabled(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"