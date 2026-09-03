@id("22a99837-9b2f-4da0-85ea-ecaab57ab6d5")
@nodeType("704")
@writeMode("truncateInsert ")
@tests
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"