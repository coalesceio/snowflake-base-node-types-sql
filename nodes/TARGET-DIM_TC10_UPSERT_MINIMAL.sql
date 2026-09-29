@id("3e1a3eaf-b7fd-4989-b202-4bd8154a8abe")
@nodeType("718")
@description("TC10 - upsert with only a business key: no surrogate key and no system columns (both optional for upsert)")
@mergeStrategy("upsert")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @id("bac804") @isBusinessKey @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @id("3537c1"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("ac3d0d"),
     "N_COMMENT" AS "N_COMMENT" @id("08a1fe"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("4a3fed"),
     "N_DATE" AS "N_DATE" @id("5b63bc")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
