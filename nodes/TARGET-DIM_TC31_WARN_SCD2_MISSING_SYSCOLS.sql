@id("793e4f12-0f45-4532-8ff7-f17dd2ff934a")
@nodeType("718")
@description("TC31 - NEGATIVE: changeTracking SCD2 without version/current flag/end date (expect Missing Required System Columns)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC31_WARN_SCD2_MISSING_SYSCOLS_KEY" @id("4eeb71") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("82daff") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("6ef05d") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("df1ba0"),
     "N_COMMENT" AS "N_COMMENT" @id("804a1b"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("c7cbb0"),
     "N_DATE" AS "N_DATE" @id("627a52"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e23edf") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("9f491d") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
