@id("4419d72a-9d62-44ad-82f2-f5fcf34a6f55")
@nodeType("718")
@description("TC27 - NEGATIVE: @lastModifiedTracking(3) is not a valid scdType (expect Invalid scdType)")
@mergeStrategy("lastModified")
SELECT
     0 AS "DIM_TC27_WARN_LM_INVALID_SCDTYPE_KEY" @id("2a7b0f") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("dd8d88") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("5774f3"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("ad97b0"),
     "N_COMMENT" AS "N_COMMENT" @id("fd08a4"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("2617b7") @lastModifiedTracking(3),
     "N_DATE" AS "N_DATE" @id("85e34f"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("dc4f50") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("e685ee") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
