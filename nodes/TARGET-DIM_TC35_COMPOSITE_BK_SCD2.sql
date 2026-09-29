@id("9f6a6d34-f5e4-436c-bc98-150ea84a49ec")
@nodeType("718")
@description("TC35 - changeTracking SCD2 with a composite business key (N_NATIONKEY + N_REGIONKEY)")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY, N_REGIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY, N_REGIONKEY HAVING COUNT(*) > 1", false)
SELECT
     0 AS "DIM_TC35_COMPOSITE_BK_SCD2_KEY" @id("e20ea9") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("a7a68a") @isBusinessKey @not_null,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("e5270e") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("718f4d") @isChangeTracking,
     "N_COMMENT" AS "N_COMMENT" @id("fb34a2"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("88a104"),
     "N_DATE" AS "N_DATE" @id("8e80ad"),
     1 AS "SYSTEM_VERSION" @id("fac6c2") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("619ca3") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("be8ac0") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("3b5ccb") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("07134e") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
