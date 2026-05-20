@id("b1c6336d-3831-4833-84a7-11c7267a228c")
@nodeType("6fda2820-4404-4b60-bad3-cf0edd7dab92")

SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @nullable("false") @defaultValue(100),
     "N_NAME" AS "N_NAME" @description("Name"),
     "N_REGIONKEY" AS "N_REGIONKEY" @nullable("false") @defaultValue(0),
     "N_COMMENT" AS "N_COMMENT" @description("comment"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP",
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE"
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"