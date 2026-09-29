@id("c3aac4e7-7e18-49f9-a524-46efe85c9e10")
@nodeType("718")
@description("TC12 - zero key on changeTracking SCD1 (all four node params; column overrides on key and comment)")
@mergeStrategy("changeTracking")
@zeroKey("0", "'UNKNOWN'", "1900-01-01 00:00:00", true)
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_TC12_ZK_CT_SCD1_KEY = 0 HAVING COUNT(*) <> 1", true, "After")
SELECT
     0 AS "DIM_TC12_ZK_CT_SCD1_KEY" @id("af76fb") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("eaa9dd") @isBusinessKey @not_null @uniqueness @zeroKey("-1") @min_value("-1") @inHash("GH_NATION", 1),
     "N_NAME" AS "N_NAME" @id("d79e47") @not_null @inHash("GH_NATION", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("f880e9") @zeroKey("-1"),
     "N_COMMENT" AS "N_COMMENT" @id("82dbe9") @zeroKey("'NO COMMENT'"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("86e853"),
     "N_DATE" AS "N_DATE" @id("442be9"),
     {{ get_hash('GH_NATION') }}::STRING AS "GH_NATION" @id("522099"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("a1962f") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("a40a0b") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
