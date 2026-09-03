@id("262c24ea-5eb6-4740-9526-d8fc87e6867a")
@nodeType("707")
@writeMode("truncateInsert")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @uniqueness,
     "N_NAME" AS "N_NAME" @empty,
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('TARGET', 'WRK_NATION_TEST_V1_VIEW') }} "WRK_NATION_TEST_V1_VIEW"