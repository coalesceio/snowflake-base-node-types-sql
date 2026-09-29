@id("1f4934ce-9a90-4bd9-a4a7-9aa71bdf71d4")
@nodeType("718")
@description("TC14 - zero key on lastModified SCD1 (three node params; column-level DATE override)")
@mergeStrategy("lastModified")
@zeroKey("0", "'UNKNOWN'", "2000-01-01 00:00:00")
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_TC14_ZK_LM_SCD1_KEY = 0 HAVING COUNT(*) <> 1", true, "After")
SELECT
     0 AS "DIM_TC14_ZK_LM_SCD1_KEY" @id("8345dc") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("7dc985") @isBusinessKey @not_null @zeroKey("-1") @min_value("-1") @inHash("GH_NATION", 1),
     "N_NAME" AS "N_NAME" @id("f34cf3") @inHash("GH_NATION", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("33ca1b") @zeroKey("-1"),
     "N_COMMENT" AS "N_COMMENT" @id("e9bba4"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("6e422e") @lastModifiedTracking(1),
     "N_DATE" AS "N_DATE" @id("6946ef") @zeroKey("CAST('1900-01-01' AS DATE)"),
     {{ get_hash('GH_NATION', 'SHA256') }}::STRING AS "GH_NATION" @id("20ebad"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("87ec2b") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("c41223") @isSystemUpdateDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
