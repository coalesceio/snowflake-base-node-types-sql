@id("bfa7c067-40a7-4c98-8c1f-355451115e83")
@nodeType("718")
@description("TC13 - zero key on changeTracking SCD2 (two node params: numeric columns take -1, strings N/A)")
@mergeStrategy("changeTracking")
@zeroKey("-1", "'N/A'")
@tests("SELECT COUNT(*) FROM {{ this }} WHERE DIM_TC13_ZK_CT_SCD2_KEY = -1 HAVING COUNT(*) <> 1", true, "After")
SELECT
     0 AS "DIM_TC13_ZK_CT_SCD2_KEY" @id("433cdb") @isSurrogateKey,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("899b36") @isBusinessKey @not_null @min_value("-1") @inHash("GH_NATION", 1),
     "N_NAME" AS "N_NAME" @id("ed59c8") @isChangeTracking @inHash("GH_NATION", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("0e9f8a") @isChangeTracking,
     "N_COMMENT" AS "N_COMMENT" @id("9c7e36"),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("fbce42"),
     "N_DATE" AS "N_DATE" @id("328f0e"),
     {{ get_hash('GH_NATION', 'MD5') }}::STRING AS "GH_NATION" @id("ee0365"),
     1 AS "SYSTEM_VERSION" @id("9a96e7") @isSystemVersion,
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("3ceac1") @isSystemCurrentFlag,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("9b9a76") @isSystemCreateDate,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("bb5941") @isSystemUpdateDate,
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("18227d") @isSystemEndDate
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
