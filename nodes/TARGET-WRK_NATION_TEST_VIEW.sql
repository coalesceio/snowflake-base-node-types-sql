@id("2a77fc94-f426-4db8-ae12-db44553ba07a")
@nodeType("707")
@materializationType("view")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @not_null,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY",
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('TARGET', 'STG_NATION_TEST_VIEW') }} "STG_NATION_TEST_VIEW"