@id("84f6c77e-cf7d-4239-9afa-05a13c54c820")
@nodeType("718")
@description("TC24 - NEGATIVE: surrogate key, N_NAME and SYSTEM_UPDATE_DATE have no @id (expect Missing Column IDs)")
@mergeStrategy("changeTracking")
SELECT
     0 AS "DIM_TC24_WARN_MISSING_COL_IDS_KEY" @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("99e07b") @isBusinessKey,
     "N_NAME" AS "N_NAME",
     "N_REGIONKEY" AS "N_REGIONKEY" @id("9b92df"),
     "N_COMMENT" AS "N_COMMENT" @id("1929bc"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("fdb205"),
     "N_DATE" AS "N_DATE" @id("09e41a"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("ea1414") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
