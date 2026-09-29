@id("21b004c2-a389-49f1-b29d-033b50fff374")
@nodeType("718")
@description("TC30 - NEGATIVE: lastModified with an @isChangeTracking column (expect non-blocking warning, column ignored)")
@mergeStrategy("lastModified")
SELECT
     0 AS "DIM_TC30_WARN_LM_WITH_CT_COL_KEY" @id("898c59") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("db7ee2") @isBusinessKey,
     "N_NAME" AS "N_NAME" @id("71c568") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("a8501b"),
     "N_COMMENT" AS "N_COMMENT" @id("25fd53"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("224ace") @lastModifiedTracking(2),
     "N_DATE" AS "N_DATE" @id("5fb76b"),
     1 AS "SYSTEM_VERSION" @id("093c55") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("7eb187") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("977e05") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("1f9692") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("a85b70") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
