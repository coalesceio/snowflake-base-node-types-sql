@id("9282c9e5-66e0-448b-86d5-a81857174f44")
@nodeType("718")
@description("TC02 - changeTracking SCD2 (N_NAME/N_REGIONKEY tracked, N_COMMENT updated in place) with DQ tests and MD5/SHA256 hashes")
@mergeStrategy("changeTracking")
@writeMode("append")
@tests("SELECT N_NATIONKEY FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'Y' GROUP BY N_NATIONKEY HAVING COUNT(*) > 1", false, "After")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_CURRENT_FLAG = 'N' AND SYSTEM_END_DATE = '2999-12-31 00:00:00'", true, "After")
@tests("SELECT 1 FROM {{ this }} WHERE SYSTEM_VERSION < 1", true, "Before")
SELECT
     0 AS "DIM_TC02_CT_SCD2_TESTS_KEY" @id("b81a70") @isSurrogateKey @not_null @uniqueness,
     "N_NATIONKEY" AS "N_NATIONKEY" @id("8d736e") @isBusinessKey @not_null @min_max(0, 24),
     "N_NAME" AS "N_NAME" @id("f7af35") @isChangeTracking @not_null @empty @inHash("GH_NATION_MD5", 1) @inHash("GH_NATION_SHA256", 2),
     "N_REGIONKEY" AS "N_REGIONKEY" @id("e25b12") @isChangeTracking @accepted_values("0", "1", "2", "3", "4") @inHash("GH_NATION_MD5", 2),
     "N_COMMENT" AS "N_COMMENT" @id("6f2eb7") @inHash("GH_NATION_SHA256", 1),
     "N_LOAD_TIMESTAMP" AS "N_LOAD_TIMESTAMP" @id("629271") @freshness(4, "WEEK"),
     "N_DATE" AS "N_DATE" @id("06a121") @max_value("CURRENT_DATE()"),
     {{ get_hash('GH_NATION_MD5', 'MD5') }}::STRING AS "GH_NATION_MD5" @id("1ab75d") @not_null,
     {{ get_hash('GH_NATION_SHA256', algo='SHA256', delimiter='~') }}::STRING AS "GH_NATION_SHA256" @id("293b8e") @not_null,
     1 AS "SYSTEM_VERSION" @id("9ceda7") @isSystemVersion @not_null @min_value(1),
     'Y' AS "SYSTEM_CURRENT_FLAG" @id("55dd5b") @isSystemCurrentFlag @not_null @accepted_values("'Y', 'N'"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_CREATE_DATE" @id("f0e081") @isSystemCreateDate @not_null @relative_time("<=", "SYSTEM_END_DATE"),
     CAST(CURRENT_TIMESTAMP AS TIMESTAMP) AS "SYSTEM_UPDATE_DATE" @id("b87706") @isSystemUpdateDate @not_null @relative_time(">=", "SYSTEM_CREATE_DATE"),
     CAST('2999-12-31 00:00:00' AS TIMESTAMP) AS "SYSTEM_END_DATE" @id("13dad4") @isSystemEndDate @not_null
FROM {{ ref('SRC', 'NATION_TEST') }} "NATION_TEST"
