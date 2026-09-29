@id("1ed4cdf2-c8a0-41b9-bd0c-9c2f5b2506cf")
@nodeType("718")
@description("TC39 - SELECT DISTINCT modifier on a changeTracking SCD2 load")
@mergeStrategy("changeTracking")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
SELECT DISTINCT
     0 AS "DIM_TC39_SELECT_DISTINCT_CT_SCD2_KEY" @id("4c6796") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("cb0844") @isBusinessKey @not_null,
     "N_NAME" AS "N_NAME" @id("759488") @isChangeTracking,
     "N_REGIONKEY" AS "N_REGIONKEY" @id("1cd42a"),
     "N_COMMENT" AS "N_COMMENT" @id("a50850"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("71e7d0"),
     "N_DATE" AS "N_DATE" @id("4fdd1b"),
     1 AS "SYSTEM_VERSION" @id("4c01b1") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("2e4e11") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("1c7948") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("6aad7e") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d31dd2") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
