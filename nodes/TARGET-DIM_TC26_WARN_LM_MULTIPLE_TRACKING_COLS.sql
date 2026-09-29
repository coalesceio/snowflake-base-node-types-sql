@id("8eb4dbf6-b95d-47d1-a209-8f21e0f8566f")
@nodeType("718")
@description("TC26 - NEGATIVE: lastModified with two @lastModifiedTracking columns (expect Invalid Last Modified Column)")
@mergeStrategy("lastModified")
SELECT
     0 AS "DIM_TC26_WARN_LM_MULTIPLE_TRACKING_COLS_KEY" @id("d6d64b") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("fad989") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("90c506"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("d097a3"),
     "N_COMMENT" AS "N_COMMENT" @id("6c19b5"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("ac6e4c") @lastModifiedTracking(1),
     "N_DATE" AS "N_DATE" @id("192687") @lastModifiedTracking(1),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e81c29") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("a04e68") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
