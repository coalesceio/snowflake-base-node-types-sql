@id("918a28c7-07d1-4e89-b776-9ddf03c0106a")
@nodeType("718")
@description("TC23 - NEGATIVE: upsert with no @isBusinessKey (expect Missing Business Key)")
@mergeStrategy("upsert")
SELECT
     "N_NATIONKEY" AS "N_NATIONKEY" @id("86cb94"),
     "N_NAME" AS "N_NAME" @id("4157f8"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("29f5fe"),
     "N_COMMENT" AS "N_COMMENT" @id("cc82b1"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("9794f9"),
     "N_DATE" AS "N_DATE" @id("e96418")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
