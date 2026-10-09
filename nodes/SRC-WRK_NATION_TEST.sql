@id("6b0e6616-f8c2-49c2-a9ef-2ec3c778accf")
@nodeType("Latest:::707")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @min_value(0),
     "N_NAME" AS "N_NAME" @accepted_values("'NA'"),
     "N_REGIONKEY" AS "N_REGIONKEY" @accepted_values("0") @accepted_values(0),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @min_value("TO_TIMESTAMP(2026-01-01)")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"