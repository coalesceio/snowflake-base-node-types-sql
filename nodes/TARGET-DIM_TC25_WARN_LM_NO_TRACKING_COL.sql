@id("374bbe48-2950-41db-a07c-0155359202d8")
@nodeType("718")
@description("TC25 - NEGATIVE: lastModified with no @lastModifiedTracking column (expect hard failure)")
@mergeStrategy("lastModified")
SELECT
     0 AS "DIM_TC25_WARN_LM_NO_TRACKING_COL_KEY" @id("f898a0") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("3f35cd") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("ddadb2"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("1a3c5a"),
     "N_COMMENT" AS "N_COMMENT" @id("94da27"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("05d1a4"),
     "N_DATE" AS "N_DATE" @id("26f6d6"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("28fd07") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("56f7fb") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
