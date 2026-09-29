@id("929d1c9b-e75b-4f76-83de-bc90159638d2")
@nodeType("718")
@description("TC20 - @writeMode truncateInsert on changeTracking SCD1 (full reload each run)")
@mergeStrategy("changeTracking")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT
     0 AS "DIM_TC20_TRUNCATE_CT_SCD1_KEY" @id("770676") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("8c9b8a") @isBusinessKey @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @id("ad9191"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("7c610e"),
     "N_COMMENT" AS "N_COMMENT" @id("9f4f3d"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("d6e70e"),
     "N_DATE" AS "N_DATE" @id("17e423"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("7c36ee") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("18c499") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
