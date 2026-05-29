@id("12156311-df03-4045-acff-ebe61d9fb056")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @tests("null", "unique")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"