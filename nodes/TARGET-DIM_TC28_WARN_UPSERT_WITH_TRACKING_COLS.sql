@id("302c6738-116a-47b4-89f0-163c16a66d73")
@nodeType("718")
@description("TC28 - NEGATIVE: upsert with @isChangeTracking and @lastModifiedTracking columns (expect non-blocking warning, loads as upsert)")
@mergeStrategy("upsert")
SELECT
     0 AS "DIM_TC28_WARN_UPSERT_WITH_TRACKING_COLS_KEY" @id("8c0f7b") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("fafa98") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("47d330") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("79fcdf"),
     "N_COMMENT" AS "N_COMMENT" @id("603368"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("7bad27") @lastModifiedTracking(2),
     "N_DATE" AS "N_DATE" @id("10b034"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("0d20ff") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("33bf19") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
