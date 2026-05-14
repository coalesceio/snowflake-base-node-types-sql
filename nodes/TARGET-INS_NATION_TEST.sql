@id("2182f347-3873-46d2-b042-e1da6841df4c")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable("false"),
     "N_NAME" AS "N_NAME" @description("nation name") @defaultValue("NA")
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable("false"),
     "N_COMMENT" AS "N_COMMENT",
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"