@id("5231d09d-9f2f-4472-afa9-8b03bac877d2")
@nodeType("707")
@materializationType("view")
@disableTests
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @min_max("0", "100"),
     "N_NAME" AS "N_NAME" @not_null,
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"