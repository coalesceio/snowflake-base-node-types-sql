@id("61c8e8b1-3595-42c8-a7b2-f27ceea24978")
@nodeType("718")
@description("TC33 - NEGATIVE: changeTracking SCD1 without SYSTEM_CREATE_DATE/SYSTEM_UPDATE_DATE (expect Missing Required System Columns)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC33_WARN_SCD1_MISSING_CREATE_UPDATE_KEY" @id("af8dfa") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("497c46") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("08fd99"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("2d03f4"),
     "N_COMMENT" AS "N_COMMENT" @id("08cd5f"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("9063cd"),
     "N_DATE" AS "N_DATE" @id("9c9f93")
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
