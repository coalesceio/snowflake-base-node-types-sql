@id("4642ba38-da53-497e-8cf8-79acfa85c51c")
@nodeType("662")
@groupByAll(true)
@secureoption(true)
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY",
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"