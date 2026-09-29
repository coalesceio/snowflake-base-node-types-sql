@id("8c6bffef-a1f3-496f-98c8-9803aeb161e7")
@nodeType("718")
@description("TC40 - bare @lastModifiedTracking (no scdType, defaults to SCD1) on a DATE column")
@mergeStrategy("lastModified")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT
     0 AS "DIM_TC40_LM_BARE_DATE_COL_KEY" @id("cd7e35") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("538329") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("3a7eea"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("b288ef"),
     "N_COMMENT" AS "N_COMMENT" @id("6fbea4"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("bad3b3"),
     "N_DATE" AS "N_DATE" @id("e12270") @lastModifiedTracking @not_null,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0b5e56") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("fbc0a5") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
