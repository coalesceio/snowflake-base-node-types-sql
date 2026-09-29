@id("868ba42b-b0c9-49c6-aad8-ce2925af44dc")
@nodeType("718")
@description("TC01 - changeTracking SCD1 with column + node level DQ tests and @inHash (SHA1)")
@mergeStrategy("changeTracking")
@tests("SELECT 1 FROM {{ this }} GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE N_REGIONKEY NOT BETWEEN 0 AND 4", true, "After")
@tests("SELECT 1 FROM {{ this }} WHERE N_NAME IS NULL", true, "Before")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_UPDATE_DATE < SYSTEM_CREATE_DATE")
SELECT
     0 AS "DIM_TC01_CT_SCD1_TESTS_KEY" @id("5190e3") @isSurrogateKey @not_null @uniqueness,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("b9d047") @isBusinessKey @not_null @uniqueness @min_max(0, 24),
     "N_NAME" AS "N_NAME" @id("776957") @not_null @empty @rejected_values("'UNKNOWN'", "'N/A'") @inHash("GH_NATION", 1),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("99c412") @not_null @accepted_values("0, 1, 2, 3, 4") @min_value(0) @max_value(4),
     "N_COMMENT" AS "N_COMMENT" @id("dd1e84") @empty @inHash("GH_NATION", 2),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("561517") @freshness(30, "DAY"),
     "N_DATE" AS "N_DATE" @id("5cda13") @min_max("'1900-01-01'", "CURRENT_DATE()") @freshness(1, "YEAR"),
     {{ get_hash('GH_NATION') }}::STRING AS "GH_NATION" @id("8c40b5") @not_null @uniqueness,
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("b347cb") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_UPDATE_DATE"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("1ec4a8") @isSystemUpdateDate @not_null
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
