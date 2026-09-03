@id("4dd6e5eb-9abe-4e64-a799-3c55bfe6f03a")
@nodeType("707")
SELECT 
     "N_NATIONKEY" AS "N_NATIONKEY" @max_value("100"),
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" ,
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('TARGET', 'STG_NATION_TEST_VIEW') }} "STG_NATION_TEST_VIEW"
WHERE {{ parameters.nationkey }} > 2