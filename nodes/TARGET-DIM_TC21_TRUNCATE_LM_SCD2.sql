@id("be62dc4e-31f3-43e8-a911-2b49a5bf3a4d")
@nodeType("718")
@description("TC21 - @writeMode truncateInsert on lastModified SCD2 (history is wiped each run, so every row is version 1)")
@mergeStrategy("lastModified")
@writeMode("truncateInsert")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_VERSION <> 1 OR SYSTEM_CURRENT_FLAG <> 'Y'", true)
SELECT
     0 AS "DIM_TC21_TRUNCATE_LM_SCD2_KEY" @id("6e0e46") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("2bc3a7") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("7560a2"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("406404"),
     "N_COMMENT" AS "N_COMMENT" @id("acfcac"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("48ca4c") @lastModifiedTracking(2),
     "N_DATE" AS "N_DATE" @id("454e00"),
     1 AS "SYSTEM_VERSION" @id("e2c24d") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("e7206c") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0ac448") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("f43258") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("9e6cb6") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
