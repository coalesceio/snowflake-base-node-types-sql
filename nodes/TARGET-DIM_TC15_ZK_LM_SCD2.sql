@id("021d8497-8338-474f-b374-57ff0ee34d77")
@nodeType("718")
@description("TC15 - zero key on lastModified SCD2 (all four node params, surrogate key -1)")
@mergeStrategy("lastModified")
@zeroKey("-1", "'UNKNOWN'", "1900-01-01 00:00:00", false)
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_TC15_ZK_LM_SCD2_KEY = -1 HAVING COUNT(*) <> 1", true, "After")
SELECT
     0 AS "DIM_TC15_ZK_LM_SCD2_KEY" @id("c5314c") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("4c944e") @isBusinessKey @not_null @min_value("-1") @inHash("GH_NATION", 1),
     "N_NAME" AS "N_NAME" @id("9c86e7") @inHash("GH_NATION", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("210149"),
     "N_COMMENT" AS "N_COMMENT" @id("2360ea"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("93413f") @lastModifiedTracking(2),
     "N_DATE" AS "N_DATE" @id("c762b6"),
     {{ get_hash('GH_NATION') }}::STRING AS "GH_NATION" @id("abf190"),
     1 AS "SYSTEM_VERSION" @id("44fcee") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("808090") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("20cdf4") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("ee2c11") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("d9b56f") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
