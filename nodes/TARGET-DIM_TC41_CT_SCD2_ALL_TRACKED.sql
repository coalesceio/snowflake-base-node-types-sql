@id("7b95c00f-62e4-41d5-b0a7-5213b1e7c93d")
@nodeType("718")
@description("TC41 - changeTracking SCD2 with every attribute marked @isChangeTracking (no in-place update branch)")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT
     0 AS "DIM_TC41_CT_SCD2_ALL_TRACKED_KEY" @id("f1613c") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("4d26fa") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("be6012") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("3c1c76") @isChangeTracking,
     "N_COMMENT" AS "N_COMMENT" @id("b8c225") @isChangeTracking,
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("f0f510") @isChangeTracking,
     "N_DATE" AS "N_DATE" @id("c737f6") @isChangeTracking,
     1 AS "SYSTEM_VERSION" @id("ef078e") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("98ca11") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("e148a2") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("8d909e") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("c20c57") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
