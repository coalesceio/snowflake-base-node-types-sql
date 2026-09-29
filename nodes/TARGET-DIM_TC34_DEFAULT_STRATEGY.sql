@id("3ff26515-12b6-4d99-ae77-a2a05a1453e7")
@nodeType("718")
@description("TC34 - no @mergeStrategy or @writeMode given: defaults to changeTracking SCD1, append")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT
     0 AS "DIM_TC34_DEFAULT_STRATEGY_KEY" @id("63798d") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("423a47") @isBusinessKey @not_null @uniqueness,
     "N_NAME" AS "N_NAME" @id("b376ec"),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("52c061"),
     "N_COMMENT" AS "N_COMMENT" @id("3147a7"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("c2d64f"),
     "N_DATE" AS "N_DATE" @id("024bd4"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("bce07c") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("6120de") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
